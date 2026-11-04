#scope_module

Shadow_Pass :: struct {
    depth_image_info: Image_Info;

    pipeline_info: Shadow_Pass_Pipeline_Info;
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
    device:                        VK.Device,
    allocator:                     VMA.Allocator,
    get_compiled_shader:           Get_Compiled_Shader,
    texture_descriptor_set_layout: VK.Descriptor_Set_Layout,
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

    error, shadow_pass.pipeline_info = create_shadow_pass_pipeline_info(
        device,
        get_compiled_shader,
        shadow_pass.depth_image_info.format,
        .[texture_descriptor_set_layout],
    );
    if error {
        return
            tprint("Failed to create pipeline for shadow pass: %", error),
            shadow_pass;
    }

    return "", shadow_pass;
}

destroy_shadow_pass :: (
    shadow_pass: *Shadow_Pass,
    device:      VK.Device,
    allocator:   VMA.Allocator,
) {
    destroy_shadow_pass_pipeline_info(
        *shadow_pass.pipeline_info,
        device,
    );

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

Shadow_Pass_Pipeline_Info :: struct {
    layout:   VK.Pipeline_Layout;
    opaque_pipeline: VK.Pipeline;
    mask_pipeline:   VK.Pipeline;
}

Push_Constants :: struct {
    vertex_buffer_address:   VK.Device_Address;
    material_buffer_address: VK.Device_Address;
    instance_buffer_address: VK.Device_Address;

    view_projection_transform: Matrix4;
}

destroy_shadow_pass_pipeline_info :: (
    pipeline_info:       *Shadow_Pass_Pipeline_Info,
    device:              VK.Device,
) {
    VK.destroy_pipeline(device, pipeline_info.opaque_pipeline);
    VK.destroy_pipeline(device, pipeline_info.mask_pipeline);
    VK.destroy_pipeline_layout(device, pipeline_info.layout);

    pipeline_info.* = {};
}

create_shadow_pass_pipeline_info :: (
    device:                 VK.Device,
    get_compiled_shader:    Get_Compiled_Shader,
    attachment_format:      VK.Format,
    descriptor_set_layouts: []VK.Descriptor_Set_Layout,
) -> error: string, Shadow_Pass_Pipeline_Info {
    pipeline_info: Shadow_Pass_Pipeline_Info;

    { // Layout
        push_constant_range := VK.Push_Constant_Range.{
            stage_flags = .VERTEX | .FRAGMENT,
            offset      = 0,
            size        = size_of(Push_Constants),
        };

        layout_create_info := VK.Pipeline_Layout_Create_Info.{
            set_layout_count          = cast(u32, descriptor_set_layouts.count),
            p_set_layouts             = descriptor_set_layouts.data,
            push_constant_range_count = 1,
            p_push_constant_ranges    = *push_constant_range,
        };

        result:, pipeline_info.layout = VK.create_pipeline_layout(device, *layout_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create layout for shadow pass pipeline: %", result),
                pipeline_info;
        }
    }

    error, vertex_shader := create_shader_module(device, "shadow.vertex.spv", get_compiled_shader);
    if error {
        return
            error,
            pipeline_info;
    }
    defer VK.destroy_shader_module(device, vertex_shader);

    error =, fragment_shader := create_shader_module(device, "shadow.fragment.spv", get_compiled_shader);
    if error {
        return
            error,
            pipeline_info;
    }
    defer VK.destroy_shader_module(device, fragment_shader);


    vertex_shader_stage_create_info := VK.Pipeline_Shader_Stage_Create_Info.{
        stage  = .VERTEX,
        module = vertex_shader,
        p_name = "main",
    };
    fragment_shader_stage_create_info := VK.Pipeline_Shader_Stage_Create_Info.{
        stage  = .FRAGMENT,
        module = fragment_shader,
        p_name = "main",
    };

    vertex_input_state_create_info := VK.Pipeline_Vertex_Input_State_Create_Info.{};

    input_assembly_state_create_info := VK.Pipeline_Input_Assembly_State_Create_Info.{
        topology = .TRIANGLE_LIST,
    };

    viewport_state_create_info := VK.Pipeline_Viewport_State_Create_Info.{
        viewport_count = 1,
        p_viewports    = null,
        scissor_count  = 1,
        p_scissors     = null,
    };

    rasterization_state_create_info := VK.Pipeline_Rasterization_State_Create_Info.{
        polygon_mode      = .FILL,
        cull_mode         = .BACK,
        front_face        = .COUNTER_CLOCKWISE,
        line_width        = 1,
        depth_bias_enable = VK.TRUE,
    };

    multisample_state_create_info := VK.Pipeline_Multisample_State_Create_Info.{
        rasterization_samples = ._1,
    };

    dynamic_states := VK.Dynamic_State.[
        .VIEWPORT,
        .SCISSOR,
        .CULL_MODE,
        .DEPTH_BIAS,
    ];

    dynamic_state_create_info := VK.Pipeline_Dynamic_State_Create_Info.{
        dynamic_state_count = dynamic_states.count,
        p_dynamic_states    = dynamic_states.data,
    };

    depth_stencil_state_create_info := VK.Pipeline_Depth_Stencil_State_Create_Info.{
        depth_test_enable   = VK.TRUE,
        depth_write_enable  = VK.TRUE,
        depth_compare_op    = .LESS,
        stencil_test_enable = VK.FALSE,
    };

    rendering_create_info := VK.Pipeline_Rendering_Create_Info.{
        depth_attachment_format    = attachment_format,
    };

    pipeline_create_info := VK.Graphics_Pipeline_Create_Info.{
        p_next                 = *rendering_create_info,
        p_vertex_input_state   = *vertex_input_state_create_info,
        p_input_assembly_state = *input_assembly_state_create_info,
        p_depth_stencil_state  = *depth_stencil_state_create_info,
        p_viewport_state       = *viewport_state_create_info,
        p_rasterization_state  = *rasterization_state_create_info,
        p_multisample_state    = *multisample_state_create_info,
        p_dynamic_state        = *dynamic_state_create_info,
        layout                 = pipeline_info.layout,
        render_pass            = null,
    };

    { // Opaque
        opaque_pipeline_create_info := pipeline_create_info;
        opaque_pipeline_create_info.stage_count = 1;
        opaque_pipeline_create_info.p_stages = *vertex_shader_stage_create_info;

        result:, pipeline_info.opaque_pipeline = VK.create_graphics_pipeline(
            device,
            null,
            *opaque_pipeline_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create opaque shadow pass pipeline: %", result),
                pipeline_info;
        }
    }

    { // Mask
        mask_pipeline_create_info := pipeline_create_info;

        stages := VK.Pipeline_Shader_Stage_Create_Info.[
            vertex_shader_stage_create_info,
            fragment_shader_stage_create_info,
        ];
        mask_pipeline_create_info.stage_count = stages.count;
        mask_pipeline_create_info.p_stages = stages.data;

        result:, pipeline_info.mask_pipeline = VK.create_graphics_pipeline(
            device,
            null,
            *mask_pipeline_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create mask shadow pass pipeline: %", result),
                pipeline_info;
        }
    }

    return "", pipeline_info;
}

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
