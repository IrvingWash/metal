Asset_Manager :: struct {
    root_path:    string;
    shaders_path: string;
}

init_asset_manager :: () -> Asset_Manager {
    asset_manager: Asset_Manager;

    asset_manager.root_path = copy_string(
        path_strip_filename(
            get_path_of_running_executable(),
        )
    );
    asset_manager.shaders_path = path_join(asset_manager.root_path, "shaders");

    return asset_manager;
}

deinit_asset_manager :: (asset_manager: *Asset_Manager) {
    free(asset_manager.root_path);
    free(asset_manager.shaders_path);

    asset_manager.* = {};
}

asset_manager_get_compiled_shader :: (asset_manager: Asset_Manager, name: string) -> error: string, string {
    path := path_join(asset_manager.shaders_path, name,, temp);

    content, ok := read_entire_file(path);
    if !ok {
        return
            tprint("Failed to read shader file at '%'", path),
            content;
    }

    return "", content;
}

// @Todo: In the future, this will just upload our own binaries.
// The convertation would be run via a script, like shader compilation
asset_manager_upload_model :: (asset_manager: *Asset_Manager, path: string) -> error: string, Renderer.Model {
    renderer_model: Renderer.Model;

    maybe_model_dto: Option(Model_Dto);

    extension := path_extension(path);
    if array_find(GLTF_FILE_EXTENSIONS, extension) {
        error, result := convert_gltf(path, DEBUG);
        if error {
            return error, renderer_model;
        }

        set(*maybe_model_dto, result);
    }

    if maybe_model_dto.kind != .SOME {
        return
            tprint("Unsupported model format: '%'", extension),
            renderer_model;
    }

    model_dto := maybe_model_dto.some;
    defer destroy(*model_dto);

    uploaded_renderer_material_ids: [..]u32;
    uploaded_renderer_material_ids.allocator = temp;
    renderer_base_color_texture_id_by_image_dto_index: Table(u32, u32);
    renderer_base_color_texture_id_by_image_dto_index.allocator = temp;
    for material_dto: model_dto.materials {
        renderer_base_color_texture_id: u32;
        if material_dto.pbr_metallic_roughness.base_color_texture.kind == .SOME {
            base_color_texture_dto := material_dto.pbr_metallic_roughness.base_color_texture.some;

            found, renderer_texture_id := table_find(
                *renderer_base_color_texture_id_by_image_dto_index,
                base_color_texture_dto.image_index,
            );
            if !found {
                error, sampler_id := create_sampler_from_texture_dto(base_color_texture_dto);
                if error {
                    return error, renderer_model;
                }

                image_dto := model_dto.images[base_color_texture_dto.image_index];

                error =, image_ids := Renderer.upload_texture_images(
                    *state.renderer,
                    .[{
                        width  = image_dto.width,
                        height = image_dto.height,
                        bytes  = image_dto.bytes,
                    }],,
                    temp
                );
                if error {
                    return error, renderer_model;
                }

                error =, renderer_base_color_texture_ids := Renderer.upload_textures(
                    *state.renderer,
                    .[{
                        image_index   = image_ids[0],
                        sampler_index = sampler_id,
                    }],,
                    temp
                );
                if error {
                    return error, renderer_model;
                }
                renderer_base_color_texture_id = renderer_base_color_texture_ids[0];

                table_set(
                    *renderer_base_color_texture_id_by_image_dto_index,
                    base_color_texture_dto.image_index,
                    renderer_base_color_texture_id,
                );
            } else {
                renderer_base_color_texture_id = renderer_texture_id;
            }
        }

        error, material_ids := Renderer.upload_materials(
            *state.renderer,
            .[{
                base_color_factor        = material_dto.pbr_metallic_roughness.base_color_factor,
                base_color_texture_index = renderer_base_color_texture_id,
            }],,
            temp
        );
        if error {
            return error, renderer_model;
        }
        array_add(*uploaded_renderer_material_ids, ..material_ids);
    }

    renderer_meshes: [..]Renderer.Mesh;
    renderer_meshes.allocator = temp;
    for mesh_dto: model_dto.meshes {
        mesh: Renderer.Mesh;
        defer array_add(*renderer_meshes, mesh);

        if mesh_dto.material_index.kind == .SOME {
            mesh.material_index = uploaded_renderer_material_ids[mesh_dto.material_index.some];
        }

        if mesh_dto.indices.count > 0 {
            error, start, count := Renderer.upload_indices(
                *state.renderer,
                mesh_dto.indices,
            );
            if error {
                return error, renderer_model;
            }

            mesh.index_start = start;
            mesh.index_count = count;
        }

        if mesh_dto.vertices.count > 0 {
            converted_vertices: [..]Renderer.Vertex;
            converted_vertices.allocator = temp;
            array_resize(*converted_vertices, mesh_dto.vertices.count);
            for vertex_dto: mesh_dto.vertices {
                converted_vertices[it_index] = {
                    position = vertex_dto.position,
                    color    = vertex_dto.color,
                    normal   = vertex_dto.normal,
                    uv       = vertex_dto.uv0,
                };
            }

            error, start, count := Renderer.upload_vertices(
                *state.renderer,
                converted_vertices,
            );
            if error {
                return error, renderer_model;
            }

            mesh.vertex_start = start;
            mesh.vertex_count = count;
        }
    }

    for node_dto: model_dto.nodes {
        renderer_node: Renderer.Node;
        renderer_node.local_transform = node_dto.local_transform;
        renderer_node.parent_index = node_dto.parent_index;

        if node_dto.first_mesh_index.kind == .SOME && node_dto.mesh_count > 0 {
            first := node_dto.first_mesh_index.some;
            for first .. first + node_dto.mesh_count - 1 {
                array_add(*renderer_node.meshes, renderer_meshes[it]);
            }
        }

        array_resize(*renderer_node.children_ids, node_dto.children_indices.count);
        memcpy(
            renderer_node.children_ids.data,
            node_dto.children_indices.data,
            renderer_node.children_ids.count * size_of(u32),
        );

        array_add(
            *renderer_model.nodes,
            renderer_node,
        );
    }

    return "", renderer_model;
}



