Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    position = { 0, 0, -2.5 };
    scale = { 0.05, 0.05, 0.05 };

    rotation = #run -> Quaternion {
        quaternion: Quaternion;

        set_from_axis_and_angle(*quaternion, { 0, 1, 0 }, deg_to_rad(180));

        return quaternion;
    };

    strafe_speed: float = 3;
}

simulate_mech :: (mech: *Mech, dt: float) {
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

    move := direction * mech.strafe_speed * dt;

    frustum := make_frustum_from_matrix(
        game.renderer.transforms.view_projection,
        should_normalize = false,
        depth_range_01 = true,
    );

    // X
    previous := mech.position;
    mech.position.x += move.x;
    transformed_aabb := transform_aabb(
        asset_manager_get_model(game.asset_manager, mech.model_asset_handle).model_accessor.aabb,
        make_world_transform(mech),
    );
    if !is_aabb_fully_inside_frustum(transformed_aabb, frustum) {
        mech.position.x -= move.x;
    }
    // Y
    previous = mech.position;
    mech.position.y += move.y;
    transformed_aabb = transform_aabb(
        asset_manager_get_model(game.asset_manager, mech.model_asset_handle).model_accessor.aabb,
        make_world_transform(mech),
    );
    if !is_aabb_fully_inside_frustum(transformed_aabb, frustum) {
        mech.position.y -= move.y;
    }
}

// 3rd person controlls
/*
simulate_mech :: (mech: *Mech, camera: Camera, dt: float, input_state: Input.Input_State) {
    using,only(Scan_Code) Input;

     // Drop y so we are parallel to the mech
    camera_forward := normalize(Vector3.{ camera.front.x, 0, camera.front.z });
    camera_right := cross(camera_forward, { 0, 1, 0 });

    direction: Vector3;
    if input_state.keys[Scan_Code.W] & .DOWN
        direction.z += 1;
    if input_state.keys[Scan_Code.S] & .DOWN
        direction.z -= 1;
    if input_state.keys[Scan_Code.A] & .DOWN
        direction.x -= 1;
    if input_state.keys[Scan_Code.D] & .DOWN
        direction.x += 1;

    move := camera_forward * direction.z + camera_right * direction.x;

    move_length := length(move);

    if move_length > 0.0001 {
        move /= move_length;

        mech.position += move * mech.walk_speed * dt;

        target_yaw := atan2(move.x, move.z);
        diff := wrap_angle(target_yaw - mech.yaw);
        max_step := mech.turn_speed * dt;
        mech.yaw += clamp(diff, -max_step, max_step);
    }

    set_from_axis_and_angle(*mech.rotation, { 0, 1, 0 }, mech.yaw);
}
*/



#scope_file

Input :: #import "Input";
