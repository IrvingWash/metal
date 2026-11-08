AABB :: struct {
    min:     Vector3;
    max:     Vector3;
    center:  Vector3;
    extents: Vector3;
}

Frustum :: struct {
    top:    Plane3;
    bottom: Plane3;

    right: Plane3;
    left:  Plane3;

    far:  Plane3;
    near: Plane3;

    #overlay(top) planes: [6]Plane3;
}

deg_to_rad :: (degrees: float) -> radians: float {
    FACTOR :: PI / 180;

    return degrees * FACTOR;
}

rad_to_deg :: (radians: float) -> degrees: float {
    FACTOR :: PI / 180;

    return radians / FACTOR;
}

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
transform_aabb :: (
    aabb: AABB,
    transform: Matrix4,
) -> AABB {
    new_center := (transform * make_vector4(aabb.center, 1)).xyz;

    new_extents := Vector3.{
        abs(transform._11) * aabb.extents.x + abs(transform._12) * aabb.extents.y + abs(transform._13) * aabb.extents.z,
        abs(transform._21) * aabb.extents.x + abs(transform._22) * aabb.extents.y + abs(transform._23) * aabb.extents.z,
        abs(transform._31) * aabb.extents.x + abs(transform._32) * aabb.extents.y + abs(transform._33) * aabb.extents.z,
    };

    return {
        min = new_center - new_extents,
        max = new_center + new_extents,
        center = new_center,
        extents = new_extents,
    };
}

make_aabb :: (min: Vector3, max: Vector3) -> AABB {
    aabb: AABB;

    aabb.min = min;
    aabb.max = max;

    aabb.center = (aabb.max + aabb.min) / 2;
    aabb.extents = (aabb.max - aabb.min) / 2;

    return aabb;
}

// @Todo: return bool
cast_ray :: (
    position:          Vector2,
    screen_size:       Vector2,
    projection_matrix: Matrix4,
    view_matrix:       Matrix4,
    $left_handed:      bool    = false,
) -> Vector3 {
    // https://antongerdelan.net/opengl/raycasting.html

    ok, inverse_projection_matrix := inverse(projection_matrix);
    if !ok {
        return Vector3.{};
    }

    ok =, inverse_view_matrix := inverse(view_matrix);
    if !ok {
        return Vector3.{};
    }

    ray_ndc: Vector3 = {
        x = (2 * position.x) / screen_size.x - 1,
        y = 1 - (2 * position.y) / screen_size.y,
        z = 1,
    };

    ray_clip: Vector4 = {
        x = ray_ndc.x,
        y = ray_ndc.y,
        z = -1,
        w = 1,
    };

    ray_eye: Vector4 = inverse_projection_matrix * ray_clip;
    ray_eye = {
        x = ray_eye.x,
        y = ray_eye.y,
        z = -1,
        w = 0,
    };

    #if left_handed {
        ray_eye.z = 1;
    }

    ray_world := normalize((inverse_view_matrix * ray_eye).xyz);

    return ray_world;
}

ray_vs_aabb :: (
    ray_origin:    Vector3,
    ray_direction: Vector3,
    aabb:          AABB,
    transform:     Matrix4,
) -> bool, distance: float {
    // https://tavianator.com/2022/ray_box_boundary.html

    ok, inversed_transform := inverse(transform);
    if !ok {
        return false, 0;
    }

    transformed_ray_origin    := (inversed_transform * make_vector4(ray_origin, 1)).xyz;
    transformed_ray_direction := (inversed_transform * make_vector4(ray_direction, 0)).xyz;

    t_min: float = 0;
    t_max: float = FLOAT32_INFINITY;

    inversed_transformed_ray_direction := 1 / transformed_ray_direction;

    for 0 .. 2 {
        t1 := (aabb.min.component[it] - transformed_ray_origin.component[it])
            * inversed_transformed_ray_direction.component[it];
        t2 := (aabb.max.component[it] - transformed_ray_origin.component[it])
            * inversed_transformed_ray_direction.component[it];

        t_min = max(t_min, min(min(t1, t2), t_max));
        t_max = min(t_max, max(max(t1, t2), t_min));
    }

    return t_min < t_max, t_min;
}

calculate_translation_from_transform :: (m: Matrix4) -> Vector3 {
    return { m._14, m._24, m._34 };
}

calculate_scale_from_transform :: (m: Matrix4) -> Vector3 {
    // https://math.stackexchange.com/questions/237369/given-this-transformation-matrix-how-do-i-decompose-it-into-translation-rotati
    x := length(Vector3.{ m._11, m._21, m._31 });
    y := length(Vector3.{ m._12, m._22, m._32 });
    z := length(Vector3.{ m._13, m._23, m._33 });

    return { x, y, z };
}

