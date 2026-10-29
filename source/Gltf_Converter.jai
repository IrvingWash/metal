convert_gltf :: (path: string, $validate: bool = false) -> Model_Dto.Model_Dto {
    assert(
        context.allocator.proc != temporary_allocator_proc,
        "Temp allocator is forbidden for this procedure, because it's auto_released here",
    );

    auto_release_temp();

    error: string = ---;
    gltf: Gltf.Gltf = ---;
    if ends_with(path, Gltf.GLTF_EXTENSION) {
        error, gltf = Gltf.read_gltf_from_file(path, validate,, temp);
    } else {
        error, gltf = Gltf.read_glb_from_file(path, validate,, temp);
    }
    assert(!error, error);
    assert(gltf.scenes.count == 1, "GLTF at % has multiple scenes", path);

    model_dto: Model_Dto.Model_Dto;

    gltf_scene := gltf.scenes[0];
    _, file_name := path_decomp(path);
    model_dto.name = sprint("%-%", file_name, gltf_scene.name);

    // These indices are used to subscript `model_dto.meshes` using `gltf_node._mesh`.
    // These are indices of elements which are the first `gltf_primitive`s of the `gltf_mesh`es.
    // We need this to later populate `node_dto.first_mesh_index`.
    // It's a little bit hairy, because we flatten gltf_meshes and gltf_primitives into a single array of mesh_dtos.
    first_mesh_indices: [..]u32;
    first_mesh_indices.allocator = temp;

    for gltf_mesh: gltf.meshes {
        array_add(*first_mesh_indices, cast(u32, model_dto.meshes.count));

        name := sprint("%-%", model_dto.name, gltf_mesh.name);
        for gltf_primitive: gltf_mesh.primitives {
            mesh_dto := convert_gltf_primitive_to_mesh_dto(
                gltf,
                gltf_primitive,

                name                  = name,
                identifier_for_errors = path,
            );
            array_add(*model_dto.meshes, mesh_dto);
        }
    }

    for gltf_image: gltf.images {
        name := sprint("%-%", model_dto.name, gltf_image.name);
        image_dto := convert_gltf_image_to_image_dto(
            gltf,
            gltf_image,
            root_path = path_strip_filename(path),
            name = name,
            identifier_for_errors = path,
        );
        array_add(*model_dto.images, image_dto);
    }

    for gltf_material: gltf.materials {
        name := sprint("%-%", model_dto.name, gltf_material.name);
        material_dto := convert_gltf_material_to_material_dto(
            gltf,
            gltf_material,
            name,
            identifier_for_errors = path,
        );
        array_add(*model_dto.materials, material_dto);
    }

    array_resize(*model_dto.nodes, gltf.nodes.count);
    for gltf_node: gltf.nodes {
        name := sprint("%-%", model_dto.name, gltf_node.name);

        node_dto := convert_gltf_node_to_node_dto_skipping_parent_index(
            gltf,
            gltf_node,
            first_mesh_indices,
            name,
        );

        model_dto.nodes[it_index] = node_dto;
    }
    for node, node_index: model_dto.nodes {
        for child_index: node.children_indices {
            model_dto.nodes[child_index].parent_index = some(cast(u32, node_index));
        }
    }

    return model_dto;
}



#scope_file

