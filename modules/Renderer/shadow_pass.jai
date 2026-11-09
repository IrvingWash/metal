#scope_module

Shadow_Pass :: struct {
    descriptor_pool:       VK.Descriptor_Pool;
    descriptor_set_layout: VK.Descriptor_Set_Layout;
    descriptor_set:       VK.Descriptor_Set;

    sampler: VK.Sampler;

    directional_light_shadow_maps: [MAX_DIRECTIONAL_LIGHT_SHADOW_MAP_COUNT]Image_Info;
    occupied_directional_light_shadow_map_count: u32;

    spot_light_shadow_maps: [MAX_SPOT_LIGHT_SHADOW_MAP_COUNT]Image_Info;
    occupied_spot_light_shadow_map_count: u32;

    pipeline_info: Shadow_Pass_Pipeline_Info;
}

Light_Kind :: enum {
    DIRECTIONAL;
    SPOT;
}

create_shadow_pass :: (
    device:                        VK.Device,
    allocator:                     VMA.Allocator,
    transient_command_pool:        VK.Command_Pool,
    queue:                         VK.Queue,
    get_compiled_shader:           Get_Compiled_Shader,
    texture_descriptor_set_layout: VK.Descriptor_Set_Layout,
) -> error: string, Shadow_Pass {
    shadow_pass: Shadow_Pass;

    result:, shadow_pass.sampler = VK.create_sampler(
        device,
        *(VK.Sampler_Create_Info.{
            min_filter     = .LINEAR,
            mag_filter     = .LINEAR,
            address_mode_u = .CLAMP_TO_BORDER,
            address_mode_v = .CLAMP_TO_BORDER,
            border_color   = .FLOAT_OPAQUE_WHITE,
            compare_enable = VK.TRUE,
            compare_op     = .LESS_OR_EQUAL,
        }),
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create sampler shadow pass: %", result),
            shadow_pass;
    }

    error:,
        shadow_pass.descriptor_pool,
        shadow_pass.descriptor_set_layout,
        shadow_pass.descriptor_set = create_shadow_pass_descriptor(device);
    if error {
        return
            tprint("Failed to create descriptors for shadow pass: %", error),
            shadow_pass;
    }

    error, shadow_pass.pipeline_info = create_shadow_pass_pipeline_info(
        device,
        get_compiled_shader,
        DEFAULT_SHADOW_DEPTH_IMAGE_FORMAT,
        .[texture_descriptor_set_layout],
    );
    if error {
        return
            tprint("Failed to create pipeline for shadow pass: %", error),
            shadow_pass;
    }

    error, shadow_pass.directional_light_shadow_maps = create_shadow_maps(
        device,
        allocator,
        transient_command_pool,
        queue,
        shadow_pass.sampler,
        shadow_pass.descriptor_set,
        binding = 0,
        MAX_DIRECTIONAL_LIGHT_SHADOW_MAP_COUNT,
        DEFAULT_DIRECTIONAL_LIGHT_SHADOW_DEPTH_IMAGE_WIDTH,
        DEFAULT_DIRECTIONAL_LIGHT_SHADOW_DEPTH_IMAGE_HEIGHT,
    );
    if error {
        return
            tprint("Failed to create directional light shadow maps: %", error),
            shadow_pass;
    }

    error, shadow_pass.spot_light_shadow_maps = create_shadow_maps(
        device,
        allocator,
        transient_command_pool,
        queue,
        shadow_pass.sampler,
        shadow_pass.descriptor_set,
        binding = 1,
        MAX_SPOT_LIGHT_SHADOW_MAP_COUNT,
        DEFAULT_SPOT_LIGHT_SHADOW_DEPTH_IMAGE_WIDTH,
        DEFAULT_SPOT_LIGHT_SHADOW_DEPTH_IMAGE_HEIGHT,
    );
    if error {
        return
            tprint("Failed to create sopt light shadow maps: %", error),
            shadow_pass;
    }

    return "", shadow_pass;
}

destroy_shadow_pass :: (
    shadow_pass: *Shadow_Pass,
    device:      VK.Device,
    allocator:   VMA.Allocator,
) {
    for *map: shadow_pass.spot_light_shadow_maps {
        destroy_image_info(
            device,
            allocator,
            map,
        );
    }

    for *map: shadow_pass.directional_light_shadow_maps {
        destroy_image_info(
            device,
            allocator,
            map,
        );
    }

    VK.destroy_sampler(device, shadow_pass.sampler);

    destroy_shadow_pass_pipeline_info(
        *shadow_pass.pipeline_info,
        device,
    );

    VK.destroy_descriptor_set_layout(device, shadow_pass.descriptor_set_layout);
    VK.destroy_descriptor_pool(device, shadow_pass.descriptor_pool);

    shadow_pass.* = {};
}

