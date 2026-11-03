#scope_module

Shadow_Pass :: struct {
    depth_image_info: Image_Info;
}

Light_Source :: union kind: Light_Source_Kind {
    .DIRECTIONAL,, directional: Directional_Light_Source;
}

Light_Source_Kind :: enum {
    DIRECTIONAL;
}

Directional_Light_Source :: struct {
    direction: Vector3;
}

create_shadow_pass :: (
    device:    VK.Device,
    allocator: VMA.Allocator,
) -> error: string, Shadow_Pass {
    shadow_pass: Shadow_Pass;

    error:, shadow_pass.depth_image_info = create_image_info(
        device,
        allocator,
        DEFAULT_SHADOW_DEPTH_IMAGE_FORMAT,
        DEFAULT_SHADOW_DEPTH_IMAGE_WIDTH,
        DEFAULT_SHADOW_DEPTH_IMAGE_HEIGHT,
        depth = 1,
        tiling = .OPTIMAL,
        usage = .DEPTH_STENCIL_ATTACHMENT | .SAMPLED,
        allocation_flags = .DEDICATED_MEMORY,
        aspect_mask = .DEPTH,
    );
    if error {
        return
            tprint("Failed to create depth image for shadow pass: %", error),
            shadow_pass;
    }

    return "", shadow_pass;
}

destroy_shadow_pass :: (
    device: VK.Device,
    allocator: VMA.Allocator,
    shadow_pass: *Shadow_Pass,
) {
    destroy_image_info(
        device,
        allocator,
        *shadow_pass.depth_image_info,
    );

    shadow_pass.* = {};
}

do_shadow_pass :: (shadow_pass: *Shadow_Pass, light_source: Light_Source) {
    view_projection_transform := create_view_projection_transform_for_light_source(light_source);

    // @Todo: incomplete
}



#scope_file

DEFAULT_SHADOW_DEPTH_IMAGE_FORMAT :: VK.Format.D32_SFLOAT;
DEFAULT_SHADOW_DEPTH_IMAGE_WIDTH  :: 2048;
DEFAULT_SHADOW_DEPTH_IMAGE_HEIGHT :: 2048;

create_view_projection_transform_for_light_source :: (light_source: Light_Source) -> Matrix4 {
    if #complete light_source.kind == {
        case .DIRECTIONAL;
            RADIUS :: 100;
            CENTER :: Vector3.{};

            // @Todo: check this is if shadows are broken
            projection_transform := orthographic_projection_matrix(
                left           = -RADIUS,
                right          = RADIUS,
                bottom         = -RADIUS,
                top            = RADIUS,
                near           = 0,
                far            = 2 * RADIUS,
                depth_range_01 = true,
            );

            // @Todo: check this is if shadows are broken
            view_transform := make_look_at_matrix(
                viewpoint = CENTER - normalize(light_source.directional.direction) * RADIUS,
                look_at   = CENTER,
                reference_up_vector = calculate_reference_up_vector(light_source.directional.direction),
                x_is_forward = false,
            );

            return projection_transform * view_transform;
    }
}

calculate_reference_up_vector :: (light_direction: Vector3) -> Vector3 {
    EPSILON :: 0.01;

    normalized_light_direction := normalize(light_direction);

  if abs(dot(normalized_light_direction, .{0, 1, 0})) > 1 - EPSILON {
      return .{1, 0, 0};
  }

  return .{0, 1, 0};
}
