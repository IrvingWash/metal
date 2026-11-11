Asset_Manager :: struct {
    root_path:    string;
    shaders_path: string;

    model_accessor_handles_by_path: Table(string, Model_Asset_Handle);

    model_assets: Bucket_Array(Model_Asset, 64);
}

Model_Asset_Handle :: #type,distinct Bucket_Locator;

Model_Asset :: struct {
    model_accessor: Renderer.Model_Accessor;
    animations:     [..]Animation;
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
    for value, key: asset_manager.model_accessor_handles_by_path {
        free(key);
    }
    deinit(*asset_manager.model_accessor_handles_by_path);

    for *model_asset: asset_manager.model_assets {
        Renderer.destroy_model_accessor(*model_asset.model_accessor);
        array_free(model_asset.animations);
    }
    bucket_array_reset(*asset_manager.model_assets);

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

asset_manager_get_model :: (asset_manager: Asset_Manager, handle: Model_Asset_Handle) -> Model_Asset {
    return bucket_array_find(*asset_manager.model_assets, cast(Bucket_Locator, handle));
}

// @Todo: In the future, this will just upload our own binaries.
// The convertation would be run via a script, like shader compilation
asset_manager_upload_model :: (
    asset_manager: *Asset_Manager,
    path:          string,
    renderer:      *Renderer.Renderer,
) -> Model_Asset_Handle {
    normalized_path := get_absolute_path(path,, temp);

    { // Check cache
        found, handle := table_find(*asset_manager.model_accessor_handles_by_path, normalized_path);
        if found {
            return handle;
        }
    }

    normalized_path = copy_string(normalized_path);

    log("Asset Manager: Uploading model at %", path);

    model_asset: Model_Asset;

    maybe_model_dto: Option(Model_Dto);
    extension := path_extension(normalized_path);
    if array_find(GLTF_FILE_EXTENSIONS, extension) {
        result := load_and_convert_gltf(normalized_path, DEBUG,, temp);

        set(*maybe_model_dto, result);
    }
    if maybe_model_dto.kind != .SOME {
        assert(false, "Failed to load model from %", path);
    }
    model_dto := maybe_model_dto.some;

    for mesh_dto: model_dto.meshes {
        assert(
            mesh_dto.topology == .TRIANGLES,
            "Model at % has meshes with unsupported topology %",
            normalized_path,
            mesh_dto.topology,
        );
    }

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
        material.double_sided      = cast(u32, material_dto.double_sided);

        material.base_color_texture_index         = Renderer.FALLBACK_COLOR_TEXTURE_ID;
        material.normal_texture_index             = Renderer.FALLBACK_NORMAL_TEXTURE_ID;
        material.metallic_roughness_texture_index = Renderer.FALLBACK_METALLIC_ROUGHNESS_TEXTURE_ID;
        material.occlusion_texture_index          = Renderer.FALLBACK_OCCLUSION_TEXTURE_ID;
        material.emissive_texture_index           = Renderer.FALLBACK_EMISSIVE_TEXTURE_ID;

        if pbr.base_color_texture.kind == .SOME {
            assert(
                pbr.base_color_texture.some.tex_coord == 0,
                "Base color texture has tex_ccord %, but we don't support that much",
                pbr.base_color_texture.some.tex_coord,
            );
            material.base_color_texture_index = get_or_upload_texture(
                renderer,
                *texture_cache,
                *model_dto,
                pbr.base_color_texture.some,
                .SRGB,
            );
        }
        if pbr.metallic_roughness_texture.kind == .SOME {
            assert(
                pbr.metallic_roughness_texture.some.tex_coord == 0,
                "Metallic roughness texture has tex_ccord %, but we don't support that much",
                pbr.metallic_roughness_texture.some.tex_coord,
            );
            material.metallic_roughness_texture_index = get_or_upload_texture(
                renderer,
                *texture_cache,
                *model_dto,
                pbr.metallic_roughness_texture.some,
                .UNORM,
            );
        }
        if material_dto.normal_texture.kind == .SOME {
            assert(
                material_dto.normal_texture.some.texture.tex_coord == 0,
                "Normal texture has tex_ccord %, but we don't support that much",
                material_dto.normal_texture.some.texture.tex_coord,
            );
            normal_texture_dto := material_dto.normal_texture.some;
            material.normal_scale = normal_texture_dto.scale;
            material.normal_texture_index = get_or_upload_texture(
                renderer,
                *texture_cache,
                *model_dto,
                normal_texture_dto.texture,
                .UNORM,
            );
        }
        if material_dto.occlusion_texture.kind == .SOME {
            assert(
                material_dto.occlusion_texture.some.texture.tex_coord == 0,
                "Occlusion texture has tex_ccord %, but we don't support that much",
                material_dto.occlusion_texture.some.texture.tex_coord,
            );
            occlusion_texture_dto := material_dto.occlusion_texture.some;
            material.occlusion_strength = occlusion_texture_dto.strength;
            material.occlusion_texture_index = get_or_upload_texture(
                renderer,
                *texture_cache,
                *model_dto,
                occlusion_texture_dto.texture,
                .UNORM,
            );
        }
        if material_dto.emissive_texture.kind == .SOME {
            assert(
                material_dto.emissive_texture.some.tex_coord == 0,
                "Emissive texture has tex_ccord %, but we don't support that much",
                material_dto.emissive_texture.some.tex_coord,
            );
            material.emissive_texture_index = get_or_upload_texture(
                renderer,
                *texture_cache,
                *model_dto,
                material_dto.emissive_texture.some,
                .SRGB,
            );
        }

        error, material_ids := Renderer.upload_materials(
            renderer,
            .[material],,
            temp,
        );
        assert(!error, error);
        array_add(*uploaded_renderer_material_ids, ..material_ids);
    }

    for mesh_dto: model_dto.meshes {
        mesh_accessor: Renderer.Mesh_Accessor;
        defer array_add(*model_asset.model_accessor.meshes, mesh_accessor);

        mesh_accessor.aabb = make_aabb(mesh_dto.min, mesh_dto.max);

        if mesh_dto.material_index.kind == .SOME {
            mesh_accessor.material_index = uploaded_renderer_material_ids[mesh_dto.material_index.some];
        }

        if mesh_dto.indices.count > 0 {
            error, start, count := Renderer.upload_indices(
                renderer,
                mesh_dto.indices,
            );
            assert(!error, error);

            mesh_accessor.index_start = start;
            mesh_accessor.index_count = count;
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
                    tangent  = vertex_dto.tangent,
                };
            }

            error, start, count := Renderer.upload_vertices(
                renderer,
                converted_vertices,
            );
            assert(!error, error);

            mesh_accessor.vertex_start = start;
            mesh_accessor.vertex_count = count;
        }
    }

    for node_dto: model_dto.nodes {
        renderer_node: Renderer.Node;
        renderer_node.local_translation = node_dto.local_translation;
        renderer_node.local_rotation = node_dto.local_rotation;
        renderer_node.local_scale = node_dto.local_scale;
        renderer_node.parent_index = node_dto.parent_index;

        if node_dto.first_mesh_index.kind == .SOME && node_dto.mesh_count > 0 {
            renderer_node.first_mesh_index = node_dto.first_mesh_index.some;
            renderer_node.mesh_count       = node_dto.mesh_count;
        }

        array_resize(*renderer_node.children_ids, node_dto.children_indices.count);
        memcpy(
            renderer_node.children_ids.data,
            node_dto.children_indices.data,
            renderer_node.children_ids.count * size_of(u32),
        );

        array_add(
            *model_asset.model_accessor.nodes,
            renderer_node,
        );
    }

    model_asset.model_accessor.aabb = make_model_aabb(model_asset.model_accessor);

    array_resize(
        *model_asset.animations,
        model_dto.animations.count,
        initialize = false,
    );
    for animation_dto: model_dto.animations {
        animation: Animation;

        animation.name = copy_string(animation_dto.name);
        animation.duration = animation_dto.duration;

        array_resize(
            *animation.tracks,
            animation_dto.tracks.count,
            initialize = false,
        );
        for track_dto: animation_dto.tracks {
            track: Animation_Track;
            defer animation.tracks[it_index] = track;

            track.node_index = track_dto.node_index;

            if #complete track_dto.interpolation == {
                case .LINEAR;
                    track.interpolation = .LINEAR;
                case .STEP;
                    track.interpolation = .STEP;
            }

            array_resize(*track.keyframe_times, track_dto.keyframe_times.count);
            memcpy(
                track.keyframe_times.data,
                track_dto.keyframe_times.data,
                track.keyframe_times.count * size_of(float),
            );

            if #complete track_dto.path == {
                case .TRANSLATION;
                    track.keyframe_values.path = .TRANSLATION;
                    array_resize(
                        *track.keyframe_values.translation,
                        track_dto.keyframe_values.count / 3,
                        initialize = false,
                    );
                    memcpy(
                        track.keyframe_values.translation.data,
                        track_dto.keyframe_values.data,
                        track_dto.keyframe_values.count * size_of(float),
                    );
                case .ROTATION;
                    track.keyframe_values.path = .ROTATION;
                    array_resize(
                        *track.keyframe_values.rotation,
                        track_dto.keyframe_values.count / 4,
                        initialize = false,
                    );
                    memcpy(
                        track.keyframe_values.rotation.data,
                        track_dto.keyframe_values.data,
                        track_dto.keyframe_values.count * size_of(float),
                    );
                case .SCALE;
                    track.keyframe_values.path = .SCALE;
                    array_resize(
                        *track.keyframe_values.scale,
                        track_dto.keyframe_values.count / 3,
                        initialize = false,
                    );
                    memcpy(
                        track.keyframe_values.scale.data,
                        track_dto.keyframe_values.data,
                        track_dto.keyframe_values.count * size_of(float),
                    );
            }
        }

        model_asset.animations[it_index] = animation;
    }

    handle := bucket_array_add(*asset_manager.model_assets, model_asset);

    table_add(*asset_manager.model_accessor_handles_by_path, normalized_path, cast(Model_Asset_Handle, handle));

    return cast(Model_Asset_Handle, handle);
}



