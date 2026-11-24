Entity :: struct {
    token: Entity_Token; @Editor(ignore)

    name: string;
    type: Type;

    position: Vector3;
    rotation: Quaternion;
    scale:    Vector3 = { 1, 1, 1 };

    tint: Vector4 = { 1, 1, 1, 1 }; @Editor(color)

    flags: Entity_Flags;

    model_path:         string;
    model_asset_handle: Model_Asset_Handle;

    animation_player:   Animation_Player; @Editor(ignore)
}

Entity_Token :: struct {
    id: u64;
    locator: Bucket_Locator;
}

Entity_Flags :: enum_flags {
    NONE;
    INVISIBLE;
    PENDING_REMOVAL;
}

operator == :: (a: Entity_Token, b: Entity_Token) -> bool {
    return a.id == b.id && a.locator == b.locator;
}

make_world_transform :: (entity: Entity) -> Matrix4 {
    translation := make_translation_matrix4(entity.position);
    scale       := make_scale_matrix4(entity.scale);
    rotation    := rotation_matrix(Matrix4, entity.rotation);

    return translation * rotation * scale;
}

destroy_entity :: (entity: *Entity) {
    entity.* = {};
}
