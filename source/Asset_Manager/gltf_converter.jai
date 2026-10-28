convert_gltf :: (path: string) {
    error: string = ---;
    gltf: Gltf.Gltf = ---;
    if ends_with(path, "gltf") {
        error, gltf = Gltf.load_gltf(path);
    } else {
        error, gltf = Gltf.load_glb(path);
    }

    assert(!error, error);
}



#scope_file

Model_Dto :: struct {
    name:      string;

    nodes:     []Node_Dto;
    meshes:    []Mesh_Dto;
    materials: []Material_Dto;
    images:    []Image_Dto;
}

Node_Dto :: struct {
    name:             string;

    parent_index:     Option(u32);
    children_indices: []u32;

    first_mesh_index: Option(u32);
    mesh_count:       u32;

    column_major_local_transform: Matrix4 = Matrix4_Identity;
}

Mesh_Dto :: struct {
    name: string;

    vertices: []Vertex_Dto;
    indices:  []u32;
    topology: Gltf.Mesh.Primitive.Topology_Mode = .TRIANGLES;

    min: Vector3;
    max: Vector3;

    material_index: Option(u32);
}

Vertex_Dto :: struct {
    position: Vector3;
    normal:   Vector3;
    uv0:      Vector2;
    uv1:      Vector2;
    tangent:  Vector4;
}

Material_Dto :: struct {
    name: string;

    double_sided: bool;
    alpha_mode:   Gltf.Material.Alpha_Mode;
    alpha_cutoff: float = 0.5;

    pbr_metallic_roughness: Pbr_Metallic_Roughness_Dto;
    normal_texture:         Option(Normal_Texture_Dto);
    occlusion_texture:      Option(Occlusion_Texture_Dto);
    emissive_texture:       Option(Texture_Dto);

    emissive_factor: Vector3;
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

    mag_filter: Gltf.Sampler.Mag_Filter = .UNDEFINED;
    min_filter: Gltf.Sampler.Min_Filter = .UNDEFINED;
    wrap_s:     Gltf.Sampler.Wrap_Mode  = .REPEAT;
    wrap_t:     Gltf.Sampler.Wrap_Mode  = .REPEAT;
}

Image_Dto :: union kind: enum { PATH; DATA; } {
    .PATH,, path: string;
    .DATA,, data: struct {
        data:      []u8;
        mime_type: string;
    };
};



#import "String";
#import "Math";
Gltf :: #import,dir "Gltf";
#import,dir "Option";