convert_gltf_node_to_node_dto_skipping_parent_index :: (
    gltf:               Gltf.Gltf,
    gltf_node:          Gltf.Node,
    first_mesh_indices: []u32,

    name: string,
) -> Model_Dto.Node_Dto {
    node_dto: Model_Dto.Node_Dto;

    node_dto.name = name;

    array_resize(
        *node_dto.children_indices,
        gltf_node.children.count,
    );
    for *child_index: node_dto.children_indices {
        child_index.* = cast(u32, gltf_node.children[it_index]);
    }

    if gltf_node._mesh != Gltf.SENTINEL {
        set(
            *node_dto.first_mesh_index,
            first_mesh_indices[gltf_node._mesh],
        );

        node_dto.mesh_count = cast(
            u32,
            gltf.meshes[gltf_node._mesh].primitives.count
        );
    }

    { // Transform
        gltf_matrix: Matrix4;
        gltf_matrix.floats = gltf_node.column_major_matrix;
        gltf_matrix = transpose(gltf_matrix);

        if gltf_matrix != Matrix4_Identity {
            node_dto.local_transform = gltf_matrix;
        } else {
            translation: Vector3;
            scale:       Vector3;
            rotation:    Quaternion;
            translation.component = gltf_node.translation;
            scale.component       = gltf_node.scale;
            rotation.component    = gltf_node.rotation;

            translation_matrix := make_translation_matrix4(translation);
            scale_matrix       := make_scale_matrix4(scale);
            _rotation_matrix   := rotation_matrix(Matrix4, rotation);

            node_dto.local_transform = translation_matrix * _rotation_matrix * scale_matrix;
        }
    }

    return node_dto;
}

make_texture_dto :: (
    gltf:              Gltf.Gltf,
    gltf_texture_info: $T/interface Gltf.Texture_Info,

    name_prefix: string,

    identifier_for_errors: string,
) -> Model_Dto.Texture_Dto {
    gltf_texture      := gltf.textures[gltf_texture_info._index];
    assert(
        gltf_texture._source != Gltf.SENTINEL,
        "The texture doesn't have a source (%)",
        identifier_for_errors,
    );

    gltf_sampler := ifx gltf_texture._sampler != Gltf.SENTINEL
        then gltf.samplers[gltf_texture._sampler]
        else Gltf.Sampler.{};

    assert(
        gltf_texture_info.tex_coord <= Model_Dto.SUPPORTED_MAX_TEX_COORD,
        "Got a tex coord value higher than we support for %",
        identifier_for_errors,
    );

    return Model_Dto.Texture_Dto.{
        name        = sprint("%-%", name_prefix, gltf_texture.name),
        image_index = cast(u32, gltf_texture._source),
        tex_coord   = cast(u32, gltf_texture_info.tex_coord),

        mag_filter = convert_gltf_mag_filter(gltf_sampler.mag_filter),
        min_filter = convert_gltf_min_filter(gltf_sampler.min_filter),
        wrap_s     = convert_gltf_wrap_mode(gltf_sampler.wrap_s),
        wrap_t     = convert_gltf_wrap_mode(gltf_sampler.wrap_t),
    };
}

convert_gltf_material_to_material_dto :: (
    gltf:          Gltf.Gltf,
    gltf_material: Gltf.Material,

    name: string,

    identifier_for_errors: string,
) -> Model_Dto.Material_Dto {
    material_dto: Model_Dto.Material_Dto;

    material_dto.name = name;

    material_dto.double_sided              = gltf_material.double_sided;
    material_dto.alpha_mode                = convert_gltf_alpha_mode(gltf_material.alpha_mode);
    material_dto.alpha_cutoff              = gltf_material.alpha_cutoff;
    material_dto.emissive_factor.component = gltf_material.emissive_factor;

    { // pbr_metallic_roughness_dto
        gltf_pbr := gltf_material.pbr_metallic_roughness;
        pbr_dto  := *material_dto.pbr_metallic_roughness;

        pbr_dto.base_color_factor.component = gltf_pbr.base_color_factor;
        pbr_dto.metallic_factor             = gltf_pbr.metallic_factor;
        pbr_dto.roughness_factor            = gltf_pbr.roughness_factor;

        if gltf_pbr.base_color_texture._index != Gltf.SENTINEL {
            texture_dto := make_texture_dto(
                gltf,
                gltf_pbr.base_color_texture,
                tprint("%-%", material_dto.name, "base_color"),
                identifier_for_errors,
            );
            set(*pbr_dto.base_color_texture, texture_dto);
        }

        if gltf_pbr.metallic_roughness_texture._index != Gltf.SENTINEL {
            texture_dto := make_texture_dto(
                gltf,
                gltf_pbr.metallic_roughness_texture,
                tprint("%-%", material_dto.name, "metallic_roughness"),
                identifier_for_errors,
            );
            set(*pbr_dto.metallic_roughness_texture, texture_dto);
        }
    }

    { // normal_texture_dto
        gltf_normal_texture := gltf_material.normal_texture;

        if gltf_normal_texture._index != Gltf.SENTINEL {
            texture_dto := make_texture_dto(
                gltf,
                gltf_normal_texture,
                tprint("%-%", material_dto.name, "normal"),
                identifier_for_errors,
            );
            set(
                *material_dto.normal_texture,
                Model_Dto.Normal_Texture_Dto.{
                    scale   = gltf_normal_texture.scale,
                    texture = texture_dto,
                },
            );
        }
    }

    { // occlusion_texture
        gltf_occlusion_texture := gltf_material.occlusion_texture;

        if gltf_occlusion_texture._index != Gltf.SENTINEL {
            texture_dto := make_texture_dto(
                gltf,
                gltf_occlusion_texture,
                tprint("%-%", material_dto.name, "occlusion"),
                identifier_for_errors,
            );
            set(
                *material_dto.occlusion_texture,
                Model_Dto.Occlusion_Texture_Dto.{
                    strength = gltf_occlusion_texture.strength,
                    texture  = texture_dto,
                },
            );
        }
    }

    { // emissive_texture
        gltf_emissive_texture := gltf_material.emissive_texture;

        if gltf_emissive_texture._index != Gltf.SENTINEL {
            texture_dto := make_texture_dto(
                gltf,
                gltf_emissive_texture,
                tprint("%-%", material_dto.name, "emissive"),
                identifier_for_errors,
            );
            set(
                *material_dto.emissive_texture,
                texture_dto,
            );
        }
    }

    return material_dto;
}

