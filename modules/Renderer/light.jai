#scope_module

Light :: union kind: Light_Kind {
    .DIRECTIONAL,, directional: Directional_Light;
}

Light_Kind :: enum {
    DIRECTIONAL;
}

Directional_Light :: struct @Gpu {
    direction:                 Vector3 = { 0, -1, -1 };
    intensity:                 float   = 5;
    color:                     Vector3 = { 1, 1,  1  };

    view_projection_transform: Matrix4 = Matrix4_Identity;
    radius:                    float   = 1;
}

update_directional_light :: (
    directional_light: *Directional_Light,
    camera:            $T/interface Camera,
    shadow_distance:   float,
    aspect_ratio:      float,
    transforms:        Transforms,
) {
    shadow_far := min(camera.z_far, shadow_distance);
    shadow_projection_transform := make_projection_matrix(
        camera.fov_vertical,
        aspect_ratio,
        camera.z_near,
        shadow_far,
        depth_range_01 = true,
    );

    frustum_corners := make_frustum_corners(
        transforms.view,
        shadow_projection_transform,
        depth_range_01 = true,
    );

    directional_light.view_projection_transform,
        directional_light.radius = create_fitted_view_projection_transform_for_directional_light(
        directional_light.direction,
        frustum_corners,
    );
}



#scope_file

create_fitted_view_projection_transform_for_directional_light :: (
    direction:       Vector3,
    frustum_corners: []Vector4,
) -> Matrix4, radius: float {
    // @Todo: use sphere to prevent shimmering
    // https://learnopengl.com/Guest-Articles/2021/CSM

    frustum_center: Vector3;
    for corner: frustum_corners {
        frustum_center += corner.xyz;
    }
    frustum_center /= cast(float, frustum_corners.count);

    light_view_transform := make_look_at_matrix(
        viewpoint = frustum_center - normalize(direction),
        look_at   = frustum_center,
        reference_up_vector = calculate_reference_up_vector(direction),
        x_is_forward = false,
    );

    light_projection_transform: Matrix4 = ---;
    radius: float = ---;
    {
        min_x, min_y, min_z := FLOAT32_MAX;
        max_x, max_y, max_z := -FLOAT32_MAX;

        for corner: frustum_corners {
            trf := light_view_transform * corner;
            min_x = min(min_x, trf.x);
            max_x = max(max_x, trf.x);
            min_y = min(min_y, trf.y);
            max_y = max(max_y, trf.y);
            min_z = min(min_z, trf.z);
            max_z = max(max_z, trf.z);
        }

        radius = max(max_x - min_x, max_y - min_y) * 0.5;

        OUTSIDE_CASTERS_RANGE :: 50.0;

        light_projection_transform = orthographic_projection_matrix(
            left           = min_x,
            right          = max_x,
            bottom         = min_y,
            top            = max_y,
            near           = -max_z - OUTSIDE_CASTERS_RANGE,
            far            = -min_z,
            depth_range_01 = true,
        );
    }

    return light_projection_transform * light_view_transform, radius;
}
