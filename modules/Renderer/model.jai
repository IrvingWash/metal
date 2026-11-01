Model :: struct {
    nodes:     [..]Node;
    transform: Matrix4 = Matrix4_Identity;
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

    material_index: u32;
}

Texture :: struct {
    image_index:   u32;
    sampler_index: u32;
}

Material :: struct @Gpu {
    base_color_factor:        Vector4 = { 1, 1, 1, 1 };
    base_color_texture_index: u32;

    metallic_factor:                  float = 1;
    roughness_factor:                 float = 1;
    metallic_roughness_texture_index: u32;

    normal_scale:         float = 1;
    normal_texture_index: u32;

    occlusion_strength:      float = 1;
    occlusion_texture_index: u32;

    emissive_factor:        Vector3;
    emissive_texture_index: u32;

    alpha_cutoff: float = 0.5;
    alpha_mode:   Alpha_Mode;
}

Vertex :: struct @Gpu {
    position: Vector3;
    color:    Vector4 = { 1, 1, 1, 1 };
    normal:   Vector3;
    uv:       Vector2;
    tangent:  Vector4 = { 1, 0, 0, 1 };
}

Instance :: struct @Gpu {
    wvp_transform:   Matrix4;
    world_transform: Matrix4;
    material_index:  u32;
}

Alpha_Mode :: enum u32 #specified {
    OPAQUE :: 0;
    MASK   :: 1;
    BLEND  :: 2;
}


#scope_file

#import "Option";