calculate_rotation_from_transform :: (original: Matrix4) -> Quaternion {
    // https://math.stackexchange.com/questions/237369/given-this-transformation-matrix-how-do-i-decompose-it-into-translation-rotati

    m := original;

    m._14 = 0;
    m._24 = 0;
    m._34 = 0;

    scale := calculate_scale_from_transform(m);

    for scale.component {
        EPSILON :: 0.0001;
        if it < EPSILON {
            return Quaternion.{};
        }
    }

    for *row: m.v {
        row.* /= make_vector4(scale, 1);
    }

    return get_rotation(m);
}

make_frustum_from_matrix :: (matrix: Matrix4, $should_normalize: bool, $depth_range_01: bool) -> Frustum {
    // https://www.gamedevs.org/uploads/fast-extraction-viewing-frustum-planes-from-world-view-projection-matrix.pdf

    frustum: Frustum;

    frustum.left.a = matrix._41 + matrix._11;
    frustum.left.b = matrix._42 + matrix._12;
    frustum.left.c = matrix._43 + matrix._13;
    frustum.left.d = matrix._44 + matrix._14;

    frustum.right.a = matrix._41 - matrix._11;
    frustum.right.b = matrix._42 - matrix._12;
    frustum.right.c = matrix._43 - matrix._13;
    frustum.right.d = matrix._44 - matrix._14;

    frustum.top.a = matrix._41 - matrix._21;
    frustum.top.b = matrix._42 - matrix._22;
    frustum.top.c = matrix._43 - matrix._23;
    frustum.top.d = matrix._44 - matrix._24;

    frustum.bottom.a = matrix._41 + matrix._21;
    frustum.bottom.b = matrix._42 + matrix._22;
    frustum.bottom.c = matrix._43 + matrix._23;
    frustum.bottom.d = matrix._44 + matrix._24;

    #if depth_range_01 {
        frustum.near.a = matrix._31;
        frustum.near.b = matrix._32;
        frustum.near.c = matrix._33;
        frustum.near.d = matrix._34;
    } else {
        frustum.near.a = matrix._41 + matrix._31;
        frustum.near.b = matrix._42 + matrix._32;
        frustum.near.c = matrix._43 + matrix._33;
        frustum.near.d = matrix._44 + matrix._34;
    }

    frustum.far.a = matrix._41 - matrix._31;
    frustum.far.b = matrix._42 - matrix._32;
    frustum.far.c = matrix._43 - matrix._33;
    frustum.far.d = matrix._44 - matrix._34;

    #if should_normalize {
        frustum.left   = normalize(frustum.left);
        frustum.right  = normalize(frustum.right);
        frustum.top    = normalize(frustum.top);
        frustum.bottom = normalize(frustum.bottom);
        frustum.near   = normalize(frustum.near);
        frustum.far    = normalize(frustum.far);
    }

    return frustum;
}

aabb_vs_frustum :: (aabb: AABB, frustum: Frustum) -> bool {
    // https://outerra.blogspot.com/2012/11/view-frustum-culling-of-sphere-mapped.html

    for plane: frustum.planes {
        d := plane_dot(plane, aabb.center);

        normal := Vector3.{ plane.a, plane.b, plane.c };
        r := dot(abs(normal), aabb.extents);

        if d + r < 0 {
            return false;
        }
    }

    return true;
}

// @Todo: return bool
make_frustum_corners :: (view_matrix: Matrix4, projection_matrix: Matrix4, depth_range_01: bool) -> [8]Vector4 {
    // https://learnopengl.com/Guest-Articles/2021/CSM

    corners: [8]Vector4;

    ok, inverse_view_projection := inverse(projection_matrix * view_matrix);
    if !ok {
        return corners;
    }

    index: int;
    for x: 0 .. 2 - 1 {
        for y: 0 .. 2 - 1 {
            for z: 0 .. 2 - 1 {
                corner := inverse_view_projection * Vector4.{
                    x = 2 * cast(float, x) - 1,
                    y = 2 * cast(float, y) - 1,
                    z = ifx depth_range_01
                        then cast(float, z)
                        else 2 * cast(float, z) - 1,
                    w = 1,
                };
                corners[index] = (corner / corner.w);
                index += 1;
            }
        }
    }

    return corners;
}



#scope_file

#import "Basic";
#import "Math";
