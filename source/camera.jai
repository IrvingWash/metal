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
    if state.input_state.keys[Input.Scan_Code.W].down {
        camera.position += camera.speed * camera.front;
    }
    if state.input_state.keys[Input.Scan_Code.S].down {
        camera.position -= camera.speed * camera.front;
    }
    if state.input_state.keys[Input.Scan_Code.A].down {
        camera.position -= normalize(cross(camera.front, camera.up)) * camera.speed;
    }
    if state.input_state.keys[Input.Scan_Code.D].down {
        camera.position += normalize(cross(camera.front, camera.up)) * camera.speed;
    }
    if state.input_state.keys[Input.Scan_Code.E].down {
        camera.position += normalize(cross(camera.right, camera.front)) * camera.speed;
    }
    if state.input_state.keys[Input.Scan_Code.Q].down {
        camera.position -= normalize(cross(camera.right, camera.front)) * camera.speed;
    }
}