convert_gltf_image_to_image_dto :: (
    gltf:       Gltf.Gltf,
    gltf_image: Gltf.Image,
    root_path:  string,

    name: string,

    identifier_for_errors: string,
) -> Model_Dto.Image_Dto {
    assert(
        !starts_with(gltf_image.uri, Gltf.DATA_URI_PREFIX),
        "Images in data uris are not supported (%)",
        identifier_for_errors,
    );

    image_dto: Model_Dto.Image_Dto;

    image_dto.name = name;

    width, height: s32;
    channel_count: s32;
    DESIRED_CHANNEL_COUNT :: 4;
    loaded_bytes: *u8;

    if gltf_image.uri {
        path := path_join(
            root_path,
            gltf_image.uri,,
            temp
        );

        loaded_bytes = stbi_load(
            temp_c_string(path),
            *width, *height,
            *channel_count,
            DESIRED_CHANNEL_COUNT,
        );
    } else if gltf_image._buffer_view != Gltf.SENTINEL {
        gltf_image_buffer_view := gltf.buffer_views[gltf_image._buffer_view];
        gltf_image_buffer      := gltf.buffers[gltf_image_buffer_view.buffer];
        gltf_image_data        := gltf_image_buffer.bytes.data + gltf_image_buffer_view.byte_offset;

        loaded_bytes = stbi_load_from_memory(
            gltf_image_data,
            cast(s32, gltf_image_buffer_view.byte_length),
            *width, *height,
            *channel_count,
            DESIRED_CHANNEL_COUNT,
        );
    } else {
        assert(
            false,
            "The image % has neither uri, nor buffer view",
            image_dto.name,
        );
    }

    if loaded_bytes == null {
        failure_reason := stbi_failure_reason();
        assert(false, "Failed to load image '%': %", image_dto.name, to_string(failure_reason));
    }
    defer stbi_image_free(loaded_bytes);

    image_dto.width         = cast(u32, width);
    image_dto.height        = cast(u32, height);
    image_dto.channel_count = DESIRED_CHANNEL_COUNT;

    image_dto.bytes.count = width * height * DESIRED_CHANNEL_COUNT;
    image_dto.bytes.data = alloc(image_dto.bytes.count);
    memcpy(image_dto.bytes.data, loaded_bytes, image_dto.bytes.count);

    return image_dto;
}

