Model :: struct {
    nodes:     [..]Node;
}

Node :: struct {
    local_transform: Matrix4 = Matrix4_Identity;

    meshes:       [..]Mesh;
    parent_index: Option(u32);
    children_ids: [..]u32;
}

Mesh :: struct {
    vertex_start: u32;
    vertex_count: u32;
    index_start:  u32;
    index_count:  u32;

    min: Vector3;
    max: Vector3;

    material_index: u32;
}

Texture :: struct {
    image_index:   u32;
    sampler_index: u32;
}

Material :: struct @Gpu {
    base_color_factor:        Vector4 = { 1, 1, 1, 1 };
    base_color_texture_index: u32 = FALLBACK_COLOR_TEXTURE_ID;

    metallic_factor:                  float = 1;
    roughness_factor:                 float = 1;
    metallic_roughness_texture_index: u32 = FALLBACK_METALLIC_ROUGHNESS_TEXTURE_ID;

    normal_scale:         float = 1;
    normal_texture_index: u32 = FALLBACK_NORMAL_TEXTURE_ID;

    occlusion_strength:      float = 1;
    occlusion_texture_index: u32 = FALLBACK_OCCLUSION_TEXTURE_ID;

    emissive_factor:        Vector3;
    emissive_texture_index: u32 = FALLBACK_EMISSIVE_TEXTURE_ID;

    alpha_cutoff: float = 0.5;
    alpha_mode:   Alpha_Mode;
    double_sided: u32; // 0 or 1
}

Vertex :: struct @Gpu {
    position: Vector3;
    color:    Vector4 = { 1, 1, 1, 1 };
    normal:   Vector3;
    uv:       Vector2;
    tangent:  Vector4 = { 1, 0, 0, 1 };
}

Alpha_Mode :: enum u32 #specified {
    OPAQUE :: 0;
    MASK   :: 1;
    BLEND  :: 2;
}


#scope_file

#import "Option";
