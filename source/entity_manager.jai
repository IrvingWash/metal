#placeholder ENTITY_TYPE_NAMES;

Entity_Manager :: struct {
    all:     [..]*Entity;
    storage: Entity_Storage;

    next_id: u64;

    asset_manager: *Asset_Manager;
    renderer:      *Renderer.Renderer; // For asset uploading
}

Entity_Storage :: struct {
    #insert -> string {
        return generate_entity_storage_body();
    }
};

init_entity_manager :: (asset_manager: *Asset_Manager, renderer: *Renderer.Renderer) -> Entity_Manager {
    manager: Entity_Manager;
    manager.asset_manager = asset_manager;
    manager.renderer = renderer;

    return manager;
}

destroy_entity_manager :: (manager: *Entity_Manager) {
    for entity: manager.all {
        destroy_entity(entity);
    }
    array_free(manager.all);

    destroy_entity_storage(*manager.storage);
}

get_entity :: (manager: *Entity_Manager, token: Entity_Token, $R: Type = Entity) -> *R
#modify {
    return R == Entity || is_subclass_of(cast(*Type_Info, R), "Entity");
}
{
    for entity: manager.all {
        if entity.token == token {
            return cast(*R, entity);
        }
    }

    return null;
}

spawn_entity :: (manager: *Entity_Manager, entity: $T) -> *T
#modify {
    return is_subclass_of(cast(*Type_Info, T), "Entity");
}
{
    pointer: *T;
    locator: Bucket_Locator;

    #insert -> string {
        builder: String_Builder;

        print_to_builder(*builder, "    #if T == {\n");

        for ENTITY_TYPE_NAMES {
            print_to_builder(
                *builder,
                #string DONE
        case %1;
            pointer, locator = find_and_occupy_empty_slot(*manager.storage._%1, false);
            pointer.* = entity;
                DONE,
                it,
            );
        }

        print_to_builder(
            *builder,
            #string DONE
        case;
            #assert false "Unknown entity type %";
            DONE,
            T,
        );

        print_to_builder(*builder, "    }\n");

        return builder_to_string(*builder);
    }

    array_add(*manager.all, pointer);

    pointer.type = T;
    pointer.token.locator = locator;
    pointer.token.id = manager.next_id;

    if pointer.model_path {
        pointer.model_asset_handle = asset_manager_upload_model(
            manager.asset_manager,
            pointer.model_path,
            manager.renderer,
        );
    }

    manager.next_id += 1;

    return pointer;
}

remove_entity :: (manager: *Entity_Manager, entity: *$T)
#modify {
    return T == Entity || is_subclass_of(cast(*Type_Info, T), "Entity");
}
{
    entity.flags |= .PENDING_REMOVAL;
}

update_entity_manager :: (manager: *Entity_Manager) {
    for entity: manager.all {
        if entity.flags & .PENDING_REMOVAL {
            token := entity.token;
            type  := entity.type;
            destroy_entity(entity);

            #insert -> string {
                builder: String_Builder;

                print_to_builder(
                    *builder,
                    #string DONE
                    if type == {
                    DONE,
                );

                for entity_type_name: ENTITY_TYPE_NAMES {
                    print_to_builder(
                        *builder,
                        #string DONE
                        case %1;
                            bucket_array_remove(*manager.storage._%1, token.locator);
                        DONE,
                        entity_type_name,
                    );
                }

                print_to_builder(
                    *builder,
                    #string DONE
                    case;
                        assert(false, "Unknown entity type %", type);
                    DONE,
                    "%",
                );

                print_to_builder(
                    *builder,
                    #string DONE
                    }
                    DONE
                );

                return builder_to_string(*builder);
            }

            remove entity;
        }
    }
}



#scope_file

destroy_entity_storage :: (storage: *Entity_Storage) {
    #insert -> string {
        return generate_destroy_entity_storage_body();
    }
}

generate_destroy_entity_storage_body :: () -> string #compile_time {
    builder: String_Builder;

    for entity_type_name: ENTITY_TYPE_NAMES {
        print_to_builder(*builder, "    bucket_array_reset(*storage._%);\n", entity_type_name);
    }

    return builder_to_string(*builder);
}

generate_entity_storage_body :: () -> string #compile_time {
    builder: String_Builder;

    ITEM_PER_BUCKET_COUNT     :: 20;
    ALWAYS_ITERATE_BY_POINTER :: false;

    for entity_type_name: ENTITY_TYPE_NAMES {
        print_to_builder(
            *builder,
            "    _%1: Bucket_Array(%1, %2, %3);\n",
            entity_type_name,
            ITEM_PER_BUCKET_COUNT,
            ALWAYS_ITERATE_BY_POINTER,
        );
    }

    return builder_to_string(*builder);
}

#import "Bucket_Array";
#import "Compiler";
Renderer :: #import "Renderer";