do_shadow_pass :: (
    shadow_pass:                     *Shadow_Pass,
    light_kind:                      Light_Kind,
    light_view_projection_transform: Matrix4,
    command_buffer:                  VK.Command_Buffer,
    mesh_geometry_info:              Mesh_Geometry_Info,
    materials_info:                  Materials_Info,
    model_pass:                      Model_Pass,
    frame_index:                     u64,
) {
    image_info: Image_Info;
    if #complete light_kind == {
        case .DIRECTIONAL;
            assert(shadow_pass.occupied_directional_light_shadow_map_count < MAX_DIRECTIONAL_LIGHT_SHADOW_MAP_COUNT);

            image_info = shadow_pass
                .directional_light_shadow_maps[shadow_pass.occupied_directional_light_shadow_map_count];

            shadow_pass.occupied_directional_light_shadow_map_count += 1;
        case .SPOT;
            assert(shadow_pass.occupied_spot_light_shadow_map_count < MAX_SPOT_LIGHT_SHADOW_MAP_COUNT);
            image_info = shadow_pass
                .spot_light_shadow_maps[shadow_pass.occupied_spot_light_shadow_map_count];

            shadow_pass.occupied_spot_light_shadow_map_count += 1;
    }

    // Transition to depth attachment
    transition_images_layouts(
        command_buffer,
        {
            src_stage_mask  = .EARLY_FRAGMENT_TESTS | .LATE_FRAGMENT_TESTS | .FRAGMENT_SHADER,
            src_access_mask = .DEPTH_STENCIL_ATTACHMENT_WRITE,
            dst_stage_mask  = .EARLY_FRAGMENT_TESTS | .LATE_FRAGMENT_TESTS,
            dst_access_mask = .DEPTH_STENCIL_ATTACHMENT_READ | .DEPTH_STENCIL_ATTACHMENT_WRITE,
            old_layout      = .UNDEFINED,
            new_layout      = .DEPTH_ATTACHMENT_OPTIMAL,
            image           = image_info.image,
            subresource_range = {
                aspect_mask      = .DEPTH,
                level_count      = 1,
                layer_count      = 1,
            },
        }
    );

    { // Begin rendering
        depth_rendering_attachment_info := VK.Rendering_Attachment_Info.{
            image_view                      = image_info.image_view,
            image_layout                    = .DEPTH_ATTACHMENT_OPTIMAL,
            load_op                         = .CLEAR,
            store_op                        = .STORE,
            clear_value.depth_stencil.depth = 1,
        };

        rendering_info := VK.Rendering_Info.{
            render_area = {
                offset = { x = 0, y = 0 },
                extent = image_info.extent,
            },
            layer_count = 1,
            p_depth_attachment = *depth_rendering_attachment_info,
        };

        VK.cmd_begin_rendering(command_buffer, *rendering_info);
    }

    { // Viewport and scissor
        viewport := VK.Viewport.{
            x      = 0,
            y      = cast(float, image_info.extent.height),
            width  = cast(float, image_info.extent.width),
            height = -cast(float, image_info.extent.height),
            min_depth = 0,
            max_depth = 1,
        };
        VK.cmd_set_viewport(command_buffer, VK.Viewport.[viewport]);

        scissor := VK.Rect_2D.{
            offset = {
                x = 0,
                y = 0,
            },
            extent = image_info.extent,
        };
        VK.cmd_set_scissor(command_buffer, VK.Rect_2D.[scissor]);
    }

    { // Push constants
        push_constants: Push_Constants = {
            vertex_buffer_address   = mesh_geometry_info.vertex_buffer_info.device_address,
            material_buffer_address = materials_info.material_buffer_info.device_address,
            instance_buffer_address = model_pass.instance_buffer_infos[frame_index].device_address,

            view_projection_transform = light_view_projection_transform,
        };

        VK.cmd_push_constants(
            command_buffer,
            shadow_pass.pipeline_info.layout,
            stage_flags = .VERTEX | .FRAGMENT,
            offset = 0,
            size_of(Push_Constants),
            *push_constants,
        );
    }

    VK.cmd_bind_index_buffer(
        command_buffer,
        mesh_geometry_info.index_buffer_info.buffer,
        offset = 0,
        index_type = .UINT32,
    );

    VK.cmd_bind_descriptor_sets(
        command_buffer,
        pipeline_bind_point = .GRAPHICS,
        shadow_pass.pipeline_info.layout,
        first_set = 0,
        .[
            materials_info.texture_descriptor_set,
        ],
        .[],
    );

    VK.cmd_set_depth_bias(
        command_buffer,
        constant_factor = 1.25,
        clamp = 0,
        slope_factor = 1.75,
    );

    { // Draw
        bound_pipeline: VK.Pipeline;
        for model_draw_bucket: model_pass.ordered_draw_buckets {
            if model_draw_bucket.command_count == 0 {
                continue;
            }

            if #complete model_draw_bucket.alpha_mode == {
                case .BLEND;
                    continue;
                case .OPAQUE;
                    if bound_pipeline != shadow_pass.pipeline_info.opaque_pipeline {
                        VK.cmd_bind_pipeline(command_buffer, .GRAPHICS, shadow_pass.pipeline_info.opaque_pipeline);
                        bound_pipeline = shadow_pass.pipeline_info.opaque_pipeline;
                    }
                case .MASK;
                    if bound_pipeline != shadow_pass.pipeline_info.mask_pipeline {
                        VK.cmd_bind_pipeline(command_buffer, .GRAPHICS, shadow_pass.pipeline_info.mask_pipeline);
                        bound_pipeline = shadow_pass.pipeline_info.mask_pipeline;
                    }
            }

            VK.cmd_set_cull_mode(command_buffer, model_draw_bucket.cull_mode);

            VK.cmd_draw_indexed_indirect(
                command_buffer,
                model_pass.indirect_draw_buffer_infos[frame_index].buffer,
                offset     = cast(u64, model_draw_bucket.first_command_index * size_of(VK.Draw_Indexed_Indirect_Command)),
                draw_count = cast(u32, model_draw_bucket.command_count),
                stride     = size_of(VK.Draw_Indexed_Indirect_Command),
            );
        }
    }

    VK.cmd_end_rendering(command_buffer);

    // Transition for sampling
    transition_images_layouts(
        command_buffer,
        {
            src_stage_mask  = .EARLY_FRAGMENT_TESTS | .LATE_FRAGMENT_TESTS,
            src_access_mask = .DEPTH_STENCIL_ATTACHMENT_WRITE,
            dst_stage_mask  = .FRAGMENT_SHADER,
            dst_access_mask = .SHADER_SAMPLED_READ,
            old_layout      = .DEPTH_ATTACHMENT_OPTIMAL,
            new_layout      = .SHADER_READ_ONLY_OPTIMAL,
            image           = image_info.image,
            subresource_range = {
                aspect_mask = .DEPTH,
                level_count = 1,
                layer_count = 1,
            },
        },
    );
}

