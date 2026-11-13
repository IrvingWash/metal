Camera_Controller_Kind :: enum {
    FLY;
    ORBIT;
}

Fly_Camera_Input :: struct {
    look_delta:     Vector2;
    zoom_delta:     float;
    move_direction: Move_Direction;
    sprint:         bool;
}

Orbit_Camera_Input :: struct {
    orbit_delta: Vector2;
}

Move_Direction :: enum_flags {
    UP;
    DOWN;
    LEFT;
    RIGHT;
    FORWARD;
    BACKWARD;
}

fly_camera :: (camera: *Camera, dt: float, input: Fly_Camera_Input) {
    fly_look(camera, input);
    fly_move(camera, dt, input);
}

orbit_camera :: (
    camera:       *Camera,
    input:        Orbit_Camera_Input,
    target:       Vector3,
    pivot_offset: Vector3,
    distance:     float,
) {
    SENSITIVITY :: 0.01;
    MAX_PITCH   :: #run deg_to_rad(80);

    yaw, pitch := calculate_yaw_and_pitch_from_direction(camera.front);

    yaw   += input.orbit_delta.x * SENSITIVITY;
    pitch -= input.orbit_delta.y * SENSITIVITY;
    pitch  = clamp(pitch, -MAX_PITCH, MAX_PITCH);

    front := calculate_direction_from_yaw_and_pitch(yaw, pitch);

    camera.front    = front;
    camera.position = target + pivot_offset - front * distance;
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

    direction: Vector3;
    if input.move_direction & .FORWARD direction += basis.front;
    if input.move_direction & .BACKWARD direction -= basis.front;
    if input.move_direction & .UP direction += basis.up;
    if input.move_direction & .DOWN direction -= basis.up;
    if input.move_direction & .LEFT direction -= basis.right;
    if input.move_direction & .RIGHT direction += basis.right;

    direction_length := length(direction);
    if direction_length == 0 {
        return;
    }

    speed := SPEED;
    if input.sprint {
        speed *= SPRINT_MULTIPLIER;
    }

    camera.position += direction * (speed * dt / direction_length);
}
