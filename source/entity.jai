Entity :: struct {
    name: string;

    position: Vector3;
    rotation: Quaternion;
    scale:    Vector3 = { 1, 1, 1 };

    tint: Vector4 = { 1, 1, 1, 1 };

    model_asset_handle: Model_Asset_Handle;
}

make_world_transform :: (entity: Entity) -> Matrix4 {
    translation := make_translation_matrix4(entity.position);
    scale       := make_scale_matrix4(entity.scale);
    rotation    := rotation_matrix(Matrix4, entity.rotation);

    return translation * rotation * scale;
}
