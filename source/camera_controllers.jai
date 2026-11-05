Camera_Controller_Kind :: enum {
    FLY;
}

Fly_Camera_Input :: struct {
    look_delta: Vector2;
    zoom_delta: float;
    move:       Vector3; // -1 .. 1
    sprint:     bool;
}

fly_camera :: (camera: *Camera, dt: float, input: Fly_Camera_Input) {
    fly_look(camera, input);
    fly_move(camera, dt, input);
}



#scope_file

fly_look :: (camera: *Camera, input: Fly_Camera_Input) {
    { // Rotate
        MAX_PITCH   :: #run deg_to_rad(89);
        SENSITIVITY :: 0.01;

        yaw, pitch := calculate_yaw_and_pitch_from_direction(camera.front);

        scale := SENSITIVITY * camera.fov_vertical;

        yaw   += input.look_delta.x * scale;
        pitch += input.look_delta.y * scale;
        pitch = clamp(pitch, -MAX_PITCH, MAX_PITCH);

        camera.front = calculate_direction_from_yaw_and_pitch(yaw, pitch);
    }

    { // Zoom
        ZOOM_STRENGTH    :: 5;
        MAX_FOV_VERTICAL :: #run deg_to_rad(120);
        MIN_FOV_VERTICAL :: #run deg_to_rad(1);

        camera.fov_vertical -= deg_to_rad(input.zoom_delta) * ZOOM_STRENGTH;
        camera.fov_vertical = clamp(camera.fov_vertical, MIN_FOV_VERTICAL, MAX_FOV_VERTICAL);
    }
}

fly_move :: (camera: *Camera, dt: float, input: Fly_Camera_Input) {
    SPEED             :: 5.0;
    SPRINT_MULTIPLIER :: 2.0;

    basis := calculate_camera_basis(camera);

    move := basis.right * input.move.x
        + basis.up    * input.move.y
        + basis.front * input.move.z;

    move_length := length(move);
    if move_length == 0 {
        return;
    }
    if move_length > 1 {
        move /= move_length;
    }

    speed := SPEED;
    if input.sprint {
        speed *= SPRINT_MULTIPLIER;
    }

    camera.position += move * speed * dt;
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
