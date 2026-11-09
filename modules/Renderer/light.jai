Directional_Light_Params :: struct {
    color:     Vector3 = { 1, 1, 1 };
    direction: Vector3 = #run normalize(Vector3.{ 0, -1, -1 });
    intensity: float   = 5;
}

Spot_Light_Params :: struct {
    position:  Vector3;
    direction: Vector3 = #run normalize(Vector3.{ 0, 0, -1 });
    intensity: float   = 5;
    color:     Vector3 = { 1, 1, 1 };
    range:     float = 10;

    outer_cutoff_half_angle: float = #run deg_to_rad(20);
    inner_cutoff_half_angle: float = #run deg_to_rad(10);
}

#scope_module

Light :: union kind: Light_Kind {
    .DIRECTIONAL,, directional: Directional_Light;
    .SPOT,,        spot:        Spot_Light;
}

Light_Kind :: enum {
    DIRECTIONAL;
    SPOT;
}

Directional_Light :: struct @Gpu {
    direction:                 Vector3 = #run normalize(Vector3.{ 0, -1, -1 });
    intensity:                 float   = 5;
    color:                     Vector3 = { 1, 1,  1 };

    view_projection_transform: Matrix4 = Matrix4_Identity;
    radius:                    float   = 1;
}

Spot_Light :: struct @Gpu {
    position:                    Vector3;
    direction:                   Vector3 = #run normalize(Vector3.{ 0, 0, -1 });
    intensity:                   float   = 5;
    color:                       Vector3 = { 1, 1, 1 };
    range:                       float   = 10;
    outer_cutoff_half_angle_cos: float   = #run cos(deg_to_rad(20));
    inner_cutoff_half_angle_cos: float   = #run cos(deg_to_rad(10));
}

create_spot_light :: (params: Spot_Light_Params) -> Spot_Light {
    light: Spot_Light;

    light.position  = params.position;
    light.direction = normalize(params.direction);
    light.intensity = params.intensity;
    light.color     = params.color;
    light.range     = params.range;
    light.outer_cutoff_half_angle_cos = cos(params.outer_cutoff_half_angle);
    light.inner_cutoff_half_angle_cos = cos(params.inner_cutoff_half_angle);

    return light;
}

/*
create_shadowed_spot_light :: (params: Spot_Light_Params) -> Shadowed_Spot_Light {
    shadowed_spot_light: Shadowed_Spot_Light;
    shadowed_spot_light.base = create_spot_light(params);

    view_transform := make_look_at_matrix(
        viewpoint           = shadowed_spot_light.position,
        look_at             = shadowed_spot_light.position + shadowed_spot_light.direction,
        reference_up_vector = calculate_reference_up_vector(shadowed_spot_light.direction),
        x_is_forward        = false,
    );

    projection_transform := make_projection_matrix(
        fov_vertical   = 2 * acos(shadowed_spot_light.outer_cutoff_half_angle_cos),
        aspect_ratio   = 1,
        z_near         = shadowed_spot_light.range / 100,
        z_far          = shadowed_spot_light.range,
        depth_range_01 = true,
    );

    shadowed_spot_light.view_projection_transform = projection_transform * view_transform;

    return shadowed_spot_light;
}
*/

create_directional_light :: (
    params:          Directional_Light_Params,
    camera:          $T/interface Camera,
    shadow_distance: float,
    aspect_ratio:    float,
    view_transform:  Matrix4,
) -> Directional_Light {
    light: Directional_Light;
    light.color = params.color;
    light.intensity = params.intensity;
    light.direction = normalize(params.direction);

    shadow_far := min(camera.z_far, shadow_distance);
    projection_transform_with_shadow_far := make_projection_matrix(
        camera.fov_vertical,
        aspect_ratio,
        camera.z_near,
        shadow_far,
        depth_range_01 = true,
    );

    frustum_corners := make_frustum_corners(
        view_transform,
        projection_transform_with_shadow_far,
        depth_range_01 = true,
    );

    light.view_projection_transform,
    light.radius = create_fitted_view_projection_transform_for_directional_light(
        light.direction,
        frustum_corners,
    );

    return light;
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
