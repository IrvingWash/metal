#scope_module

validate_gltf :: (gltf: Gltf, gltf_identifier: string) -> error: string {
    errors: [..]string;
    errors.allocator = temp;

    for accessor: gltf.accessors {
        if accessor.count < 1 {
            add_error(
                *errors,
                gltf_identifier,
                "Accessor '%': Count is less than 1",
                accessor.name,
            );
        }
    }

    for mesh: gltf.meshes {
        for primitive: mesh.primitives {
            if primitive.attributes._position != SENTINEL {
                position_accessor := gltf.accessors[primitive.attributes._position];

                if position_accessor.min.count < 1 || position_accessor.max.count < 1 {
                    add_error(
                        *errors,
                        gltf_identifier,
                        "Accessor '%': Min and max are not defined for POSITION accessor",
                        position_accessor.name,
                    );
                }
            }

            if primitive.attributes._normal == SENTINEL {
                log("GLTF Validator: % doesn't have normals", gltf_identifier, flags = .WARNING); // @Todo: make this better. Return warnings?
            }

            if primitive.attributes._tangent == SENTINEL {
                log(
                    "GLTF Validator: % primitive of mesh % doesn't have tangents",
                    gltf_identifier,
                    mesh.name,
                    flags = .WARNING,
                );
            }

            if primitive._indices != SENTINEL {
                indices_accessor := gltf.accessors[primitive._indices];

                if indices_accessor.type != .SCALAR {
                    add_error(
                        *errors,
                        gltf_identifier,
                        "Primitive '%-%': Indices accessor type is %, but should be %",
                        mesh.name, it_index,
                        indices_accessor.type,
                        Accessor._Type.SCALAR,
                    );
                }

                if #complete indices_accessor.component_type == {
                    case .BYTE; #through;
                    case .SHORT; #through;
                    case .FLOAT;
                        add_error(
                            *errors,
                            gltf_identifier,
                            "Primitive '%-%': Indices accessor component type is %, but should be unigned and not float",
                            mesh.name, it_index,
                            indices_accessor.component_type,
                        );
                    case .UNSIGNED_BYTE; #through;
                    case .UNSIGNED_SHORT; #through;
                    case .UNSIGNED_INT;
                        // All good
                }

                indices_buffer_view := gltf.buffer_views[indices_accessor._buffer_view];

                if indices_buffer_view._byte_stride != SENTINEL {
                    add_error(
                        *errors,
                        gltf_identifier,
                        "Primitive '%-%': Indices accessor has byte stride",
                        mesh.name, it_index,
                    );
                }
            }
        }
    }

    return join(..errors, "\n", after_last = true,, temp);
}



#scope_file

add_error :: (
    errors: *[..]string,
    identifier: string,
    format: string,
    args: ..Any
) {
    if errors.count < 1 {
        array_add(errors, "Validation failed for %:", identifier);
    }

    array_add(errors, tprint(format, ..args));
} @PrintLike
