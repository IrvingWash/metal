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
    texture_cache: Texture_Cache;
    for material_dto: model_dto.materials {
        pbr := material_dto.pbr_metallic_roughness;

        material: Renderer.Material;
        material.base_color_factor = pbr.base_color_factor;
        material.metallic_factor   = pbr.metallic_factor;
        material.roughness_factor  = pbr.roughness_factor;
        material.emissive_factor   = material_dto.emissive_factor;
        material.alpha_cutoff      = material_dto.alpha_cutoff;
        material.alpha_mode        = convert_alpha_mode_dto(material_dto.alpha_mode);
        material.base_color_texture_index         = Renderer.FALLBACK_COLOR_TEXTURE_ID;
        material.normal_texture_index             = Renderer.FALLBACK_NORMAL_TEXTURE_ID;
        material.metallic_roughness_texture_index = Renderer.FALLBACK_METALLIC_ROUGHNESS_TEXTURE_ID;
        material.occlusion_texture_index          = Renderer.FALLBACK_OCCLUSION_TEXTURE_ID;
        material.emissive_texture_index           = Renderer.FALLBACK_EMISSIVE_TEXTURE_ID;

        error: string;
        if pbr.base_color_texture.kind == .SOME {
            error, material.base_color_texture_index =
                get_or_upload_texture(*texture_cache, *model_dto, pbr.base_color_texture.some, .SRGB);
            if error {
                return error, renderer_model;
            }
        }
        if pbr.metallic_roughness_texture.kind == .SOME {
            error, material.metallic_roughness_texture_index =
                get_or_upload_texture(*texture_cache, *model_dto, pbr.metallic_roughness_texture.some, .UNORM);
            if error {
                return error, renderer_model;
            }
        }
        if material_dto.normal_texture.kind == .SOME {
            normal_texture_dto := material_dto.normal_texture.some;
            material.normal_scale = normal_texture_dto.scale;
            error, material.normal_texture_index = get_or_upload_texture(
                *texture_cache,
                *model_dto,
                normal_texture_dto.texture,
                .UNORM,
            );
            if error {
                return error, renderer_model;
            }
        }
        if material_dto.occlusion_texture.kind == .SOME {
            occlusion_texture_dto := material_dto.occlusion_texture.some;
            material.occlusion_strength = occlusion_texture_dto.strength;
            error, material.occlusion_texture_index =
                get_or_upload_texture(*texture_cache, *model_dto, occlusion_texture_dto.texture, .UNORM);
            if error {
                return error, renderer_model;
            }
        }
        if material_dto.emissive_texture.kind == .SOME {
            error, material.emissive_texture_index =
                get_or_upload_texture(*texture_cache, *model_dto, material_dto.emissive_texture.some, .SRGB);
            if error {
                return error, renderer_model;
            }
        }

        error=, material_ids := Renderer.upload_materials(
            *state.renderer,
            .[material],,
            temp,
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

convert_alpha_mode_dto :: (dto_alpha_mode: Alpha_Mode_Dto) -> Renderer.Alpha_Mode {
    if #complete dto_alpha_mode == {
        case .OPAQUE;
            return .OPAQUE;
        case .MASK;
            return .MASK;
        case .BLEND;
            return .BLEND;
    }
}

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
        case .NEAREST;
            params.min_filter = .NEAREST;
            params.mipmap_mode = .NEAREST;
        case .LINEAR;
            params.min_filter = .LINEAR;
            params.mipmap_mode = .NEAREST;
        case .NEAREST_MIPMAP_NEAREST;
            params.min_filter = .NEAREST;
            params.mipmap_mode = .NEAREST;
        case .LINEAR_MIPMAP_NEAREST;
            params.min_filter = .LINEAR;
            params.mipmap_mode = .NEAREST;
        case .NEAREST_MIPMAP_LINEAR;
            params.min_filter = .NEAREST;
            params.mipmap_mode = .LINEAR;
        case .LINEAR_MIPMAP_LINEAR;
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

Texture_Cache_Key :: #type u64;

Texture_Cache :: struct {
    image_id_by_key:   Table(Texture_Cache_Key, u32); // (image_dto_index << 1) | is_unorm
    texture_id_by_key: Table(Texture_Cache_Key, u32); // (renderer_image_id << 32) | sampler_id
    sampler_id_by_key: Table(Texture_Cache_Key, u32);

    image_id_by_key.allocator   = temp;
    texture_id_by_key.allocator = temp;
    sampler_id_by_key.allocator = temp;
}

get_or_upload_texture :: (
    cache:        *Texture_Cache,
    model_dto:    *Model_Dto,
    texture_dto:  Texture_Dto,           // whatever the type of `.some` is
    format_kind:  type_of(Renderer.Image_Params.format_kind),
) -> error: string, texture_id: u32 {
    image_id: u32;
    { // Image
        image_key: Texture_Cache_Key = (cast(u64, texture_dto.image_index) << 1)
            | cast(u64, format_kind == .UNORM);

        found:, image_id = table_find(*cache.image_id_by_key, image_key);
        if !found {
            image_dto := model_dto.images[texture_dto.image_index];
            error, image_ids := Renderer.upload_texture_images(
                *state.renderer,
                .[{
                    width       = image_dto.width,
                    height      = image_dto.height,
                    bytes       = image_dto.bytes,
                    format_kind = format_kind,
                }],,
                temp
            );
            if error {
                return error, 0;
            }

            image_id = image_ids[0];
            table_set(*cache.image_id_by_key, image_key, image_id);
        }
    }

    sampler_id: u32;
    { // Sampler
        sampler_key: Texture_Cache_Key =
              cast(u64, texture_dto.mag_filter)
            | cast(u64, texture_dto.min_filter) << 16
            | cast(u64, texture_dto.wrap_s)     << 32
            | cast(u64, texture_dto.wrap_t)     << 48;

        found:, sampler_id = table_find(*cache.sampler_id_by_key, sampler_key);
        if !found {
            error:, sampler_id = create_sampler_from_texture_dto(texture_dto);
            if error {
                return error, 0;
            }
            table_set(*cache.sampler_id_by_key, sampler_key, sampler_id);
        }
    }

    texture_id: u32;
    { // Texture (image + sampler)
        texture_key := (cast(u64, image_id) << 32) | cast(u64, sampler_id);
        found:, texture_id = table_find(*cache.texture_id_by_key, texture_key);
        if !found {
            error, texture_ids := Renderer.upload_textures(
                *state.renderer,
                .[{ image_index = image_id, sampler_index = sampler_id }],,
                temp
            );
            if error {
                return error, 0;
            }

            texture_id = texture_ids[0];
            table_set(*cache.texture_id_by_key, texture_key, texture_id);
        }
    }

    return "", texture_id;
}

#import "System";
#import "String";
#import "Math";
#import "File";
#import "Option";
#import "Hash_Table";

#load "convertation/model_dto.jai";
#load "convertation/gltf_converter.jai";
