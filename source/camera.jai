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

look_at :: (camera: *Camera, target: Vector3) {
    to_target := target - camera.position;

    if length_squared(to_target) < 0.00001 {
        return;
    }

    camera.front = normalize(to_target);
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



#scope_file

WORLD_UP    :: Vector3.{ 0, 1, 0 };
