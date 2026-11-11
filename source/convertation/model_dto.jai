#scope_module

SUPPORTED_MAX_TEX_COORD :: #run -> int {
    tis := cast(*Type_Info_Struct, type_info(Vertex_Dto));

    count: int;
    for member: tis.members {
        if starts_with(member.name, "uv") {
            count += 1;
        }
    }

    return count - 1;
};

Model_Dto :: struct {
    name:      string;

    nodes:     [..]Node_Dto;
    meshes:    [..]Mesh_Dto;
    materials: [..]Material_Dto;
    images:    [..]Image_Dto;
    animations: [..]Animation_Dto;
}

Node_Dto :: struct {
    name:             string;

    parent_index:     Option(u32);
    children_indices: [..]u32;

    first_mesh_index: Option(u32);
    mesh_count:       u32;

    local_translation: Vector3;
    local_rotation:    Quaternion = { 0, 0, 0, 1 };
    local_scale:       Vector3 = { 1, 1, 1 };
}

Mesh_Dto :: struct {
    name: string;

    vertices: [..]Vertex_Dto;
    indices:  [..]u32;
    topology: Topology_Mode_Dto = .TRIANGLES;

    min: Vector3;
    max: Vector3;

    material_index: Option(u32);
}

Vertex_Dto :: struct {
    position: Vector3;
    normal:   Vector3;
    uv0:      Vector2;
    tangent:  Vector4 = { 1, 0, 0, 1 };
    color:    Vector4 = { 1, 1, 1, 1 };
}

Material_Dto :: struct {
    name: string;

    double_sided: bool;
    alpha_mode:   Alpha_Mode_Dto;
    alpha_cutoff: float = 0.5;

    pbr_metallic_roughness: Pbr_Metallic_Roughness_Dto;
    normal_texture:         Option(Normal_Texture_Dto);
    occlusion_texture:      Option(Occlusion_Texture_Dto);
    emissive_texture:       Option(Texture_Dto);
    emissive_factor:        Vector3;
}

Pbr_Metallic_Roughness_Dto :: struct {
    base_color_factor: Vector4 = { 1, 1, 1, 1 };
    metallic_factor:   float   = 1;
    roughness_factor:  float   = 1;

    base_color_texture:         Option(Texture_Dto);
    metallic_roughness_texture: Option(Texture_Dto);
}

Normal_Texture_Dto :: struct {
    scale:   float = 1;
    texture: Texture_Dto;
}

Occlusion_Texture_Dto :: struct {
    strength: float = 1;
    texture:  Texture_Dto;
}

Texture_Dto :: struct {
    name: string;

    image_index: u32;
    tex_coord:   u32;

    mag_filter: Mag_Filter_Dto = .UNDEFINED;
    min_filter: Min_Filter_Dto = .UNDEFINED;
    wrap_s:     Wrap_Mode_Dto  = .REPEAT;
    wrap_t:     Wrap_Mode_Dto  = .REPEAT;
}

Image_Dto :: struct {
    name:  string;
    bytes: [..]u8;

    width:         u32;
    height:        u32;
    channel_count: u8;
};

Animation_Dto :: struct {
    name: string;
    duration: float;
    tracks: [..]Animation_Track_Dto;
}

Animation_Track_Dto :: struct {
    node_index:      u32;
    path:            Animation_Path_Dto;
    interpolation:   Animation_Interpolation_Dto;
    keyframe_times:  [..]float;
    keyframe_values: [..]float;
}

Animation_Interpolation_Dto :: enum {
    LINEAR;
    STEP;
}

Animation_Path_Dto :: enum {
    TRANSLATION;
    ROTATION;
    SCALE;
}

Alpha_Mode_Dto :: enum {
    OPAQUE;
    MASK;
    BLEND;
}

Wrap_Mode_Dto :: enum {
    CLAMP_TO_EDGE;
    MIRRORED_REPEAT;
    REPEAT;
}

Topology_Mode_Dto :: enum {
    POINTS;
    LINES;
    LINE_LOOP;
    LINE_STRIP;
    TRIANGLES;
    TRIANGLE_STRIP;
    TRIANGLE_FAN;
}

Mag_Filter_Dto :: enum {
    UNDEFINED;
    NEAREST;
    LINEAR;
}

Min_Filter_Dto :: enum {
    UNDEFINED;
    NEAREST;
    LINEAR;
    NEAREST_MIPMAP_NEAREST;
    LINEAR_MIPMAP_NEAREST;
    NEAREST_MIPMAP_LINEAR;
    LINEAR_MIPMAP_LINEAR;
}

destroy :: (model_dto: *Model_Dto) {
    log("Model_Dto: Destroying %", model_dto.name);

    free(model_dto.name);

    for animation_dto: model_dto.animations {
        free(animation_dto.name);
        for track: animation_dto.tracks {
            array_free(track.keyframe_times);
            array_free(track.keyframe_values);
        }
        array_free(animation_dto.tracks);
    }
    array_free(model_dto.animations);

    for node: model_dto.nodes {
        free(node.name);
        array_free(node.children_indices);
    }
    array_free(model_dto.nodes);

    for mesh: model_dto.meshes {
        free(mesh.name);
        array_free(mesh.vertices);
        array_free(mesh.indices);
    }
    array_free(model_dto.meshes);

    for material: model_dto.materials {
        free(material.name);

        if material.pbr_metallic_roughness.base_color_texture.kind == .SOME {
            free(material.pbr_metallic_roughness.base_color_texture.some.name);
        }

        if material.pbr_metallic_roughness.metallic_roughness_texture.kind == .SOME {
            free(material.pbr_metallic_roughness.metallic_roughness_texture.some.name);
        }

        if material.normal_texture.kind == .SOME {
            free(material.normal_texture.some.texture.name);
        }

        if material.occlusion_texture.kind == .SOME {
            free(material.occlusion_texture.some.texture.name);
        }

        if material.emissive_texture.kind == .SOME {
            free(material.emissive_texture.some.name);
        }
    }
    array_free(model_dto.materials);

    for image: model_dto.images {
        free(image.name);
        array_free(image.bytes);
    }
    array_free(model_dto.images);

    model_dto.* = {};
}