#scope_file

create_sampler_from_texture_dto :: (texture_dto: Texture_Dto) -> error: string, sampler_id: u32 {
    params: Renderer.Create_Sampler_Params;

    if #complete texture_dto.mag_filter == {
        case .UNDEFINED;
            params.mag_filter = .LINEAR;
        case .NEAREST;
            params.mag_filter = .NEAREST;
        case .LINEAR;
            params.mag_filter = .LINEAR;
    }

    if #complete texture_dto.min_filter == {
        case .UNDEFINED;
            params.min_filter = .LINEAR;
            params.mipmap_mode = .LINEAR;
        case. NEAREST;
            params.min_filter = .NEAREST;
            params.mipmap_mode = .NEAREST;
        case. LINEAR;
            params.min_filter = .LINEAR;
            params.mipmap_mode = .NEAREST;
        case. NEAREST_MIPMAP_NEAREST;
            params.min_filter = .NEAREST;
            params.mipmap_mode = .NEAREST;
        case. LINEAR_MIPMAP_NEAREST;
            params.min_filter = .LINEAR;
            params.mipmap_mode = .NEAREST;
        case. NEAREST_MIPMAP_LINEAR;
            params.min_filter = .NEAREST;
            params.mipmap_mode = .LINEAR;
        case. LINEAR_MIPMAP_LINEAR;
            params.min_filter = .LINEAR;
            params.mipmap_mode = .LINEAR;
    }

    if #complete texture_dto.wrap_s == {
        case .CLAMP_TO_EDGE;
            params.address_mode_u = .CLAMP_TO_EDGE;
        case .MIRRORED_REPEAT;
            params.address_mode_u = .MIRRORED_REPEAT;
        case .REPEAT;
            params.address_mode_u = .REPEAT;
    }

    if #complete texture_dto.wrap_t == {
        case .CLAMP_TO_EDGE;
            params.address_mode_v = .CLAMP_TO_EDGE;
        case .MIRRORED_REPEAT;
            params.address_mode_v = .MIRRORED_REPEAT;
        case .REPEAT;
            params.address_mode_v = .REPEAT;
    }

    error, sampler_index := Renderer.upload_sampler(
        *state.renderer,
        params,
    );
    if error {
        return error, 0;
    }

    return "", sampler_index;
}

#import "System";
#import "String";
#import "Math";
#import "File";
#import "Option";
#import "Hash_Table";

#load "convertation/model_dto.jai";
#load "convertation/gltf_converter.jai";