#scope_file

make_model_aabb :: (model: Renderer.Model_Accessor) -> AABB {
    model_min := Vector3.{ FLOAT32_MAX, FLOAT32_MAX, FLOAT32_MAX };
    model_max := Vector3.{ -FLOAT32_MAX, -FLOAT32_MAX, -FLOAT32_MAX };

    visit :: (
        model: Renderer.Model_Accessor,
        node: Renderer.Node,
        parent_transform: Matrix4,
        model_min: *Vector3,
        model_max: *Vector3,
    ) {
        transform := parent_transform * make_world_transform(
            node.local_translation,
            node.local_rotation,
            node.local_scale,
        );

        if node.mesh_count > 0 {
            for mesh_index: node.first_mesh_index .. (node.first_mesh_index + node.mesh_count - 1) {
                mesh := model.meshes[mesh_index];

                transformed_mesh_aabb := transform_aabb(
                    mesh.aabb,
                    transform,
                );

                model_min.* = min(model_min, transformed_mesh_aabb.min);
                model_max.* = max(model_max, transformed_mesh_aabb.max);
            }
        }

        for child_id: node.children_ids {
            visit(model, model.nodes[child_id], transform, model_min, model_max);
        }
    }

    for node: model.nodes {
        if node.parent_index.kind == .SOME {
            continue;
        }

        visit(model, node, Matrix4_Identity, *model_min, *model_max);
    }

    return make_aabb(model_min, model_max);
}

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

