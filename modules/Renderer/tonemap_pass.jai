Tonemap_Pass :: struct {
    descriptor_pool:       VK.Descriptor_Pool;
    descriptor_set_layout: VK.Descriptor_Set_Layout;
    descriptor_set:        VK.Descriptor_Set;

    sampler: VK.Sampler;

    pipeline_layout: VK.Pipeline_Layout;
    pipeline:        VK.Pipeline;

    exposure: float = 1;
}

create_tonemap_pass :: (
    device:                      VK.Device,
    get_compiled_shader:         Get_Compiled_Shader,
    color_attachment_format:     VK.Format,
    color_hdr_target_image_view: VK.Image_View,
) -> error: string, Tonemap_Pass {
    ERROR_IF_ERROR :: () #expand {
        if `error {
            `return
                `error,
                `tonemap_pass;
        }
    }

    tonemap_pass: Tonemap_Pass;

    error:,
        tonemap_pass.descriptor_pool,
        tonemap_pass.descriptor_set_layout,
        tonemap_pass.descriptor_set = create_tonemap_pass_descriptor_sets(device);
    ERROR_IF_ERROR();

    error,
        tonemap_pass.pipeline_layout,
        tonemap_pass.pipeline = create_tonemap_pipeline(
            device,
            get_compiled_shader,
            color_attachment_format,
            tonemap_pass.descriptor_set_layout,
        );
    ERROR_IF_ERROR();

    result:, tonemap_pass.sampler = VK.create_sampler(device, *(VK.Sampler_Create_Info.{
        mag_filter     = .NEAREST,
        min_filter     = .NEAREST,
        address_mode_u = .CLAMP_TO_EDGE,
        address_mode_v = .CLAMP_TO_EDGE,
        address_mode_w = .CLAMP_TO_EDGE,
    }));
    if result != .SUCCESS {
        return
            tprint("Failed to create sampler for tonemap pass: %", error),
            tonemap_pass;
    }

    set_hdr_color_target_image_view_to_tonemap_pass(
        *tonemap_pass,
        color_hdr_target_image_view,
        device,
    );

    return "", tonemap_pass;
}

destroy_tonemap_pass :: (tonemap_pass: *Tonemap_Pass, device: VK.Device) {
    VK.destroy_sampler(device, tonemap_pass.sampler);

    VK.destroy_pipeline(device, tonemap_pass.pipeline);
    VK.destroy_pipeline_layout(device, tonemap_pass.pipeline_layout);

    VK.destroy_descriptor_set_layout(device, tonemap_pass.descriptor_set_layout);
    VK.destroy_descriptor_pool(device, tonemap_pass.descriptor_pool);

    tonemap_pass.* = {};
}

