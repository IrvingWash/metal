Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    scale = { 0.05, 0.05, 0.05 };
    rotation = #run -> Quaternion {
        quaternion: Quaternion;

        set_from_axis_and_angle(*quaternion, { 0, 1, 0 }, deg_to_rad(180));

        return quaternion;
    };


    walk_speed: float = 10;
    turn_speed: float = #run deg_to_rad(360);
    yaw:        float = #run deg_to_rad(180);
}

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



#scope_file

Input :: #import "Input";
