Camera :: struct {
    position: Vector3 = { 0, 0, 5 };

    front: Vector3 = { 0, 0, -1 };

    z_near:       float = 0.1;
    z_far:        float = 1000;
    fov_vertical: float = #run deg_to_rad(60);

    exposure: float = 1;
}

Camera_Basis :: struct {
    front: Vector3;
    right: Vector3;
    up:    Vector3;
}

calculate_camera_basis :: (camera: Camera) -> Camera_Basis {
    front := normalize(camera.front);
    right := normalize(cross(front, WORLD_UP));
    up    := cross(right, front);

    return {
        front = front,
        right = right,
        up    = up,
    };
}



#scope_file

WORLD_UP    :: Vector3.{ 0, 1, 0 };