convert_gltf_primitive_to_mesh_dto :: (
    gltf:           Gltf.Gltf,
    gltf_primitive: Gltf.Mesh.Primitive,

    name:                  string,
    identifier_for_errors: string,
) -> Model_Dto.Mesh_Dto {
    mesh_dto: Model_Dto.Mesh_Dto;

    mesh_dto.name     = name;
    mesh_dto.topology = convert_gltf_topology_mode(gltf_primitive.mode);

    if gltf_primitive._material != Gltf.SENTINEL {
        set(*mesh_dto.material_index, cast(u32, gltf_primitive._material));
    }

    if gltf_primitive._indices != Gltf.SENTINEL {
        gltf_indices_accessor := gltf.accessors[gltf_primitive._indices];
        mesh_dto.indices = parse_gltf_indices(
            gltf,
            gltf_indices_accessor,
            identifier_for_errors,
        );
    }

    if gltf_primitive.attributes._position != Gltf.SENTINEL {
        gltf_position_accessor := gltf.accessors[gltf_primitive.attributes._position];
        array_resize(*mesh_dto.vertices, gltf_position_accessor.count);

        parse_gltf_attribute(
            gltf,
            gltf_position_accessor,
            *mesh_dto.vertices[0].position,
            size_of(Model_Dto.Vertex_Dto),
            attribute_key_for_errors = "POSITION",
            identifier_for_errors,
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
        assert(false, "No POSITION attribute (%)", identifier_for_errors);
    }
    if gltf_primitive.attributes._normal != Gltf.SENTINEL {
        gltf_normal_accessor := gltf.accessors[gltf_primitive.attributes._normal];
        assert(
            gltf_normal_accessor.count == mesh_dto.vertices.count,
            "There is less normals than positions (%)",
            identifier_for_errors,
        );
        parse_gltf_attribute(
            gltf,
            gltf_normal_accessor,
            *mesh_dto.vertices[0].normal,
            size_of(Model_Dto.Vertex_Dto),
            attribute_key_for_errors = "NORMAL",
            identifier_for_errors,
        );
    } else {
        log(
            "No normals in the primitive (%)",
            identifier_for_errors,
            flags = .WARNING
        );
    }
    if gltf_primitive.attributes._tangent != Gltf.SENTINEL {
        gltf_tangent_accessor := gltf.accessors[gltf_primitive.attributes._tangent];
        assert(
            gltf_tangent_accessor.count == mesh_dto.vertices.count,
            "There is less tangents than positions (%)",
            identifier_for_errors,
        );
        parse_gltf_attribute(
            gltf,
            gltf_tangent_accessor,
            *mesh_dto.vertices[0].tangent,
            size_of(Model_Dto.Vertex_Dto),
            attribute_key_for_errors = "TANGENT",
            identifier_for_errors,
        );
    }
    if gltf_primitive.attributes._tex_coord_0 != Gltf.SENTINEL {
        gltf_tex_coord_0_accessor := gltf.accessors[gltf_primitive.attributes._tex_coord_0];
        assert(
            gltf_tex_coord_0_accessor.count == mesh_dto.vertices.count,
            "There is less tex_coord_0s than positions (%)",
            identifier_for_errors,
        );
        parse_gltf_attribute(
            gltf,
            gltf_tex_coord_0_accessor,
            *mesh_dto.vertices[0].uv0,
            size_of(Model_Dto.Vertex_Dto),
            attribute_key_for_errors = "TEXCOORD_0",
            identifier_for_errors,
        );
    }
    if gltf_primitive.attributes._tex_coord_1 != Gltf.SENTINEL {
        gltf_tex_coord_1_accessor := gltf.accessors[gltf_primitive.attributes._tex_coord_1];
        assert(
            gltf_tex_coord_1_accessor.count == mesh_dto.vertices.count,
            "There is less tex_coord_1s than positions",
            identifier_for_errors,
        );
        parse_gltf_attribute(
            gltf,
            gltf_tex_coord_1_accessor,
            *mesh_dto.vertices[0].uv1,
            size_of(Model_Dto.Vertex_Dto),
            attribute_key_for_errors = "TEXCOORD_1",
            identifier_for_errors,
        );
    }
    if gltf_primitive.attributes._color_0 != Gltf.SENTINEL {
        gltf_color_0_accessor := gltf.accessors[gltf_primitive.attributes._color_0];
        assert(
            gltf_color_0_accessor.count == mesh_dto.vertices.count,
            "There is less color_0s than positions",
            identifier_for_errors,
        );
        parse_gltf_attribute(
            gltf,
            gltf_color_0_accessor,
            *mesh_dto.vertices[0].color,
            size_of(Model_Dto.Vertex_Dto),
            attribute_key_for_errors = "COLOR_0",
            identifier_for_errors,
        );
    }

    return mesh_dto;
}

parse_gltf_attribute :: (
    gltf:               Gltf.Gltf,
    gltf_accessor:      Gltf.Accessor,
    destination:        *$Result_Type,
    destination_stride: int,

    attribute_key_for_errors: string,
    identifier_for_errors:    string,
) {
    if #complete gltf_accessor.type == {
        case .SCALAR;
            assert(
                IsScalar(Result_Type),
                "The % accessor is of scalar type, but the provided Result_Type is not scalar (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
        case .VEC2;
            assert(
                Result_Type == Vector2,
                "The % accessor is of VEC2 type, but the provided Result_Type is not Vector2 (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
        case .VEC3;
            assert(
                Result_Type == Vector3,
                "The % accessor is of VEC3 type, but the provided Result_Type is not Vector3 (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
        case .VEC4;
            assert(
                Result_Type == Vector4,
                "The % accessor is of VEC4 type, but the provided Result_Type is not Vector4 (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
        case .MAT2;
            assert(
                Result_Type == Matrix2,
                "The % accessor is of MAT2 type, but the provided Result_Type is not Mat2 (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
        case .MAT3;
            assert(
                Result_Type == Matrix3,
                "The % accessor is of MAT3 type, but the provided Result_Type is not Mat3 (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
        case .MAT4;
            assert(
                Result_Type == Matrix4,
                "The % accessor is of MAT4 type, but the provided Result_Type is not Mat4 (%)",
                attribute_key_for_errors,
                identifier_for_errors,
            );
    }
    assert(
        gltf_accessor.component_type == .FLOAT,
        "Only floats are supported for attributes (attribute: %) (%)",
        attribute_key_for_errors,
        identifier_for_errors,
    );

    assert(
        gltf_accessor.sparse._count == Gltf.SENTINEL,
        "Sparse accessors are not supported (attribute: %) (%)",
        attribute_key_for_errors,
        identifier_for_errors,
    );
    assert(
        gltf_accessor._buffer_view != Gltf.SENTINEL,
        "Got an accessor without a buffer view (attribute: %) (%)",
        attribute_key_for_errors,
        identifier_for_errors,
    );

    gltf_buffer_view := gltf.buffer_views[gltf_accessor._buffer_view];
    gltf_buffer := gltf.buffers[gltf_buffer_view.buffer];

    component_byte_size := get_size_from_gltf_component_type(gltf_accessor.component_type);
    component_count := get_component_count_from_gltf_accessor_type(gltf_accessor.type);
    element_byte_size := component_count * component_byte_size;

    assert(
        element_byte_size == size_of(Result_Type),
        "The size of the element doesn't matche the size of Result_Type (attribute: %) (%)",
        attribute_key_for_errors,
        identifier_for_errors,
    );

    byte_offset := gltf_accessor.byte_offset + gltf_buffer_view.byte_offset;

    step: int = ifx gltf_buffer_view._byte_stride != Gltf.SENTINEL
        then gltf_buffer_view._byte_stride
        else element_byte_size;

    gltf_attribute_bytes := gltf_buffer.bytes.data + byte_offset;

    for 0 .. gltf_accessor.count - 1 {
        target := cast(*Result_Type, cast(*u8, destination) + it * destination_stride);
        target.* = cast(*Result_Type, it * step + gltf_attribute_bytes).*;
    }
};

parse_gltf_indices :: (
    gltf:                  Gltf.Gltf,
    gltf_indices_accessor: Gltf.Accessor,
    identifier_for_errors:     string,
) -> [..]u32 {
    assert(
        gltf_indices_accessor.sparse._count == Gltf.SENTINEL,
        "Sparse accessors are not supported (%)",
        identifier_for_errors,
    );
    assert(
        gltf_indices_accessor._buffer_view != Gltf.SENTINEL,
        "Got an accessor without a buffer view (%)",
        identifier_for_errors,
    );
    gltf_indices_buffer_view := gltf.buffer_views[gltf_indices_accessor._buffer_view];
    gltf_indices_buffer := gltf.buffers[gltf_indices_buffer_view.buffer];

    component_byte_size := get_size_from_gltf_component_type(gltf_indices_accessor.component_type);
    byte_count := gltf_indices_accessor.count * component_byte_size;
    byte_offset := gltf_indices_accessor.byte_offset + gltf_indices_buffer_view.byte_offset;

    gltf_indices_bytes := gltf_indices_buffer.bytes.data + byte_offset;

    result: [..]u32;
    array_resize(*result, gltf_indices_accessor.count, initialize = false);
    if #complete gltf_indices_accessor.component_type == {
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
        case .BYTE; #through;
        case .SHORT; #through;
        case .FLOAT;
            // Impossible, validated in Gltf
    }

    return result;
}

convert_gltf_wrap_mode :: (gltf_wrap_mode: Gltf.Sampler.Wrap_Mode) -> Model_Dto.Wrap_Mode {
    if #complete gltf_wrap_mode == {
        case .CLAMP_TO_EDGE;
            return .CLAMP_TO_EDGE;
        case .MIRRORED_REPEAT;
            return .MIRRORED_REPEAT;
        case .REPEAT;
            return .REPEAT;
    }
}

convert_gltf_mag_filter :: (gltf_mag_filter: Gltf.Sampler.Mag_Filter) -> Model_Dto.Mag_Filter {
    if #complete gltf_mag_filter == {
        case .UNDEFINED;
            return .UNDEFINED;
        case .NEAREST;
            return .NEAREST;
        case .LINEAR;
            return .LINEAR;
    }
}

convert_gltf_min_filter :: (gltf_min_filter: Gltf.Sampler.Min_Filter) -> Model_Dto.Min_Filter {
    if #complete gltf_min_filter == {
        case .UNDEFINED;
            return .UNDEFINED;
        case .NEAREST;
            return .NEAREST;
        case .LINEAR;
            return .LINEAR;
        case .NEAREST_MIPMAP_NEAREST;
            return .NEAREST_MIPMAP_NEAREST;
        case .LINEAR_MIPMAP_NEAREST;
            return .LINEAR_MIPMAP_NEAREST;
        case .NEAREST_MIPMAP_LINEAR;
            return .NEAREST_MIPMAP_LINEAR;
        case .LINEAR_MIPMAP_LINEAR;
            return .LINEAR_MIPMAP_LINEAR;
    }
}

convert_gltf_topology_mode :: (gltf_topology: Gltf.Mesh.Primitive.Topology_Mode) -> Model_Dto.Topology_Mode {
    if #complete gltf_topology == {
        case .POINTS;
            return .POINTS;
        case .LINES;
            return .LINES;
        case .LINE_LOOP;
            return .LINE_LOOP;
        case .LINE_STRIP;
            return .LINE_STRIP;
        case .TRIANGLES;
            return .TRIANGLES;
        case .TRIANGLE_STRIP;
            return .TRIANGLE_STRIP;
        case .TRIANGLE_FAN;
            return .TRIANGLE_FAN;
    }
}

convert_gltf_alpha_mode :: (gltf_alpha_mode: Gltf.Material.Alpha_Mode) -> Model_Dto.Alpha_Mode {
    if #complete gltf_alpha_mode == {
        case .OPAQUE;
            return .OPAQUE;
        case .MASK;
            return .MASK;
        case .BLEND;
            return .BLEND;
    }
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

#import "Basic";
#import "String";
#import "Math";
#import "stb_image";
Model_Dto :: #import,file "Model_Dto.jai";
Gltf :: #import,dir "Gltf";
#import,dir "Option";