create_sampler_from_texture_dto :: (texture_dto: Texture_Dto, renderer: *Renderer.Renderer) -> sampler_id: u32 {
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
            params.min_filter  = .LINEAR;
            params.mipmap_mode = .LINEAR;
            params.max_lod     = Renderer.NO_LOD_CLAMP;
        case .NEAREST;
            params.min_filter  = .NEAREST;
            params.mipmap_mode = .NEAREST;
            params.max_lod     = 0.25;
        case .LINEAR;
            params.min_filter  = .LINEAR;
            params.mipmap_mode = .NEAREST;
            params.max_lod     = 0.25;
        case .NEAREST_MIPMAP_NEAREST;
            params.min_filter  = .NEAREST;
            params.mipmap_mode = .NEAREST;
            params.max_lod     = Renderer.NO_LOD_CLAMP;
        case .LINEAR_MIPMAP_NEAREST;
            params.min_filter  = .LINEAR;
            params.mipmap_mode = .NEAREST;
            params.max_lod     = Renderer.NO_LOD_CLAMP;
        case .NEAREST_MIPMAP_LINEAR;
            params.min_filter  = .NEAREST;
            params.mipmap_mode = .LINEAR;
            params.max_lod     = Renderer.NO_LOD_CLAMP;
        case .LINEAR_MIPMAP_LINEAR;
            params.min_filter  = .LINEAR;
            params.mipmap_mode = .LINEAR;
            params.max_lod     = Renderer.NO_LOD_CLAMP;
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
        renderer,
        params,
    );
    assert(!error, error);

    return sampler_index;
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
    renderer: *Renderer.Renderer,
    cache:        *Texture_Cache,
    model_dto:    *Model_Dto,
    texture_dto:  Texture_Dto,
    format_kind:  type_of(Renderer.Image_Params.format_kind),
) -> texture_id: u32 {
    // want_mipmapping := texture_dto.min_filter != .NEAREST && texture_dto.min_filter != .LINEAR;
    want_mipmapping :: true;
    sampler_id: u32;
    { // Sampler
        sampler_key: Texture_Cache_Key =
              cast(u64, texture_dto.mag_filter)
            | cast(u64, texture_dto.min_filter) << 16
            | cast(u64, texture_dto.wrap_s)     << 32
            | cast(u64, texture_dto.wrap_t)     << 48;

        found:, sampler_id = table_find(*cache.sampler_id_by_key, sampler_key);
        if !found {
            sampler_id = create_sampler_from_texture_dto(texture_dto, renderer);
            table_set(*cache.sampler_id_by_key, sampler_key, sampler_id);
        }
    }

    image_id: u32;
    { // Image
        image_key: Texture_Cache_Key = (cast(u64, texture_dto.image_index) << 1)
            | cast(u64, format_kind == .UNORM);

        found:, image_id = table_find(*cache.image_id_by_key, image_key);
        if !found {
            image_dto := model_dto.images[texture_dto.image_index];
            error, image_ids := Renderer.upload_texture_images(
                renderer,
                .[{
                    width           = image_dto.width,
                    height          = image_dto.height,
                    bytes           = image_dto.bytes,
                    format_kind     = format_kind,
                    want_mipmapping = want_mipmapping,
                }],,
                temp
            );
            assert(!error, error);

            image_id = image_ids[0];
            table_set(*cache.image_id_by_key, image_key, image_id);
        }
    }

    texture_id: u32;
    { // Texture (image + sampler)
        texture_key := (cast(u64, image_id) << 32) | cast(u64, sampler_id);
        found:, texture_id = table_find(*cache.texture_id_by_key, texture_key);
        if !found {
            error, texture_ids := Renderer.upload_textures(
                renderer,
                .[{
                    image_index = image_id,
                    sampler_index = sampler_id,
                }],,
                temp
            );
            assert(!error, error);

            texture_id = texture_ids[0];
            table_set(*cache.texture_id_by_key, texture_key, texture_id);
        }
    }

    return texture_id;
}

#import "System";
#import "String";
#import "Math";
#import "File";
#import "Option";
#import "Hash_Table";

Renderer :: #import "Renderer";

#load "convertation/model_dto.jai";
#load "convertation/gltf_converter.jai";

#import "Bucket_Array";