reset_shadow_pass :: (shadow_pass: *Shadow_Pass) {
    shadow_pass.occupied_directional_light_shadow_map_count = 0;
    shadow_pass.occupied_spot_light_shadow_map_count = 0;
}



#scope_file

MAX_DIRECTIONAL_LIGHT_SHADOW_MAP_COUNT :: MAX_DIRECTIONAL_LIGHT_COUNT;
MAX_SPOT_LIGHT_SHADOW_MAP_COUNT        :: MAX_SHADOWED_SPOT_LIGHT_COUNT;

DEFAULT_SHADOW_DEPTH_IMAGE_FORMAT :: VK.Format.D32_SFLOAT;
DEFAULT_DIRECTIONAL_LIGHT_SHADOW_DEPTH_IMAGE_WIDTH  :: 2048;
DEFAULT_DIRECTIONAL_LIGHT_SHADOW_DEPTH_IMAGE_HEIGHT :: 2048;
DEFAULT_SPOT_LIGHT_SHADOW_DEPTH_IMAGE_WIDTH :: 512;
DEFAULT_SPOT_LIGHT_SHADOW_DEPTH_IMAGE_HEIGHT :: 512;

create_shadow_maps :: (
    device:                 VK.Device,
    allocator:              VMA.Allocator,
    transient_command_pool: VK.Command_Pool,
    queue:                  VK.Queue,
    sampler:                VK.Sampler,
    descriptor_set:         VK.Descriptor_Set,
    binding:                u32,
    $count:                 u32,
    width: u32,
    height: u32,
) -> error: string, [count]Image_Info {
    maps: [count]Image_Info;

    for *map: maps {
        error:, map.* = create_image_info(
            device,
            allocator,
            DEFAULT_SHADOW_DEPTH_IMAGE_FORMAT,
            width,
            height,
            depth = 1,
            tiling = .OPTIMAL,
            usage = .DEPTH_STENCIL_ATTACHMENT | .SAMPLED,
            allocation_flags = .DEDICATED_MEMORY,
            aspect_mask = .DEPTH,
        );
        if error {
            return
                tprint("Failed to create image for shadow map: %", error),
                maps;
        }
    }

    { // Transition to shader readonly
        error, transient_command_buffer := start_transient_command_buffer(
            device,
            transient_command_pool,
        );
        if error {
            return
                tprint("Failed to start trainsient command buffer to transition shadow map: %", error),
                maps;
        }

        params: [..]Transition_Image_Layout_Params;
        params.allocator = temp;
        for map: maps {
            array_add(
                *params,
                {
                    src_stage_mask  = .NONE,
                    src_access_mask = .NONE,
                    dst_stage_mask  = .FRAGMENT_SHADER,
                    dst_access_mask = .SHADER_SAMPLED_READ,
                    old_layout      = .UNDEFINED,
                    new_layout      = .SHADER_READ_ONLY_OPTIMAL,
                    image           = map.image,
                    subresource_range = {
                        aspect_mask      = .DEPTH,
                        level_count      = 1,
                        layer_count      = 1,
                    },
                },
            );
        }

        transition_images_layouts(
            transient_command_buffer,
            ..params,
        );

        error = submit_transient_command_buffer(
            device,
            transient_command_pool,
            queue,
            transient_command_buffer,
        );
        if error {
            return
                tprint("Failed to submit trainsient command buffer to transition shadow map: %", error),
                maps;
        }
    }

    { // Write images
        image_descriptors: [..]VK.Descriptor_Image_Info;
        image_descriptors.allocator = temp;
        for map: maps {
            descriptor := VK.Descriptor_Image_Info.{
                sampler      = sampler,
                image_view   = map.image_view,
                image_layout = .SHADER_READ_ONLY_OPTIMAL,
            };

            array_add(*image_descriptors, descriptor);
        }
        write := VK.Write_Descriptor_Set.{
            dst_set           = descriptor_set,
            dst_binding       = binding,
            dst_array_element = 0,
            descriptor_type   = .COMBINED_IMAGE_SAMPLER,
            descriptor_count  = cast(u32, image_descriptors.count),
            p_image_info      = image_descriptors.data,
        };

        VK.update_descriptor_sets(device, .[write], .[]);
    }

    return "", maps;
}

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

