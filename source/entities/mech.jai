Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    position = { 0, 0, -2.5 };
    scale = { 0.05, 0.05, 0.05 };

    strafe_speed: float = 3;
}

simulate_mech :: (mech: *Mech, dt: float) {
    // Orient so mech looks along camera z
    yaw := atan2(game.camera.front.x, game.camera.front.z);
    set_from_axis_and_angle(*mech.rotation, { 0, 1, 0 }, yaw);

    // Move
    direction: Vector3;

    if game.input_state.keys[Input.Scan_Code.D] & .DOWN
        direction.x += 1;
    if game.input_state.keys[Input.Scan_Code.A] & .DOWN
        direction.x -= 1;
    if game.input_state.keys[Input.Scan_Code.W] & .DOWN
        direction.y += 1;
    if game.input_state.keys[Input.Scan_Code.S] & .DOWN
        direction.y -= 1;

    if direction == Vector3.{ 0, 0, 0 } {
        return;
    }

    direction /= length(direction);

    distance := mech.strafe_speed * dt;

    camera_basis := calculate_camera_basis(game.camera);

    frustum := make_frustum_from_matrix(
        game.renderer.transforms.view_projection,
        should_normalize = false,
        depth_range_01 = true,
    );

    // X
    previous := mech.position;
    move := camera_basis.right * direction.x * distance;
    mech.position += move;
    transformed_aabb := transform_aabb(
        asset_manager_get_model(game.asset_manager, mech.model_asset_handle).model_accessor.aabb,
        make_world_transform(mech),
    );
    if !is_aabb_fully_inside_frustum(transformed_aabb, frustum) {
        mech.position = previous;
    }
    // Y
    previous = mech.position;
    move = camera_basis.up * direction.y * distance;
    mech.position += move;
    transformed_aabb = transform_aabb(
        asset_manager_get_model(game.asset_manager, mech.model_asset_handle).model_accessor.aabb,
        make_world_transform(mech),
    );
    if !is_aabb_fully_inside_frustum(transformed_aabb, frustum) {
        mech.position = previous;
    }
}



#scope_file

Input :: #import "Input";
