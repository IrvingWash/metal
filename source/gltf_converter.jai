convert_gltf :: (path: string) {
    error: string = ---;
    gltf: Gltf.Gltf = ---;
    if ends_with(path, "gltf") {
        error, gltf = Gltf.read_gltf_from_file(path);
    } else {
        error, gltf = Gltf.read_glb_from_file(path);
    }
    assert(!error, error);
    assert(gltf.scenes.count == 1, "Multiple scenes are not supported");

    model_dto: Model_Dto;

    gltf_scene := gltf.scenes[0];
    model_dto.name = copy_string(gltf_scene.name);

    for gltf_mesh: gltf.meshes {
        for gltf_primitive: gltf_mesh.primitives {
            mesh_dto := convert_glft_primitive_to_mesh_dto(
                gltf,
                gltf_mesh,
                gltf_primitive,
            );
            array_add(*model_dto.meshes, mesh_dto);
        }
    }

    print("%\n", model_dto);
}



#scope_file

Model_Dto :: struct {
    name:      string;

    nodes:     []Node_Dto;
    meshes:    [..]Mesh_Dto;
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

convert_glft_primitive_to_mesh_dto :: (
    gltf: Gltf.Gltf,
    gltf_mesh: Gltf.Mesh,
    gltf_primitive: Gltf.Mesh.Primitive,
) -> Mesh_Dto {
    mesh_dto: Mesh_Dto;

    mesh_dto.name = copy_string(gltf_mesh.name);

    mesh_dto.topology = gltf_primitive.mode;

    if gltf_primitive._material != Gltf.SENTINEL {
        set(*mesh_dto.material_index, cast(u32, gltf_primitive._material));
    }

    if gltf_primitive._indices != Gltf.SENTINEL {
        gltf_indices_accessor := gltf.accessors[gltf_primitive._indices];
        mesh_dto.indices = parse_indices(gltf, gltf_primitive, gltf_indices_accessor);
    }

    return mesh_dto;
}

parse_indices :: (gltf: Gltf.Gltf, gltf_primitive: Gltf.Mesh.Primitive, gltf_indices_accessor: Gltf.Accessor) -> []u32 {
    assert(gltf_indices_accessor.sparse._count == Gltf.SENTINEL, "Sparse accessors are not supported");
    assert(gltf_indices_accessor._buffer_view != Gltf.SENTINEL, "Got an accessor without a buffer view");
    assert(gltf_indices_accessor.type == .SCALAR, "Indices accessor must be be scalar");
    gltf_indices_buffer_view := gltf.buffer_views[gltf_indices_accessor._buffer_view];
    assert(gltf_indices_buffer_view._byte_stride == Gltf.SENTINEL, "Indices accessor should not have byte_stride");
    gltf_indices_buffer := gltf.buffers[gltf_indices_buffer_view.buffer];

    component_size := get_size_from_gltf_component_type(gltf_indices_accessor.component_type);
    byte_count := gltf_indices_accessor.count * component_size;
    data_offset := gltf_indices_accessor.byte_offset + gltf_indices_buffer_view.byte_offset;

    {
        span_in_buffer := data_offset + byte_count;
        span_in_view   := gltf_indices_accessor.byte_offset + byte_count;

        assert(
            span_in_buffer <= gltf_indices_buffer.bytes.count,
            "The span of indices is more than the number of bytes",
        );
        assert(
            span_in_view <= gltf_indices_buffer_view.byte_length,
            "The span of indices is more than the byte length of the buffer view",
        );
        assert(
            span_in_buffer <= gltf_indices_buffer.byte_length,
            "The span of indices is more than the byte length of the buffer",
        );
    }

    gltf_indices_bytes := gltf_indices_buffer.bytes.data + data_offset;

    result := NewArray(gltf_indices_accessor.count, u32, initialized = false);
    if #complete gltf_indices_accessor.component_type == {
        case .BYTE; #through;
        case .SHORT; #through;
        case .FLOAT;
            assert(false, "Indices component type can't be BYTE, SHORT or FLOAT");
        case .UNSIGNED_BYTE;
            for 0 .. result.count - 1 {
                result[it] = gltf_indices_bytes[it];
            }
        case .UNSIGNED_SHORT;
            casted := cast(*u16, gltf_indices_bytes);
            for 0 .. result.count - 1 {
                result[it] = casted[it];
            }
        case .UNSIGNED_INT;
            memcpy(
                result.data,
                gltf_indices_bytes,
                byte_count,
            );
    }

    return result;
}

get_size_from_gltf_component_type :: (gltf_component_type: Gltf.Accessor.Component_Type) -> u32 {
    if #complete gltf_component_type == {
        case .BYTE;
            return size_of(s8);
        case .UNSIGNED_BYTE;
            return size_of(u8);
        case .SHORT;
            return size_of(s16);
        case .UNSIGNED_SHORT;
            return size_of(u16);
        case .UNSIGNED_INT;
            return size_of(u32);
        case .FLOAT;
            return size_of(float32);
    }
}

get_component_count_from_gltf_accessor_type :: (gltf_accessor_type: Gltf.Accessor._Type) -> u32 {
    if #complete gltf_accessor_type == {
        case .SCALAR;
            return 1;
        case .VEC2;
            return 2;
        case .VEC3;
            return 3;
        case .VEC4;
            return 4;
        case .MAT2;
            return 4;
        case .MAT3;
            return 9;
        case .MAT4;
            return 16;
    }
}

#import "String";
#import "Math";
Gltf :: #import,dir "Gltf";
#import,dir "Option";
