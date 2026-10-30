Model :: struct {
    nodes: [..]Node;
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
}

Vertex :: struct @Gpu {
    position: Vector3;
    color:    Vector4 = { 1, 1, 1, 1 };
    normal:   Vector3;
    uv:       Vector2;
}

Instance :: struct @Gpu {
    wvp_transform:   Matrix4;
    world_transform: Matrix4;
    material_index:  u32;
}



#scope_file

#import "Option";
