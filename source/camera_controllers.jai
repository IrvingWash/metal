Camera_Controller_Kind :: enum {
    FLY;
}

fly_camera :: (camera: *Camera, dt: float) {
    fly_look(camera);
    fly_move(camera, dt);
}



#scope_file

fly_look :: (camera: *Camera) {
    { // Rotate
        MAX_PITCH   :: #run deg_to_rad(89);
        SENSITIVITY :: 0.01;

        yaw, pitch := calculate_yaw_and_pitch_from_direction(camera.front);

        scale := SENSITIVITY * camera.fov_vertical;

        yaw   += state.input_state.cursor.delta.x * scale;
        pitch += state.input_state.cursor.delta.y * scale;
        pitch = clamp(pitch, -MAX_PITCH, MAX_PITCH);

        camera.front = calculate_direction_from_yaw_and_pitch(yaw, pitch);
    }

    { // Zoom
        ZOOM_STRENGTH    :: 5;
        MAX_FOV_VERTICAL :: #run deg_to_rad(120);
        MIN_FOV_VERTICAL :: #run deg_to_rad(1);

        camera.fov_vertical -= deg_to_rad(state.input_state.wheel.delta.y) * ZOOM_STRENGTH;
        camera.fov_vertical = clamp(camera.fov_vertical, MIN_FOV_VERTICAL, MAX_FOV_VERTICAL);
    }
}

fly_move :: (camera: *Camera, dt: float) {
    speed := 5.0;

    basis := calculate_camera_basis(camera);

    move: Vector3;
    if state.input_state.keys[Input.Scan_Code.W] & .DOWN
        move += basis.front;
    if state.input_state.keys[Input.Scan_Code.S] & .DOWN
        move -= basis.front;
    if state.input_state.keys[Input.Scan_Code.A] & .DOWN
        move -= basis.right;
    if state.input_state.keys[Input.Scan_Code.D] & .DOWN
        move += basis.right;
    if state.input_state.keys[Input.Scan_Code.E] & .DOWN
        move += basis.up;
    if state.input_state.keys[Input.Scan_Code.Q] & .DOWN
        move -= basis.up;

    if state.input_state.keys[Input.Scan_Code.LSHIFT] & .DOWN
        speed *= 2;

    move_length := length(move);
    if move_length == 0 {
        return;
    }

    camera.position += move * (speed * dt / move_length);
}

calculate_yaw_and_pitch_from_direction :: (direction: Vector3) -> yaw: float, pitch: float {
    normalized_direction := normalize(direction);

    return
        atan2(normalized_direction.z, normalized_direction.x),
        -asin(clamp(normalized_direction.y, -1, 1));
}

calculate_direction_from_yaw_and_pitch :: (yaw: float, pitch: float) -> Vector3 {
    cos_pitch := cos(pitch);

    return .{
        cos(yaw) * cos_pitch,
        -sin(pitch),
        sin(yaw) * cos_pitch,
    };
}
