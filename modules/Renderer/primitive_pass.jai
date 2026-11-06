Line_Primitive :: struct @Gpu {
    a:     Vector3;
    b:     Vector3;
    color: Vector4;
}

#scope_module

Primitive_Pass :: struct {
    line_pipeline_layout: VK.Pipeline_Layout;
    line_pipeline:        VK.Pipeline;

    line_buffer_infos:    [FRAMES_IN_FLIGHT_COUNT]Buffer_Info;
    line_buffer_pointers: [FRAMES_IN_FLIGHT_COUNT]*Line_Primitive;

    lines: [..]Line_Primitive;
}

create_primitive_pass :: (
    device:                  VK.Device,
    allocator:               VMA.Allocator,
    get_compiled_shader:     Get_Compiled_Shader,
    color_attachment_format: VK.Format,
    depth_attachment_format: VK.Format,
) -> error: string, Primitive_Pass {
    primitive_pass: Primitive_Pass;

    for *line_buffer_info: primitive_pass.line_buffer_infos {
        error:, line_buffer_info.* = create_buffer(
            device,
            allocator,
            usage = .STORAGE_BUFFER | .SHADER_DEVICE_ADDRESS,
            LINE_BUFFER_BYTE_SIZE,
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create line buffer for primitive pass: %", error),
                primitive_pass;
        }

        result:, primitive_pass.line_buffer_pointers[it_index] = VMA.map_memory(
            allocator,
            line_buffer_info.allocation,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to map line buffer memory: %", result),
                primitive_pass;
        }
    }

    error:,
        primitive_pass.line_pipeline_layout,
        primitive_pass.line_pipeline = create_line_pipeline(
            device,
            get_compiled_shader,
            color_attachment_format,
            depth_attachment_format,
        );
    if error {
        return error, primitive_pass;
    }

    return "", primitive_pass;
}

destroy_primitive_pass :: (primitive_pass: *Primitive_Pass, device: VK.Device, allocator: VMA.Allocator) {
    VK.destroy_pipeline(device, primitive_pass.line_pipeline);
    VK.destroy_pipeline_layout(device, primitive_pass.line_pipeline_layout);

    array_free(primitive_pass.lines);

    for buffer_info: primitive_pass.line_buffer_infos {
        VMA.unmap_memory(
            allocator,
            buffer_info.allocation,
        );
        VMA.destroy_buffer(
            allocator,
            buffer_info.buffer,
            buffer_info.allocation,
        );
    }

    primitive_pass.* = {};
}

do_primitive_pass :: (
    primitive_pass: *Primitive_Pass,
    frame_index:    u64,
    transforms:     Transforms,
    command_buffer: VK.Command_Buffer,
    allocator:      VMA.Allocator,
) {
    assert(primitive_pass.lines.count <= MAX_LINE_COUNT, "MAX_LINE_COUNT overflow");

    { // Push constants
        push_constants: Line_Pipeline_Push_Constants = {
            line_buffer_address       = primitive_pass.line_buffer_infos[frame_index].device_address,
            view_projection_transform = transforms.view_projection,
        };

        VK.cmd_push_constants(
            command_buffer,
            primitive_pass.line_pipeline_layout,
            stage_flags = .VERTEX,
            offset = 0,
            size_of(Line_Pipeline_Push_Constants),
            *push_constants,
        );
    }

    memcpy(
        primitive_pass.line_buffer_pointers[frame_index],
        primitive_pass.lines.data,
        primitive_pass.lines.count * size_of(Line_Primitive),
    );
    VMA.flush_allocation(
        allocator,
        primitive_pass.line_buffer_infos[frame_index].allocation,
        0,
        VK.WHOLE_SIZE,
    );

    VK.cmd_bind_pipeline(command_buffer, .GRAPHICS, primitive_pass.line_pipeline);

    VK.cmd_draw(
        command_buffer,
        vertex_count   = cast(u32, primitive_pass.lines.count * 2), // 2 vertices per line
        instance_count = 1,
        first_vertex   = 0,
        first_instance = 0,
    );
}

reset_primitive_pass :: (primitive_pass: *Primitive_Pass) {
    array_reset_keeping_memory(*primitive_pass.lines);
}

add_line_to_primitive_pass :: (primitive_pass: *Primitive_Pass, line: Line_Primitive) {
    array_add(*primitive_pass.lines, line);
}



#scope_file

MAX_LINE_COUNT        :: 4096 * 6;
LINE_BUFFER_BYTE_SIZE :: MAX_LINE_COUNT * size_of(Line_Primitive);

