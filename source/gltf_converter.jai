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

    nodes:     [..]Node_Dto;
    meshes:    [..]Mesh_Dto;
    materials: [..]Material_Dto;
    images:    [..]Image_Dto;
}

Node_Dto :: struct {
    name:             string;

    parent_index:     Option(u32);
    children_indices: [..]u32;

    first_mesh_index: Option(u32);
    mesh_count:       u32;

    column_major_local_transform: Matrix4 = Matrix4_Identity;
}

Mesh_Dto :: struct {
    name: string;

    vertices: [..]Vertex_Dto;
    indices:  [..]u32;
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
    tangent:  Vector4 = { 0, 0, 0, 1 };
    color:    Vector4 = { 1, 1, 1, 1 };
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
        data:      [..]u8;
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
        mesh_dto.indices = parse_gltf_indices(gltf, gltf_indices_accessor);
    }

    if gltf_primitive.attributes._position != Gltf.SENTINEL {
        gltf_position_accessor := gltf.accessors[gltf_primitive.attributes._position];
        array_resize(*mesh_dto.vertices, gltf_position_accessor.count);

        parse_gltf_attribute(
            gltf,
            gltf_position_accessor,
            *mesh_dto.vertices[0].position,
            size_of(Vertex_Dto),
            "POSITION",
        );

        assert( // @SpecValidation
            gltf_position_accessor.min.count == 3
            && gltf_position_accessor.max.count == 3,
            "min and max for a primitive are not defined"
        );

        mesh_dto.min = {
            gltf_position_accessor.min[0],
            gltf_position_accessor.min[1],
            gltf_position_accessor.min[2],
        };
        mesh_dto.max = {
            gltf_position_accessor.max[0],
            gltf_position_accessor.max[1],
            gltf_position_accessor.max[2],
        };
    } else {
        assert(false, "No POSITION attribute");
    }
    if gltf_primitive.attributes._normal != Gltf.SENTINEL {
        gltf_normal_accessor := gltf.accessors[gltf_primitive.attributes._normal];
        assert(gltf_normal_accessor.count == mesh_dto.vertices.count, "There is less normals than positions");
        parse_gltf_attribute(
            gltf,
            gltf_normal_accessor,
            *mesh_dto.vertices[0].normal,
            size_of(Vertex_Dto),
            "NORMAL",
        );
    } else {
        assert(false, "No normals in the primitive");
    }
    if gltf_primitive.attributes._tangent != Gltf.SENTINEL {
        gltf_tangent_accessor := gltf.accessors[gltf_primitive.attributes._tangent];
        assert(gltf_tangent_accessor.count == mesh_dto.vertices.count, "There is less tangents than positions");
        parse_gltf_attribute(
            gltf,
            gltf_tangent_accessor,
            *mesh_dto.vertices[0].tangent,
            size_of(Vertex_Dto),
            "TANGENT",
        );
    }
    if gltf_primitive.attributes._tex_coord_0 != Gltf.SENTINEL {
        gltf_tex_coord_0_accessor := gltf.accessors[gltf_primitive.attributes._tex_coord_0];
        assert(gltf_tex_coord_0_accessor.count == mesh_dto.vertices.count, "There is less tex_coord_0s than positions");
        parse_gltf_attribute(
            gltf,
            gltf_tex_coord_0_accessor,
            *mesh_dto.vertices[0].uv0,
            size_of(Vertex_Dto),
            "TEXCOORD_0",
        );
    }
    if gltf_primitive.attributes._tex_coord_1 != Gltf.SENTINEL {
        gltf_tex_coord_1_accessor := gltf.accessors[gltf_primitive.attributes._tex_coord_1];
        assert(gltf_tex_coord_1_accessor.count == mesh_dto.vertices.count, "There is less tex_coord_1s than positions");
        parse_gltf_attribute(
            gltf,
            gltf_tex_coord_1_accessor,
            *mesh_dto.vertices[0].uv1,
            size_of(Vertex_Dto),
            "TEXCOORD_1",
        );
    }
    if gltf_primitive.attributes._color_0 != Gltf.SENTINEL {
        gltf_color_0_accessor := gltf.accessors[gltf_primitive.attributes._color_0];
        assert(gltf_color_0_accessor.count == mesh_dto.vertices.count, "There is less color_0s than positions");
        parse_gltf_attribute(
            gltf,
            gltf_color_0_accessor,
            *mesh_dto.vertices[0].color,
            size_of(Vertex_Dto),
            "COLOR_0",
        );
    }

    return mesh_dto;
}