create_shadow_pass_descriptor :: (device: VK.Device) -> error: string,
    VK.Descriptor_Pool,
    VK.Descriptor_Set_Layout,
    VK.Descriptor_Set
{
    descriptor_pool:       VK.Descriptor_Pool;
    descriptor_set_layout: VK.Descriptor_Set_Layout;
    descriptor_set:        VK.Descriptor_Set;

    { // Pool
        descriptor_pool_size := VK.Descriptor_Pool_Size.{
            type             = .COMBINED_IMAGE_SAMPLER,
            descriptor_count = MAX_DIRECTIONAL_LIGHT_SHADOW_MAP_COUNT + MAX_SPOT_LIGHT_SHADOW_MAP_COUNT,
        };

        descriptor_pool_create_info := VK.Descriptor_Pool_Create_Info.{
            max_sets        = 1,
            pool_size_count = 1,
            p_pool_sizes    = *descriptor_pool_size,
        };
        result:, descriptor_pool = VK.create_descriptor_pool(device, *descriptor_pool_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create descriptor pool for shadow pass: %", result),
                descriptor_pool,
                descriptor_set_layout,
                descriptor_set;
        }
    }

    { // Layout
        bindings := VK.Descriptor_Set_Layout_Binding.[
            {
                binding          = 0,
                descriptor_type  = .COMBINED_IMAGE_SAMPLER,
                descriptor_count = MAX_DIRECTIONAL_LIGHT_SHADOW_MAP_COUNT,
                stage_flags      = .FRAGMENT,
            },
            {
                binding          = 1,
                descriptor_type  = .COMBINED_IMAGE_SAMPLER,
                descriptor_count = MAX_SPOT_LIGHT_SHADOW_MAP_COUNT,
                stage_flags      = .FRAGMENT,
            }
        ];

        descriptor_set_layout_create_info := VK.Descriptor_Set_Layout_Create_Info.{
            binding_count = bindings.count,
            p_bindings    = bindings.data,
        };

        result:, descriptor_set_layout = VK.create_descriptor_set_layout(
            device,
            *descriptor_set_layout_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create descriptor set layout for shadow pass: %", result),
                descriptor_pool,
                descriptor_set_layout,
                descriptor_set;
        }
    }

    { // Set
        descriptor_set_allocate_info := VK.Descriptor_Set_Allocate_Info.{
            descriptor_pool      = descriptor_pool,
            descriptor_set_count = 1,
            p_set_layouts        = *descriptor_set_layout,
        };

        result, created_descriptor_sets := VK.allocate_descriptor_sets(device, *descriptor_set_allocate_info,, temp);
        if result != .SUCCESS {
            return
                tprint("Failed to allocate descriptor sets for shadow pass: %", result),
                descriptor_pool,
                descriptor_set_layout,
                descriptor_set;
        }

        descriptor_set = created_descriptor_sets[0];
    }

    return
        "",
        descriptor_pool,
        descriptor_set_layout,
        descriptor_set;
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
