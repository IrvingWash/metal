Camera :: struct {
    position: Vector3 = { 0, 0, 5 };
    target:   Vector3;

    front: Vector3 = { 0, 0, -1 };
    up:    Vector3 = { 0, 1, 0 };
    right: Vector3 = { 1, 0, 0 };

    speed: float = 0.05;

    mode: Camera_Mode;

    z_near:       float = 0.1;
    z_far:        float = 1000;
    fov_vertical: float = #run deg_to_rad(60);
}

Camera_Mode :: enum {
    FLY;
}

update_camera :: (camera: *Camera) {
    if #complete camera.mode == {
        case .FLY;
            fly(camera);
    }

    camera.target = camera.position + camera.front;
}



#scope_file

fly :: (camera: *Camera) {
    key_state := Input.get_keyboard_state();

    if key_state[Input.Scan_Code.W] {
        camera.position += camera.speed * camera.front;
    }
    if key_state[Input.Scan_Code.S] {
        camera.position -= camera.speed * camera.front;
    }
    if key_state[Input.Scan_Code.A] {
        camera.position -= normalize(cross(camera.front, camera.up)) * camera.speed;
    }
    if key_state[Input.Scan_Code.D] {
        camera.position += normalize(cross(camera.front, camera.up)) * camera.speed;
    }
    if key_state[Input.Scan_Code.E] {
        camera.position += normalize(cross(camera.right, camera.front)) * camera.speed;
    }
    if key_state[Input.Scan_Code.Q] {
        camera.position -= normalize(cross(camera.right, camera.front)) * camera.speed;
    }
}
