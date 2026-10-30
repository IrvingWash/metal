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
asset_manager_upload_model :: (asset_manager: *Asset_Manager, path: string) -> error: string {
    maybe_model_dto: Option(Model_Dto);

    extension := path_extension(path);
    if array_find(GLTF_FILE_EXTENSIONS, extension) {
        error, result := convert_gltf(path, DEBUG);
        if error {
            return error;
        }

        set(*maybe_model_dto, result);
    }

    model_dto := maybe_model_dto.some;
    defer destroy(*model_dto);

    indices_offsets:    [..]u32;
    vertices_offsets:   [..]u32;
    material_ids:       [..]u32;

    for mesh: model_dto.meshes {
        if mesh.indices.count > 0 {
            error, indices_offset := Renderer.upload_indices(
                *state.renderer,
                mesh.indices,
            );
            if error {
                return error;
            }
            array_add(*indices_offsets, indices_offset);
        }

        if mesh.vertices.count > 0 {
            converted_vertices: [..]Renderer.Vertex;
            converted_vertices.allocator = temp;
            array_resize(*converted_vertices, mesh.vertices.count);
            for vertex_dto: mesh.vertices {
                converted_vertices[it_index] = {
                    position = vertex_dto.position,
                    color    = vertex_dto.color,
                    normal   = vertex_dto.normal,
                    uv       = vertex_dto.uv0,
                };
            }

            error, vertices_offset := Renderer.upload_vertices(
                *state.renderer,
                converted_vertices,
            );
            if error {
                return error;
            }
            array_add(*vertices_offsets, vertices_offset);
        }
    }

    for material: model_dto.materials {
        base_color_texture_id: u32;
        if material.pbr_metallic_roughness.base_color_texture.kind == .SOME {
            base_color_texture := material.pbr_metallic_roughness.base_color_texture.some;

            error, sampler_id := create_sampler_from_texture_dto(base_color_texture);
            if error {
                return error;
            }

            image := model_dto.images[base_color_texture.image_index];

            error =, image_ids := Renderer.create_texture_images(
                *state.renderer,
                .[{
                    width  = image.width,
                    height = image.height,
                    bytes  = image.bytes,
                }],,
                temp
            );
            if error {
                return error;
            }

            base_color_texture_id = Renderer.add_textures(
                *state.renderer,
                .[{
                    image_index   = image_ids[0],
                    sampler_index = sampler_id,
                }],,
                temp
            )[0];
        }

        error, _material_ids := Renderer.upload_materials(
            *state.renderer,
            .[{
                base_color_factor        = material.pbr_metallic_roughness.base_color_factor,
                base_color_texture_index = base_color_texture_id,
            }],,
            temp
        );
        if error {
            return error;
        }
        array_add(*material_ids, .._material_ids);
    }

    return "";
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
        case. UNDEFINED;
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

    error, sampler_index := Renderer.create_sampler(
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

#load "asset_manager/model_dto.jai";
#load "asset_manager/gltf_converter.jai";