do_tonemap_pass :: (
    tonemap_pass:     *Tonemap_Pass,
    color_hdr_target: Color_Hdr_Target,
    color_ldr_target: Image_Info,
    command_buffer:   VK.Command_Buffer,
) {
    { // HDR to shader read, LDR to color attachment
        barriers := VK.Image_Memory_Barrier_2.[
            {
                src_stage_mask  = .COLOR_ATTACHMENT_OUTPUT,
                src_access_mask = .COLOR_ATTACHMENT_WRITE,
                dst_stage_mask  = .FRAGMENT_SHADER,
                dst_access_mask = .SHADER_SAMPLED_READ,
                old_layout      = .COLOR_ATTACHMENT_OPTIMAL,
                new_layout      = .SHADER_READ_ONLY_OPTIMAL,
                image           = color_hdr_target.image_info.image,
                subresource_range = {
                    aspect_mask = .COLOR,
                    level_count = 1,
                    layer_count = 1,
                },
            },
            {
                src_stage_mask  = .BLIT,
                src_access_mask = 0,
                dst_stage_mask  = .COLOR_ATTACHMENT_OUTPUT,
                dst_access_mask = .COLOR_ATTACHMENT_WRITE,
                old_layout      = .UNDEFINED,
                new_layout      = .COLOR_ATTACHMENT_OPTIMAL,
                image           = color_ldr_target.image,
                subresource_range = {
                    aspect_mask = .COLOR,
                    level_count = 1,
                    layer_count = 1,
                },
            },
        ];

        dependency_info := VK.Dependency_Info.{
            image_memory_barrier_count = barriers.count,
            p_image_memory_barriers    = barriers.data,
        };

        VK.cmd_pipeline_barrier_2(command_buffer, *dependency_info);
    }

    { // Begin rendering
        color_rendering_attachment_info := VK.Rendering_Attachment_Info.{
            image_view                 = color_ldr_target.image_view,
            image_layout               = .COLOR_ATTACHMENT_OPTIMAL,
            load_op                    = .DONT_CARE,
            store_op                   = .STORE,
            clear_value.color._float32 = .[ 0, 0, 0, 1 ],
        };

        rendering_info := VK.Rendering_Info.{
            render_area = {
                offset = { x = 0, y = 0 },
                extent = color_ldr_target.extent,
            },
            layer_count = 1,
            color_attachment_count = 1,
            p_color_attachments = *color_rendering_attachment_info,
        };

        VK.cmd_begin_rendering(command_buffer, *rendering_info);
    }

    { // Set viewport and scissor
        viewport := VK.Viewport.{
            x      = 0,
            y      = cast(float, color_ldr_target.extent.height),
            width  = cast(float, color_ldr_target.extent.width),
            height = -cast(float, color_ldr_target.extent.height),
            min_depth = 0,
            max_depth = 1,
        };
        VK.cmd_set_viewport(command_buffer, VK.Viewport.[viewport]);

        scissor := VK.Rect_2D.{
            offset = {
                x = 0,
                y = 0,
            },
            extent = color_ldr_target.extent,
        };
        VK.cmd_set_scissor(command_buffer, VK.Rect_2D.[scissor]);
    }

    { // Push constants
        push_constants: Push_Constants = {
            exposure = tonemap_pass.exposure,
        };

        VK.cmd_push_constants(
            command_buffer,
            tonemap_pass.pipeline_layout,
            stage_flags = .FRAGMENT,
            offset = 0,
            size_of(Push_Constants),
            *push_constants,
        );
    }

    VK.cmd_bind_descriptor_sets(
        command_buffer,
        pipeline_bind_point = .GRAPHICS,
        tonemap_pass.pipeline_layout,
        first_set = 0,
        .[
            tonemap_pass.descriptor_set,
        ],
        .[],
    );

    VK.cmd_bind_pipeline(command_buffer, .GRAPHICS, tonemap_pass.pipeline);

    VK.cmd_draw(command_buffer, 3, 1, 0, 0);

    VK.cmd_end_rendering(command_buffer);
}

set_hdr_color_target_image_view_to_tonemap_pass :: (
    tonemap_pass: *Tonemap_Pass,
    image_view: VK.Image_View,
    device: VK.Device,
) {
    image_descriptor := VK.Descriptor_Image_Info.{
        sampler      = tonemap_pass.sampler,
        image_view   = image_view,
        image_layout = .SHADER_READ_ONLY_OPTIMAL,
    };

    write := VK.Write_Descriptor_Set.{
        dst_set           = tonemap_pass.descriptor_set,
        dst_binding       = 0,
        dst_array_element = 0,
        descriptor_count  = 1,
        descriptor_type   = .COMBINED_IMAGE_SAMPLER,
        p_image_info      = *image_descriptor,
    };

    VK.update_descriptor_sets(device, .[write], .[]);
}



#scope_file

Push_Constants :: struct @Gpu {
    exposure: float = 1;
}

