Entity_Manager :: struct {
    all:     [..]*Entity;
    storage: Entity_Storage;

    next_id: u64;

    asset_manager: *Asset_Manager;
    renderer:      *Renderer.Renderer; // For asset uploading
}

Entity :: struct {
    token: Entity_Token;

    name: string;
    type: Type;

    position: Vector3;
    rotation: Quaternion;
    scale:    Vector3 = { 1, 1, 1 };

    tint: Vector4 = { 1, 1, 1, 1 };

    flags: Entity_Flags;

    model_path:         string;
    model_asset_handle: Model_Asset_Handle;

    animation_player:   Animation_Player;
}

Entity_Token :: struct {
    id: u64;
    locator: Bucket_Locator;
}

Entity_Flags :: enum_flags {
    NONE;
    INVISIBLE;
}

Entity_Storage :: struct {
    #insert -> string {
        return generate_entity_storage_body();
    }
};

make_world_transform :: (entity: Entity) -> Matrix4 {
    translation := make_translation_matrix4(entity.position);
    scale       := make_scale_matrix4(entity.scale);
    rotation    := rotation_matrix(Matrix4, entity.rotation);

    return translation * rotation * scale;
}

init_entity_manager :: (asset_manager: *Asset_Manager, renderer: *Renderer.Renderer) -> Entity_Manager {
    manager: Entity_Manager;
    manager.asset_manager = asset_manager;
    manager.renderer = renderer;

    return manager;
}

destroy_entity_manager :: (manager: *Entity_Manager) {
    array_free(manager.all);
}

update_entity_manager :: (manager: *Entity_Manager) {
    array_reset_keeping_memory(*manager.all);

    make_all(manager);
}

spawn_entity :: (manager: *Entity_Manager, entity: $T)
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
                "        case %1; locator, pointer = bucket_array_add(*manager.storage._%1, entity);\n",
                it,
            );
        }

        print_to_builder(*builder, "        case; #assert false \"Unknown entity type %\";\n", T);

        print_to_builder(*builder, "    }\n");

        return builder_to_string(*builder);
    }

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
}

#placeholder ENTITY_TYPE_NAMES;



#scope_file

make_all :: (manager: *Entity_Manager) {
    #insert -> string {
        return generate_make_all_body();
    }
}

generate_make_all_body :: () -> string #compile_time {
INSERTION_STRING :: #string DONE
    array_reserve(*manager.all, %);

    %
DONE

    reserve_count_code_builder: String_Builder;
    add_to_all_code_builder:    String_Builder;

    for entity_type_name: ENTITY_TYPE_NAMES {
        print_to_builder(
            *reserve_count_code_builder,
            "        + manager.storage._%.count\n",
            entity_type_name,
        );

        print_to_builder(
            *add_to_all_code_builder,
            "    for *manager.storage._% array_add(*manager.all, it);\n",
            entity_type_name,
        );
    }

    return tprint(
        INSERTION_STRING,
        builder_to_string(*reserve_count_code_builder),
        builder_to_string(*add_to_all_code_builder),
    );
}

generate_entity_storage_body :: () -> string #compile_time {
    builder: String_Builder;

    for entity_type_name: ENTITY_TYPE_NAMES {
        ITEM_PER_BUCKET_COUNT :: 20;

        print_to_builder(
            *builder,
            "    _%1: Bucket_Array(%1, %2, true);\n",
            entity_type_name,
            ITEM_PER_BUCKET_COUNT,
        );
    }

    return builder_to_string(*builder);
}

#import "Bucket_Array";
#import "Compiler";
Renderer :: #import "Renderer";