parse_gltf_attribute :: (
    gltf:                       Gltf.Gltf,
    gltf_accessor:              Gltf.Accessor,
    destination:                *$Result_Type,
    destination_stride:         int,
    attribute_key_for_printing: string,
) {
    if #complete gltf_accessor.type == { // @SpecValidation
        case .SCALAR;
            assert(
                IsScalar(Result_Type),
                "The % accessor is of scalar type, but the provided Result_Type is not scalar",
                attribute_key_for_printing,
            );
        case .VEC2;
            assert(
                Result_Type == Vector2,
                "The % accessor is of VEC2 type, but the provided Result_Type is not Vector2",
                attribute_key_for_printing,
            );
        case .VEC3;
            assert(
                Result_Type == Vector3,
                "The % accessor is of VEC3 type, but the provided Result_Type is not Vector3",
                attribute_key_for_printing,
            );
        case .VEC4;
            assert(
                Result_Type == Vector4,
                "The % accessor is of VEC4 type, but the provided Result_Type is not Vector4",
                attribute_key_for_printing,
            );
        case .MAT2;
            assert(
                Result_Type == Matrix2,
                "The % accessor is of MAT2 type, but the provided Result_Type is not Mat2",
                attribute_key_for_printing,
            );
        case .MAT3;
            assert(
                Result_Type == Matrix3,
                "The % accessor is of MAT3 type, but the provided Result_Type is not Mat3",
                attribute_key_for_printing,
            );
        case .MAT4;
            assert(
                Result_Type == Matrix4,
                "The % accessor is of MAT4 type, but the provided Result_Type is not Mat4",
                attribute_key_for_printing,
            );
    }
    assert(gltf_accessor.component_type == .FLOAT, "Only floats are supported");

    assert(gltf_accessor.sparse._count == Gltf.SENTINEL, "Sparse accessors are not supported");
    assert(gltf_accessor._buffer_view != Gltf.SENTINEL, "Got an accessor without a buffer view");

    gltf_buffer_view := gltf.buffer_views[gltf_accessor._buffer_view];
    gltf_buffer := gltf.buffers[gltf_buffer_view.buffer];

    component_byte_size := get_size_from_gltf_component_type(gltf_accessor.component_type);
    component_count := get_component_count_from_gltf_accessor_type(gltf_accessor.type);
    element_byte_size := component_count * component_byte_size;

    assert(element_byte_size == size_of(Result_Type), "The size of the element doesn't matche the size of Result_Type");

    byte_offset := gltf_accessor.byte_offset + gltf_buffer_view.byte_offset;

    step: int = ifx gltf_buffer_view._byte_stride != Gltf.SENTINEL
        then gltf_buffer_view._byte_stride
        else element_byte_size;

    { // @SpecValidation
        assert(gltf_accessor.count > 0, "The accessor count must be more than 0");

        span := (gltf_accessor.count - 1) * step + element_byte_size;

        assert(
            byte_offset + span <= gltf_buffer.bytes.count,
            "The span of the attribute is more than the number of bytes",
        );
        assert(
            gltf_accessor.byte_offset + span <= gltf_buffer_view.byte_length,
            "The span of the attribute is more than the byte length of the buffer view",
        );
    }

    gltf_attribute_bytes := gltf_buffer.bytes.data + byte_offset;

    for 0 .. gltf_accessor.count - 1 {
        target := cast(*Result_Type, cast(*u8, destination) + it * destination_stride);
        target.* = cast(*Result_Type, it * step + gltf_attribute_bytes);
    }
};

parse_gltf_indices :: (gltf: Gltf.Gltf, gltf_indices_accessor: Gltf.Accessor) -> [..]u32 {
    assert(gltf_indices_accessor.sparse._count == Gltf.SENTINEL, "Sparse accessors are not supported");
    assert(gltf_indices_accessor._buffer_view != Gltf.SENTINEL, "Got an accessor without a buffer view");
    assert(gltf_indices_accessor.type == .SCALAR, "Indices accessor must be be scalar"); // @SpecValidation
    gltf_indices_buffer_view := gltf.buffer_views[gltf_indices_accessor._buffer_view];
    assert(gltf_indices_buffer_view._byte_stride == Gltf.SENTINEL, "Indices accessor should not have byte_stride"); // @SpecValidation
    gltf_indices_buffer := gltf.buffers[gltf_indices_buffer_view.buffer];

    component_byte_size := get_size_from_gltf_component_type(gltf_indices_accessor.component_type);
    byte_count := gltf_indices_accessor.count * component_byte_size;
    byte_offset := gltf_indices_accessor.byte_offset + gltf_indices_buffer_view.byte_offset;

    { // @SpecValidation
        span_in_buffer := byte_offset + byte_count;
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

    gltf_indices_bytes := gltf_indices_buffer.bytes.data + byte_offset;

    result: [..]u32;
    array_resize(*result, gltf_indices_accessor.count, initialize = false);
    if #complete gltf_indices_accessor.component_type == {
        case .BYTE; #through;
        case .SHORT; #through;
        case .FLOAT;
            assert(false, "Indices component type can't be BYTE, SHORT or FLOAT"); // @SpecValidation
        case .UNSIGNED_BYTE;
            for *result_element: result {
                result_element.* = gltf_indices_bytes[it_index];
            }
        case .UNSIGNED_SHORT;
            casted := cast(*u16, gltf_indices_bytes);
            for *result_element: result {
                result_element.* = casted[it_index];
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
