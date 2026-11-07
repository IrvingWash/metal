quaternion_to_euler :: (quaternion: Quaternion) -> Vector3 {
    // https://en.wikipedia.org/wiki/Rotation_formulations_in_three_dimensions?utm_source=chatgpt.com#:~:text=Quaternion%20%E2%86%92%20Euler%20angles%20%28z%2Dy%E2%80%B2%2Dx%E2%80%B3%20intrinsic%29edit

    q := quaternion;
    normalize_or_identity(*q);

    roll := atan2(2 * (q.w * q.x + q.y * q.z), 1 - 2 * (q.x * q.x + q.y * q.y));

    sin_pitch := 2 * (q.w * q.y - q.z * q.x);
    Clamp(*sin_pitch, -1.0, 1.0);
    pitch := asin(sin_pitch);

    yaw := atan2(2 * (q.w * q.z + q.x * q.y), 1 - 2 * (q.y * q.y + q.z * q.z));

    return { roll, pitch, yaw };
}

euler_to_quaternion :: (e: Vector3) -> Quaternion {
    // https://en.wikipedia.org/wiki/Rotation_formulations_in_three_dimensions?utm_source=chatgpt.com#:~:text=Euler%20angles%20%28z%2Dy%E2%80%B2%2Dx%E2%80%B3%20intrinsic%29%20%E2%86%92%20quaternionedit

    result: Quaternion;

    hx := e.x / 2;
    hy := e.y / 2;
    hz := e.z / 2;

    chx := cos(hx);
    shx := sin(hx);
    chy := cos(hy);
    shy := sin(hy); // Oh, don't be so shy!
    chz := cos(hz);
    shz := sin(hz);

    result.x = shx * chy * chz - chx * shy * shz;
    result.y = chx * shy * chz + shx * chy * shz;
    result.z = chx * chy * shz - shx * shy * chz;
    result.w = chx * chy * chz + shx * shy * shz;

    return result;
}

// Transforms AABB preserving correct values for rotations & scale
transform_aabb :: (min: Vector3, max: Vector3, transform: Matrix4) -> min: Vector3, max: Vector3 {
    center  := (min + max) * 0.5;
    extents := (max - min) * 0.5;

    new_center := (transform * make_vector4(center, 1)).xyz;
    new_extents := Vector3.{
        abs(transform._11) * extents.x + abs(transform._12) * extents.y + abs(transform._13) * extents.z,
        abs(transform._21) * extents.x + abs(transform._22) * extents.y + abs(transform._23) * extents.z,
        abs(transform._31) * extents.x + abs(transform._32) * extents.y + abs(transform._33) * extents.z,
    };

    return new_center - new_extents, new_center + new_extents;
}

deg_to_rad :: (degrees: float) -> radians: float {
    FACTOR :: PI / 180;

    return degrees * FACTOR;
}

rad_to_deg :: (radians: float) -> degrees: float {
    FACTOR :: PI / 180;

    return radians / FACTOR;
}



#scope_file

#import "Math";