create_line_pipeline :: (
    device:                  VK.Device,
    get_compiled_shader:     Get_Compiled_Shader,
    color_attachment_format: VK.Format,
    depth_attachment_format: VK.Format,
) -> error: string, VK.Pipeline_Layout, VK.Pipeline {
    layout:   VK.Pipeline_Layout;
    pipeline: VK.Pipeline;

    { // Layout
        push_constant_range := VK.Push_Constant_Range.{
            stage_flags = .VERTEX,
            offset      = 0,
            size        = size_of(Line_Pipeline_Push_Constants),
        };

        layout_create_info := VK.Pipeline_Layout_Create_Info.{
            push_constant_range_count = 1,
            p_push_constant_ranges    = *push_constant_range,
        };

        result:, layout = VK.create_pipeline_layout(device, *layout_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create layout for line pipeline: %", result),
                layout,
                pipeline;
        }
    }

    error, vertex_shader := create_shader_module(device, "line.vertex.spv", get_compiled_shader);
    if error {
        return
            error,
            layout,
            pipeline;
    }
    defer VK.destroy_shader_module(device, vertex_shader);

    error =, fragment_shader := create_shader_module(device, "line.fragment.spv", get_compiled_shader);
    if error {
        return
            error,
            layout,
            pipeline;
    }
    defer VK.destroy_shader_module(device, fragment_shader);

    shader_stage_create_infos := VK.Pipeline_Shader_Stage_Create_Info.[
        {
            stage  = .VERTEX,
            module = vertex_shader,
            p_name = "main",
        },
        {
            stage  = .FRAGMENT,
            module = fragment_shader,
            p_name = "main",
        },
    ];

    vertex_input_state_create_info := VK.Pipeline_Vertex_Input_State_Create_Info.{};

    input_assembly_state_create_info := VK.Pipeline_Input_Assembly_State_Create_Info.{
        topology = .LINE_LIST,
    };

    depth_stencil_state_create_info := VK.Pipeline_Depth_Stencil_State_Create_Info.{
        depth_test_enable   = VK.TRUE,
        depth_write_enable  = VK.TRUE,
        depth_compare_op    = .LESS,
        stencil_test_enable = VK.FALSE,
    };

    viewport_state_create_info := VK.Pipeline_Viewport_State_Create_Info.{
        viewport_count = 1,
        p_viewports    = null,
        scissor_count  = 1,
        p_scissors     = null,
    };

    rasterization_state_create_info := VK.Pipeline_Rasterization_State_Create_Info.{
        polygon_mode = .FILL,
        cull_mode    = .NONE,
        front_face   = .COUNTER_CLOCKWISE,
        line_width   = 1,
    };

    multisample_state_create_info := VK.Pipeline_Multisample_State_Create_Info.{
        rasterization_samples = ._1,
    };

    color_blend_attachment_state := VK.Pipeline_Color_Blend_Attachment_State.{
        blend_enable = VK.FALSE,
        src_color_blend_factor = .SRC_ALPHA,
        dst_color_blend_factor = .ONE_MINUS_SRC_ALPHA,
        color_blend_op         = .ADD,
        src_alpha_blend_factor = .ONE,
        dst_alpha_blend_factor = .ONE_MINUS_SRC_ALPHA,
        alpha_blend_op         = .ADD,
        color_write_mask = .R | .G | .B | .A,
    };

    color_blend_state_create_info := VK.Pipeline_Color_Blend_State_Create_Info.{
        attachment_count = 1,
        p_attachments    = *color_blend_attachment_state,
    };

    dynamic_states := VK.Dynamic_State.[
        .VIEWPORT,
        .SCISSOR,
    ];

    dynamic_state_create_info := VK.Pipeline_Dynamic_State_Create_Info.{
        dynamic_state_count = dynamic_states.count,
        p_dynamic_states    = dynamic_states.data,
    };

    rendering_create_info := VK.Pipeline_Rendering_Create_Info.{
        color_attachment_count     = 1,
        p_color_attachment_formats = *color_attachment_format,
        depth_attachment_format    = depth_attachment_format,
    };

    pipeline_create_info := VK.Graphics_Pipeline_Create_Info.{
        p_next                 = *rendering_create_info,
        stage_count            = shader_stage_create_infos.count,
        p_stages               = shader_stage_create_infos.data,
        p_vertex_input_state   = *vertex_input_state_create_info,
        p_input_assembly_state = *input_assembly_state_create_info,
        p_viewport_state       = *viewport_state_create_info,
        p_rasterization_state  = *rasterization_state_create_info,
        p_multisample_state    = *multisample_state_create_info,
        p_depth_stencil_state  = *depth_stencil_state_create_info,
        p_color_blend_state    = *color_blend_state_create_info,
        p_dynamic_state        = *dynamic_state_create_info,
        layout                 = layout,
        render_pass            = null,
    };

    result:, pipeline = VK.create_graphics_pipeline(
        device,
        null,
        *pipeline_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create line pipeline: %", result),
            layout,
            pipeline;
    }

    return "", layout, pipeline;
}

Line_Pipeline_Push_Constants :: struct @Gpu {
    line_buffer_address:       VK.Device_Address;
    view_projection_transform: Matrix4;
}