create_tonemap_pass_descriptor_sets :: (device: VK.Device) -> error: string,
    VK.Descriptor_Pool,
    VK.Descriptor_Set_Layout,
    VK.Descriptor_Set
{
    ERROR_IF_NOT_SUCCESS :: (format: string, args: ..Any) #expand {
        if `result != .SUCCESS {
            `return
                tprint(format, ..args),
                `descriptor_pool,
                `descriptor_set_layout,
                `descriptor_set;
        }
    }

    descriptor_pool:       VK.Descriptor_Pool;
    descriptor_set_layout: VK.Descriptor_Set_Layout;
    descriptor_set:        VK.Descriptor_Set;

    { // Pool
        descriptor_pool_size := VK.Descriptor_Pool_Size.{
            type             = .COMBINED_IMAGE_SAMPLER,
            descriptor_count = 1,
        };

        descriptor_pool_create_info := VK.Descriptor_Pool_Create_Info.{
            max_sets        = 1,
            pool_size_count = 1,
            p_pool_sizes    = *descriptor_pool_size,
        };
        result:, descriptor_pool = VK.create_descriptor_pool(device, *descriptor_pool_create_info);
        ERROR_IF_NOT_SUCCESS("Failed to create descriptor pool for tonepmap pass: %", result);
    }

    { // Layout
        bindings := VK.Descriptor_Set_Layout_Binding.{
            binding          = 0,
            descriptor_type  = .COMBINED_IMAGE_SAMPLER,
            descriptor_count = 1,
            stage_flags      = .FRAGMENT,
        };

        descriptor_set_layout_create_info := VK.Descriptor_Set_Layout_Create_Info.{
            binding_count = 1,
            p_bindings    = *bindings,
        };

        result:, descriptor_set_layout = VK.create_descriptor_set_layout(
            device,
            *descriptor_set_layout_create_info,
        );
        ERROR_IF_NOT_SUCCESS("Failed to create descriptor set layout for tonepmap pass: %", result);
    }

    { // Set
        descriptor_set_allocate_info := VK.Descriptor_Set_Allocate_Info.{
            descriptor_pool      = descriptor_pool,
            descriptor_set_count = 1,
            p_set_layouts        = *descriptor_set_layout,
        };

        result, created_descriptor_sets := VK.allocate_descriptor_sets(device, *descriptor_set_allocate_info,, temp);
        ERROR_IF_NOT_SUCCESS("Failed to allocate descriptor sets for tonepmap pass: %", result);

        descriptor_set = created_descriptor_sets[0];
    }

    return
        "",
        descriptor_pool,
        descriptor_set_layout,
        descriptor_set;
}

create_tonemap_pipeline :: (
    device:                  VK.Device,
    get_compiled_shader:     Get_Compiled_Shader,
    color_attachment_format: VK.Format,
    descriptor_set_layout:   VK.Descriptor_Set_Layout,
) -> error: string, VK.Pipeline_Layout, VK.Pipeline {
    ERROR_IF_NOT_SUCCESS :: (format: string, args: ..Any) #expand {
        if `result != .SUCCESS {
            `return
                tprint(format, ..args),
                `pipeline_layout,
                `pipeline;
        }
    }

    ERROR_IF_ERROR :: () #expand {
        if `error {
            `return
                `error,
                `pipeline_layout,
                `pipeline;
        }
    }

    pipeline_layout: VK.Pipeline_Layout;
    pipeline:        VK.Pipeline;

    { // Layout
        push_constant_range := VK.Push_Constant_Range.{
            stage_flags = .FRAGMENT,
            offset      = 0,
            size        = size_of(Push_Constants),
        };

        layout_create_info := VK.Pipeline_Layout_Create_Info.{
            set_layout_count          = 1,
            p_set_layouts             = *descriptor_set_layout,
            push_constant_range_count = 1,
            p_push_constant_ranges    = *push_constant_range,
        };

        result:, pipeline_layout = VK.create_pipeline_layout(device, *layout_create_info);
        ERROR_IF_NOT_SUCCESS("Failed to create layout for tonemap pipeline: %", result);
    }

    error, vertex_shader := create_shader_module(device, "tonemap.vertex.spv", get_compiled_shader);
    ERROR_IF_ERROR();
    defer VK.destroy_shader_module(device, vertex_shader);

    error =, fragment_shader := create_shader_module(device, "tonemap.fragment.spv", get_compiled_shader);
    ERROR_IF_ERROR();
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
        topology = .TRIANGLE_LIST,
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
        p_color_blend_state    = *color_blend_state_create_info,
        p_dynamic_state        = *dynamic_state_create_info,
        layout                 = pipeline_layout,
        render_pass            = null,
    };

    result:, pipeline = VK.create_graphics_pipeline(
        device,
        null,
        *pipeline_create_info,
    );
    ERROR_IF_NOT_SUCCESS("Failed to create pipeline for tonemap pass: %", result);

    return
        "",
        pipeline_layout,
        pipeline;
}
