Camera :: struct {
    position: Vector3 = { 0, 0, 5 };
    target:   Vector3;

    front: Vector3 = { 0, 0, -1 };
    up:    Vector3 = { 0, 1, 0 };
    right: Vector3 = { 1, 0, 0 };

    pitch: float; // Along x
    yaw:   float = #run -deg_to_rad(90); // Along y

    speed: float = 5;

    mode: Camera_Mode;

    z_near:       float = 0.1;
    z_far:        float = 1000;
    fov_vertical: float = #run deg_to_rad(60);

    exposure: float = 1;
}

Camera_Mode :: enum {
    FLY;
}

update_camera :: (camera: *Camera, dt: float) {
    if #complete camera.mode == {
        case .FLY;
            fly(camera, dt);
    }

    camera.target = camera.position + camera.front;
}



#scope_file

MAX_PITCH   :: #run deg_to_rad(89);

fly :: (camera: *Camera, dt: float) {
    { // Rotate
        SENSITIVITY :: 0.01;
        WORLD_UP    :: Vector3.{ 0, 1, 0 };

        camera.yaw   += state.input_state.cursor.delta.x * SENSITIVITY * camera.fov_vertical;
        camera.pitch = clamp(
            (camera.pitch + state.input_state.cursor.delta.y * SENSITIVITY * camera.fov_vertical),
            -MAX_PITCH,
            MAX_PITCH,
        );
        direction: Vector3;
        cos_pitch := cos(camera.pitch);
        direction.x = cos(camera.yaw) * cos_pitch;
        direction.y = -sin(camera.pitch);
        direction.z = sin(camera.yaw) * cos_pitch;

        camera.front = normalize(direction);
        camera.right = normalize(cross(camera.front, WORLD_UP));
        camera.up    = cross(camera.right, camera.front);
    }

    { // Zoom
        ZOOM_STRENGTH    :: 5;
        MAX_FOV_VERTICAL :: #run deg_to_rad(70);
        MIN_FOV_VERTICAL :: #run deg_to_rad(1);

        camera.fov_vertical -= deg_to_rad(state.input_state.wheel.delta.y) * ZOOM_STRENGTH;
        camera.fov_vertical = clamp(camera.fov_vertical, MIN_FOV_VERTICAL, MAX_FOV_VERTICAL);
    }

    speed := camera.speed;
    if state.input_state.keys[Input.Scan_Code.LSHIFT] & .DOWN {
        speed = camera.speed * 2;
    }
    if state.input_state.keys[Input.Scan_Code.W] & .DOWN {
        camera.position += speed * camera.front * dt;
    }
    if state.input_state.keys[Input.Scan_Code.S] & .DOWN {
        camera.position -= speed * camera.front * dt;
    }
    if state.input_state.keys[Input.Scan_Code.A] & .DOWN {
        camera.position -= normalize(cross(camera.front, camera.up)) * speed * dt;
    }
    if state.input_state.keys[Input.Scan_Code.D] & .DOWN {
        camera.position += normalize(cross(camera.front, camera.up)) * speed * dt;
    }
    if state.input_state.keys[Input.Scan_Code.E] & .DOWN {
        camera.position += normalize(cross(camera.right, camera.front)) * speed * dt;
    }
    if state.input_state.keys[Input.Scan_Code.Q] & .DOWN {
        camera.position -= normalize(cross(camera.right, camera.front)) * speed * dt;
    }
}
