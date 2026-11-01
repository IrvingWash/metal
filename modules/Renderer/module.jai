#module_parameters()(Window_Type: Type, APPLICATION_NAME: string, DEBUG: bool = false);

Renderer :: struct {
    window:                 Window_Type;
    get_window_render_size: Get_Window_Render_Size; // @Todo: maybe remove this, so Renderer doesn't know
    get_compiled_shader:    Get_Compiled_Shader;

    instance:            VK.Instance;
    surface:             VK.Surface_Khr;
    physical_device:     VK.Physical_Device;
    graphics_queue_info: Queue_Info;
    device:              VK.Device;
    allocator:           VMA.Allocator;

    timeline_semaphore_info: Timeline_Semaphore_Info;
    transient_command_pool:  VK.Command_Pool;

    swapchain_info:   Swapchain_Info;
    depth_image_info: Image_Info;
    color_target:     Color_Target;

    frame_resources_list: [FRAMES_IN_FLIGHT_COUNT]Frame_Resources;

    light_info: Light_Info;
    materials_info: Materials_Info;
    geometry_info: Geometry_Info;

    common_pipeline_info: Pipeline_Info;

    normalized_clear_color: Vector4 = { 0.01, 0.01, 0.01, 1 };
    frame_index: u64;

    transforms: Transforms;

    models_this_frame: [..]Model;

    #if DEBUG {
        debug_utils_messenger: VK.Debug_Utils_Messenger_Ext;
    }
}

// =============================================================================
// Structs and procedure pointer types
// =============================================================================

Get_Additional_Instance_Extensions :: #type () -> [..]*u8;

Get_Window_Render_Size :: #type (window: Window_Type) -> width: u32, height: u32;

Create_Window_Surface :: #type (
    window: Window_Type,
    instance: VK.Instance,
    allocator: *VK.Allocation_Callbacks = null,
) -> VK.Surface_Khr;

Get_Compiled_Shader :: #type (name: string) -> error: string, content: string;

Create_Sampler_Params :: VK.Sampler_Create_Info;

Image_Params :: struct {
    width:  u32;
    height: u32;
    bytes:  []u8;
}

Camera :: struct {
    position: Vector3;
    target: Vector3;

    up: Vector3;

    z_near: float;
    z_far:  float;

    fov_vertical: float;
}

Directional_Light :: struct @Gpu {
    direction: Vector3 = { 0, -1, 0 };
    color:     Vector3 = { 1, 1, 1 };
}

Color_Target :: struct {
    image_info:      Image_Info;
    extent:          VK.Extent_2D;
    should_recreate: bool;
}

// =============================================================================
// Public API
// =============================================================================

init :: (
    window:                             Window_Type,
    get_additional_instance_extensions: Get_Additional_Instance_Extensions,
    window_render_size_getter:          Get_Window_Render_Size,
    create_window_surface:              Create_Window_Surface,
    get_compiled_shader:                Get_Compiled_Shader,
) -> error: string, Renderer {
    renderer: Renderer;

    renderer.window                 = window;
    renderer.get_window_render_size = window_render_size_getter;
    renderer.get_compiled_shader    = get_compiled_shader;

    error:, renderer.instance = create_instance(get_additional_instance_extensions);
    if error {
        return
            error,
            renderer;
    }

    #if DEBUG {
        renderer.debug_utils_messenger = create_debug_utils_messenger(renderer.instance);
    }

    error, renderer.surface = create_surface(
        renderer.instance,
        renderer.window,
        create_window_surface,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.physical_device = find_physical_device(renderer.instance, renderer.surface);
    if error {
        return
            error,
            renderer;
    }

    error, renderer.graphics_queue_info.family_index = find_graphics_queue_family_index(
        renderer.physical_device,
        renderer.surface,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.device = create_device(renderer.physical_device, .[renderer.graphics_queue_info]);
    if error {
        return
            error,
            renderer;
    }

    renderer.graphics_queue_info.queue = VK.get_device_queue(
        renderer.device,
        renderer.graphics_queue_info.family_index,
        queue_index = 0,
    );

    error, renderer.allocator = create_allocator(
        renderer.instance,
        renderer.physical_device,
        renderer.device,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.timeline_semaphore_info = create_timeline_semaphore(renderer.device);
    if error {
        return
            error,
            renderer;
    }

    error, renderer.transient_command_pool = create_transient_command_pool(
        renderer.device,
        renderer.graphics_queue_info.family_index,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.swapchain_info = create_swapchain(
        renderer.physical_device,
        renderer.surface,
        renderer.device,
        renderer.window,
        renderer.get_window_render_size,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.color_target = create_color_target(
        renderer.device,
        renderer.allocator,
        renderer.swapchain_info.config.image_extent.width,
        renderer.swapchain_info.config.image_extent.height,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.depth_image_info = create_depth_image(
        renderer.device,
        renderer.allocator,
        renderer.color_target.extent.width,
        renderer.color_target.extent.height,
    );
    if error {
        return
            error,
            renderer;
    }

    error, renderer.light_info = create_light_info(
        renderer.device,
        renderer.allocator,
    );
    if error {
        return
            error,
            renderer;
    }

    for *frame_resources: renderer.frame_resources_list {
        error:, frame_resources.* = create_frame_resources(
            renderer.device,
            renderer.allocator,
            renderer.graphics_queue_info.family_index,
        );
        if error {
            return
                error,
                renderer;
        }
    }

    error, renderer.materials_info = create_materials_info(renderer.device, renderer.allocator);
    if error {
        return
            error,
            renderer;
    }

    error, renderer.geometry_info = create_geometry_info(renderer.device, renderer.allocator);
    if error {
        return
            error,
            renderer;
    }

    error = create_fallbacks(*renderer);
    if error {
        return
            error,
            renderer;
    }

    error, renderer.common_pipeline_info = create_common_pipeline(
        renderer.device,
        renderer.get_compiled_shader,
        .[renderer.color_target.image_info.format],
        renderer.depth_image_info.format,
        .[
            renderer.materials_info.texture_descriptor_info.layout,
            renderer.light_info.layout,
        ],
    );
    if error {
        return
            error,
            renderer;
    }

    return
        "",
        renderer;
}

deinit :: (renderer: *Renderer) {
    VK.device_wait_idle(renderer.device);

    array_free(renderer.models_this_frame);

    destroy_geometry_info(renderer.allocator, *renderer.geometry_info);
    destroy_materials_info(renderer.device, renderer.allocator, *renderer.materials_info);

    destroy_pipeline(renderer.device, *renderer.common_pipeline_info);

    for *frame_resources: renderer.frame_resources_list {
        destroy_frame_resources(
            renderer.device,
            renderer.allocator,
            frame_resources,
        );
    }

    destroy_light_info(renderer.device, renderer.allocator, renderer.light_info);

    destroy_image( // Depth image
        renderer.device,
        renderer.allocator,
        *renderer.depth_image_info,
    );
    destroy_image(renderer.device, renderer.allocator, *renderer.color_target.image_info);
    destroy_swapchain(renderer.device, *renderer.swapchain_info);

    VK.destroy_command_pool(renderer.device, renderer.transient_command_pool);

    VK.destroy_semaphore(renderer.device, renderer.timeline_semaphore_info.semaphore);

    VMA.destroy_allocator(renderer.allocator);

    VK.destroy_device(renderer.device);

    VK.destroy_surface_khr(renderer.instance, renderer.surface);

    #if DEBUG {
        destroy_debug_utils_messenger(renderer.instance, renderer.debug_utils_messenger);
    }

    VK.destroy_instance(renderer.instance);

    renderer.* = {};
}

start_drawing :: (renderer: *Renderer, camera: $T/interface Camera) -> error: string {
    array_reset_keeping_memory(*renderer.models_this_frame);

    if renderer.swapchain_info.should_recreate {
        VK.device_wait_idle(renderer.device);

        destroy_swapchain(renderer.device, *renderer.swapchain_info);

        error:, renderer.swapchain_info = create_swapchain(
            renderer.physical_device,
            renderer.surface,
            renderer.device,
            renderer.window,
            renderer.get_window_render_size,
        );
        if error {
            return error;
        }

        renderer.swapchain_info.should_recreate = false;
    }

    if renderer.color_target.should_recreate {
        VK.device_wait_idle(renderer.device);

        error, new_color_target := create_color_target(
            renderer.device,
            renderer.allocator,
            renderer.color_target.extent.width,
            renderer.color_target.extent.height,
        );
        if error {
            return tprint("Failed to create new color target: %", error);
        }

        error =, new_depth_image := create_depth_image(
            renderer.device,
            renderer.allocator,
            renderer.color_target.extent.width,
            renderer.color_target.extent.height,
        );
        if error {
            return tprint("Failed to create new depth image: %", error);
        }

        destroy_image(renderer.device, renderer.allocator, *renderer.color_target.image_info);
        destroy_image(renderer.device, renderer.allocator, *renderer.depth_image_info);

        renderer.color_target = new_color_target;
        renderer.depth_image_info = new_depth_image;

        renderer.color_target.should_recreate = false; // Just in case
    }

    renderer.transforms.view = make_look_at_matrix(
        camera.position,
        camera.target,
        camera.up,
        x_is_forward = false,
    );
    aspect_ratio := cast(float, renderer.color_target.extent.width) / cast(float, renderer.color_target.extent.height);
    renderer.transforms.projection = make_projection_matrix(
        camera.fov_vertical,
        aspect_ratio,
        camera.z_near,
        camera.z_far,
        depth_range_01 = true,
    );
    renderer.transforms.view_projection = renderer.transforms.projection * renderer.transforms.view;

    return "";
}

draw_model :: (renderer: *Renderer, model: Model) {
    array_add(*renderer.models_this_frame, model);
}

finish_drawing :: (renderer: *Renderer) -> error: string {
    frame_resources_index := renderer.frame_index % FRAMES_IN_FLIGHT_COUNT;
    signal_value := renderer.timeline_semaphore_info.next_signal_value;

    { // Waiting for next available frame resources
        wait_value := signal_value - FRAMES_IN_FLIGHT_COUNT; // Because the inital value is offsetted by this

        semaphore_wait_info := VK.Semaphore_Wait_Info.{
            semaphore_count = 1,
            p_semaphores    = *renderer.timeline_semaphore_info.semaphore,
            p_values        = *wait_value,
        };
        result := VK.wait_semaphores(renderer.device, *semaphore_wait_info, U64_MAX);
        if result != .SUCCESS {
            return tprint("Failed to wait semaphores: %", result);
        }
    }

    renderer.light_info.pointers[frame_resources_index].* = renderer.light_info.directional_light;
    VMA.flush_allocation(
        renderer.allocator,
        renderer.light_info.buffer_infos[frame_resources_index].allocation,
        offset = 0,
        VK.WHOLE_SIZE,
    );

    frame_resources := renderer.frame_resources_list[frame_resources_index];

    { // Reset command pool
        result := VK.reset_command_pool(
            renderer.device,
            frame_resources.command_pool,
            flags = 0,
        );
        if result != .SUCCESS {
            return "Failed to reset command pool of a frame resources";
        }
    }

    swapchain_image_index: u32;
    { // Acquire swapchain image index and maybe set a flag to recreate the swapchain
        result:, swapchain_image_index = VK.acquire_next_image_khr(
            renderer.device,
            renderer.swapchain_info.swapchain,
            U64_MAX,
            frame_resources.image_acquired_semaphore,
            fence = null,
        );
        if result == {
            case .ERROR_OUT_OF_DATE_KHR;
                renderer.swapchain_info.should_recreate = true;
                return "";
            case .SUBOPTIMAL_KHR;
                renderer.swapchain_info.should_recreate = true;
            case;
                if result != .SUCCESS {
                    return "Failed to acquire next swapchain image";
                }
        }
    }
    renderer.frame_index += 1;
    renderer.timeline_semaphore_info.next_signal_value += 1;

    draw_index: int;
    for model: renderer.models_this_frame {
        for node: model.nodes {
            if node.parent_index.kind != .NONE {
                continue;
            }

            draw_node(
                renderer,
                node,
                *draw_index,
                model.nodes,
                *frame_resources,
                model.transform,
            );
        }
    }
    VMA.flush_allocation(
        renderer.allocator,
        frame_resources.indirect_draw_buffer_info.allocation,
        offset = 0,
        VK.WHOLE_SIZE,
    );
    VMA.flush_allocation(
        renderer.allocator,
        frame_resources.instance_buffer_info.allocation,
        offset = 0,
        VK.WHOLE_SIZE,
    );

    { // Begin command buffer
        command_buffer_begin_info := VK.Command_Buffer_Begin_Info.{
            flags = .ONE_TIME_SUBMIT,
        };
        result := VK.begin_command_buffer(frame_resources.command_buffer, *command_buffer_begin_info);
        if result != .SUCCESS {
            return "Failed to begin a command buffer";
        }
    }

    { // Transition the color target image into a renderable layout, so we can draw on it.
        render_layout_barriers := VK.Image_Memory_Barrier_2.[
            {
                src_stage_mask    = .BLIT, // For synchronization
                src_access_mask   = 0,
                dst_stage_mask    = .COLOR_ATTACHMENT_OUTPUT,
                dst_access_mask   = .COLOR_ATTACHMENT_WRITE,
                old_layout        = .UNDEFINED,
                new_layout        = .COLOR_ATTACHMENT_OPTIMAL,
                image             = renderer.color_target.image_info.image,
                subresource_range = {
                    aspect_mask      = .COLOR,
                    level_count      = 1,
                    layer_count      = 1,
                },
            },
            // Also transition the depth image
            {
                src_stage_mask  = .EARLY_FRAGMENT_TESTS | .LATE_FRAGMENT_TESTS,
                src_access_mask = .DEPTH_STENCIL_ATTACHMENT_WRITE,
                dst_stage_mask  = .EARLY_FRAGMENT_TESTS | .LATE_FRAGMENT_TESTS,
                dst_access_mask = .DEPTH_STENCIL_ATTACHMENT_READ | .DEPTH_STENCIL_ATTACHMENT_WRITE,
                old_layout      = .UNDEFINED,
                new_layout      = .DEPTH_ATTACHMENT_OPTIMAL,
                image           = renderer.depth_image_info.image,
                subresource_range = {
                    aspect_mask      = .DEPTH,
                    level_count      = 1,
                    layer_count      = 1,
                },
            }
        ];

        render_dependency_info := VK.Dependency_Info.{
            image_memory_barrier_count = render_layout_barriers.count,
            p_image_memory_barriers    = render_layout_barriers.data,
        };

        VK.cmd_pipeline_barrier_2(frame_resources.command_buffer, *render_dependency_info);
    }

    { // Specify the color and depth attachments and begin rendering
        color_rendering_attachment_info := VK.Rendering_Attachment_Info.{
            image_view                 = renderer.color_target.image_info.image_view,
            image_layout               = .COLOR_ATTACHMENT_OPTIMAL,
            load_op                    = .CLEAR,
            store_op                   = .STORE,
            clear_value.color._float32 = renderer.normalized_clear_color.component,
        };

        depth_rendering_attachment_info := VK.Rendering_Attachment_Info.{
            image_view                      = renderer.depth_image_info.image_view,
            image_layout                    = .DEPTH_ATTACHMENT_OPTIMAL,
            load_op                         = .CLEAR,
            store_op                        = .DONT_CARE,
            clear_value.depth_stencil.depth = 1,
        };

        rendering_info := VK.Rendering_Info.{
            render_area = {
                offset = { x = 0, y = 0 },
                extent = renderer.color_target.extent,
            },
            layer_count = 1,
            color_attachment_count = 1,
            p_color_attachments = *color_rendering_attachment_info,
            p_depth_attachment = *depth_rendering_attachment_info,
        };

        VK.cmd_bind_descriptor_sets(
            frame_resources.command_buffer,
            pipeline_bind_point = .GRAPHICS,
            renderer.common_pipeline_info.layout,
            first_set = 0,
            .[
                renderer.materials_info.texture_descriptor_info.set,
                renderer.light_info.sets[frame_resources_index],
            ],
            .[],
        );

        push_constants: Push_Constants = {
            vertex_buffer_address   = renderer.geometry_info.vertex_buffer_info.device_address,
            material_buffer_address = renderer.materials_info.material_buffer_info.device_address,
            instance_buffer_address = frame_resources.instance_buffer_info.device_address,
        };

        VK.cmd_push_constants(
            frame_resources.command_buffer,
            renderer.common_pipeline_info.layout,
            stage_flags = .VERTEX | .FRAGMENT,
            offset = 0,
            size_of(Push_Constants),
            *push_constants,
        );

        VK.cmd_bind_index_buffer(
            frame_resources.command_buffer,
            renderer.geometry_info.index_buffer_info.buffer,
            offset = 0,
            index_type = .UINT32,
        );

        VK.cmd_begin_rendering(frame_resources.command_buffer, *rendering_info);
    }

    { // Set viewport and scissor
        viewport := VK.Viewport.{
            x      = 0,
            y      = cast(float, renderer.color_target.extent.height),
            width  = cast(float, renderer.color_target.extent.width),
            height = -cast(float, renderer.color_target.extent.height),
            min_depth = 0,
            max_depth = 1,
        };
        VK.cmd_set_viewport(frame_resources.command_buffer, VK.Viewport.[viewport]);

        scissor := VK.Rect_2D.{
            offset = {
                x = 0,
                y = 0,
            },
            extent = renderer.color_target.extent,
        };
        VK.cmd_set_scissor(frame_resources.command_buffer, VK.Rect_2D.[scissor]);
    }

    VK.cmd_bind_pipeline(
        frame_resources.command_buffer,
        .GRAPHICS,
        renderer.common_pipeline_info.pipeline,
    );

    VK.cmd_draw_indexed_indirect(
        frame_resources.command_buffer,
        frame_resources.indirect_draw_buffer_info.buffer,
        offset = 0,
        draw_count = cast(u32, draw_index),
        stride = size_of(VK.Draw_Indexed_Indirect_Command),
    );

    VK.cmd_end_rendering(frame_resources.command_buffer);

    { // Color target to src, swapchain image to dst
        barriers := VK.Image_Memory_Barrier_2.[
            {
                src_stage_mask  = .COLOR_ATTACHMENT_OUTPUT,
                src_access_mask = .COLOR_ATTACHMENT_WRITE,
                dst_stage_mask  = .BLIT,
                dst_access_mask = .TRANSFER_READ,
                old_layout      = .COLOR_ATTACHMENT_OPTIMAL,
                new_layout      = .TRANSFER_SRC_OPTIMAL,
                image           = renderer.color_target.image_info.image,
                subresource_range = {
                    aspect_mask = .COLOR,
                    level_count = 1,
                    layer_count = 1,
                },
            },
            {
                src_stage_mask    = .ALL_TRANSFER,
                src_access_mask   = 0,
                dst_stage_mask    = .ALL_TRANSFER,
                dst_access_mask   = .TRANSFER_WRITE,
                old_layout        = .UNDEFINED,
                new_layout        = .TRANSFER_DST_OPTIMAL,
                image             = renderer.swapchain_info.images[swapchain_image_index],
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

        VK.cmd_pipeline_barrier_2(frame_resources.command_buffer, *dependency_info);
    }

    { // Clear for letterboxing
        clear_color: VK.Clear_Color_Value;
        clear_color._float32 = .[0, 0, 0, 1];
        VK.cmd_clear_color_image(
            frame_resources.command_buffer,
            renderer.swapchain_info.images[swapchain_image_index],
            image_layout = .TRANSFER_DST_OPTIMAL,
            *clear_color,
            .[{
                    aspect_mask = .COLOR,
                    level_count = 1,
                    layer_count = 1,
            }],
        );

        barrier := VK.Image_Memory_Barrier_2.{
            src_stage_mask    = .CLEAR,
            src_access_mask   = .TRANSFER_WRITE,
            dst_stage_mask    = .BLIT,
            dst_access_mask   = .TRANSFER_WRITE,
            old_layout        = .TRANSFER_DST_OPTIMAL,
            new_layout        = .TRANSFER_DST_OPTIMAL,
            image             = renderer.swapchain_info.images[swapchain_image_index],
            subresource_range = {
                aspect_mask = .COLOR,
                level_count = 1,
                layer_count = 1,
            },
        };
        dependency_info := VK.Dependency_Info.{
            image_memory_barrier_count = 1,
            p_image_memory_barriers    = *barrier,
        };

        VK.cmd_pipeline_barrier_2(frame_resources.command_buffer, *dependency_info);
    }

    { // Scaling and bliting
        // @Todo: make this nicer
        left_x, left_y, right_x, right_y := scale_keeping_ratio_and_get_rect(
            renderer.color_target.extent,
            renderer.swapchain_info.config.image_extent,
        );

        region := VK.Image_Blit_2.{
            src_subresource = {
                aspect_mask = .COLOR,
                layer_count = 1,
            },
            src_offsets     = .[
                .{ 0, 0, 0 },
                .{
                    cast(s32, renderer.color_target.extent.width),
                    cast(s32, renderer.color_target.extent.height),
                    1,
                },
            ],
            dst_subresource = {
                aspect_mask = .COLOR,
                layer_count = 1,
            },
            dst_offsets     = .[
                .{ left_x, left_y, 0 },
                .{ right_x, right_y, 1 },
            ],
        };

        blit_info := VK.Blit_Image_Info_2.{
            src_image        = renderer.color_target.image_info.image,
            src_image_layout = .TRANSFER_SRC_OPTIMAL,
            dst_image        = renderer.swapchain_info.images[swapchain_image_index],
            dst_image_layout = .TRANSFER_DST_OPTIMAL,
            region_count     = 1,
            p_regions        = *region,
            filter           = .LINEAR,
        };
        VK.cmd_blit_image_2(frame_resources.command_buffer, *blit_info);
    }

    { // Swapchain image to presentable
        barrier := VK.Image_Memory_Barrier_2.{
            src_stage_mask    = .BLIT,
            src_access_mask   = .TRANSFER_WRITE,
            dst_stage_mask    = .NONE,
            dst_access_mask   = 0,
            old_layout        = .TRANSFER_DST_OPTIMAL,
            new_layout        = .PRESENT_SRC_KHR,
            image             = renderer.swapchain_info.images[swapchain_image_index],
            subresource_range = {
                aspect_mask = .COLOR,
                level_count = 1,
                layer_count = 1,
            },
        };

        dependency_info := VK.Dependency_Info.{
            image_memory_barrier_count = 1,
            p_image_memory_barriers = *barrier,
        };

        VK.cmd_pipeline_barrier_2(frame_resources.command_buffer, *dependency_info);
    }

    result := VK.end_command_buffer(frame_resources.command_buffer);
    if result != .SUCCESS {
        return tprint("Failed to end command buffer: %", result);
    }

    { // Submitting
        image_acquired_wait_info := VK.Semaphore_Submit_Info.{
            semaphore  = frame_resources.image_acquired_semaphore,
            stage_mask = .ALL_TRANSFER,
        };

        semaphore_signals := VK.Semaphore_Submit_Info.[
            {
                semaphore = renderer.swapchain_info.render_complete_semaphores[swapchain_image_index],
                stage_mask = .ALL_COMMANDS,
            },
            {
                semaphore  = renderer.timeline_semaphore_info.semaphore,
                value      = signal_value,
                stage_mask = .ALL_COMMANDS,
            },
        ];

        cmd_submit_info := VK.Command_Buffer_Submit_Info.{
            command_buffer = frame_resources.command_buffer,
        };

        submit_info := VK.Submit_Info_2.{
            wait_semaphore_info_count   = 1,
            p_wait_semaphore_infos      = *image_acquired_wait_info,
            command_buffer_info_count   = 1,
            p_command_buffer_infos      = *cmd_submit_info,
            signal_semaphore_info_count = semaphore_signals.count,
            p_signal_semaphore_infos    = semaphore_signals.data,
        };

        result := VK.queue_submit_2(renderer.graphics_queue_info.queue, VK.Submit_Info_2.[submit_info], null);
        if result != .SUCCESS {
            return "Failed to submit queue";
        }
    }

    { // Present
        present_info := VK.Present_Info_Khr.{
            wait_semaphore_count = 1,
            p_wait_semaphores    = *renderer.swapchain_info.render_complete_semaphores[swapchain_image_index],
            swapchain_count      = 1,
            p_swapchains         = *renderer.swapchain_info.swapchain,
            p_image_indices      = *swapchain_image_index,
            p_results            = null,
        };

        result := VK.queue_present_khr(renderer.graphics_queue_info.queue, *present_info);
        if result == {
            case .ERROR_OUT_OF_DATE_KHR;
                renderer.swapchain_info.should_recreate = true;
                return "";
            case .SUBOPTIMAL_KHR;
                renderer.swapchain_info.should_recreate = true;
            case;
                if result != .SUCCESS {
                    return "Failed to present";
                }
        }
    }

    return "";
}

set_render_resolution :: (renderer: *Renderer, width: u32, height: u32) {
    if (
        width == renderer.color_target.extent.width
        && height == renderer.color_target.extent.height
    )
    {
        return;
    }

    renderer.color_target.should_recreate = true;
    renderer.color_target.extent = { width, height };
}

set_directional_light :: (renderer: *Renderer, light: Directional_Light) {
    renderer.light_info.directional_light = light;
}

upload_textures :: (renderer: *Renderer, textures: []Texture) -> error: string, texture_ids: [..]u32 {
    prev_count := renderer.materials_info.texture_count;

    texture_ids: [..]u32;

    if renderer.materials_info.texture_count + textures.count > MAX_TEXTURE_COUNT {
        return "Texture descriptor array is full", texture_ids;
    }

    image_descriptors: [..]VK.Descriptor_Image_Info;
    image_descriptors.allocator = temp;

    for texture: textures {
        array_add(*texture_ids, cast(u32, renderer.materials_info.texture_count));

        array_add(
            *image_descriptors,
            {
                sampler      = renderer.materials_info.samplers[texture.sampler_index],
                image_view   = renderer.materials_info.images[texture.image_index].image_view,
                image_layout = .SHADER_READ_ONLY_OPTIMAL,
            }
        );

        renderer.materials_info.texture_count += 1;
    }

    write_descriptor_set := VK.Write_Descriptor_Set.{
        dst_set           = renderer.materials_info.texture_descriptor_info.set,
        dst_binding       = 0,
        dst_array_element = cast(u32, prev_count),
        descriptor_count  = xx        image_descriptors.count,
        descriptor_type   = .COMBINED_IMAGE_SAMPLER,
        p_image_info      = image_descriptors.data,
    };

    VK.update_descriptor_sets(renderer.device, .[write_descriptor_set], .[]);

    return "", texture_ids;
}

upload_materials :: (renderer: *Renderer, materials: []Material) -> error: string, material_ids: [..]u32 {
    start := renderer.materials_info.material_count;

    material_ids: [..]u32;

    if start + materials.count > MAX_MATERIAL_COUNT {
        return "Material buffer is full", material_ids;
    }

    bytes_to_upload: []u8;
    bytes_to_upload.count = materials.count * size_of(Material);
    bytes_to_upload.data  = cast(*u8, materials.data);

    error := upload_to_buffer(
        renderer.device,
        renderer.allocator,
        renderer.transient_command_pool,
        bytes_to_upload,
        dst_offset = cast(u64, start * size_of(Material)),
        renderer.materials_info.material_buffer_info.buffer,
        renderer.graphics_queue_info.queue,
    );
    if error {
        return error, material_ids;
    }

    for material: materials {
        array_add(*material_ids, cast(u32, renderer.materials_info.material_count));
        renderer.materials_info.material_count += 1;
    }

    return "", material_ids;
}

// @Todo: batching
upload_vertices :: (renderer: *Renderer, vertices: []Vertex) -> error: string, start: u32, count: u32 {
    start := renderer.geometry_info.vertices_offset;
    count := cast(u32, vertices.count);

    if (start + count) * size_of(Vertex) > Geometry_Info.VERTEX_BUFFER_BYTE_SIZE {
        return "Vertex buffer is full", start, count;
    }

    bytes_to_upload: []u8;
    bytes_to_upload.count = vertices.count * size_of(Vertex);
    bytes_to_upload.data = cast(*u8, vertices.data);

    error := upload_to_buffer(
        renderer.device,
        renderer.allocator,
        renderer.transient_command_pool,
        bytes_to_upload,
        dst_offset = start * size_of(Vertex),
        renderer.geometry_info.vertex_buffer_info.buffer,
        renderer.graphics_queue_info.queue,
    );
    if error {
        return error, start, count;
    }

    renderer.geometry_info.vertices_offset += count;

    return "", start, count;
}

// @Todo: batching
upload_indices :: (renderer: *Renderer, indices: []u32) -> error: string, start: u32, count: u32 {
    start := renderer.geometry_info.indices_offset;
    count := cast(u32, indices.count);

    if (start + count) * size_of(u32) > Geometry_Info.INDEX_BUFFER_BYTE_SIZE {
        return "Index buffer is full", start, count;
    }

    bytes_to_upload: []u8;
    bytes_to_upload.count = indices.count * size_of(u32);
    bytes_to_upload.data = cast(*u8, indices.data);

    error := upload_to_buffer(
        renderer.device,
        renderer.allocator,
        renderer.transient_command_pool,
        bytes_to_upload,
        dst_offset = start * size_of(u32),
        renderer.geometry_info.index_buffer_info.buffer,
        renderer.graphics_queue_info.queue,
    );
    if error {
        return error, start, count;
    }

    renderer.geometry_info.indices_offset += count;

    return "", start, count;
}

// @Todo: batching
upload_texture_images :: (renderer: *Renderer, image_params_list: []Image_Params) -> error: string, image_ids: [..]u32 {
    image_ids: [..]u32;

    error, command_buffer := start_transient_command_buffer(
        renderer.device,
        renderer.transient_command_pool,
    );
    if error {
        return error, image_ids;
    }

    staging_buffers: [..]Buffer_Info;
    staging_buffers.allocator = temp;
    defer for buffer: staging_buffers {
        VMA.destroy_buffer(renderer.allocator, buffer.buffer, buffer.allocation);
    }

    for image_params: image_params_list {
        error, image, staging_buffer := create_texture_image_and_record_transition(
            renderer.device,
            renderer.allocator,
            command_buffer,
            image_params,
        );
        if error {
            return error, image_ids;
        }

        array_add(*image_ids, xx renderer.materials_info.images.count);
        array_add(*renderer.materials_info.images, image);
        array_add(*staging_buffers, staging_buffer);
    }

    error = submit_transient_command_buffer(
        renderer.device,
        renderer.transient_command_pool,
        renderer.graphics_queue_info.queue,
        command_buffer,
    );
    if error {
        return error, image_ids;
    }

    return "", image_ids;
}

// @Todo: can we batch this?
upload_sampler :: (renderer: *Renderer, params: Create_Sampler_Params) -> error: string, index: u32 {
    if renderer.materials_info.samplers.count >= MAX_SAMPLER_COUNT {
        return "Max sampler count reached", 0;
    }

    result, sampler := VK.create_sampler(renderer.device, *params);
    if result != .SUCCESS {
        return
            tprint("Failed to create sampler: %", result),
            0;
    }

    array_add(
        *renderer.materials_info.samplers,
        sampler,
    );

    return "", cast(u32, renderer.materials_info.samplers.count - 1);
}



#scope_file

VULKAN_API_VERSION :: #run VK.make_version(1, 4, 0);

DEFAULT_SURFACE_FORMAT :: VK.Surface_Format_Khr.{
    format      = .B8G8R8A8_SRGB,
    color_space = .SRGB_NONLINEAR_KHR,
};

DEFAULT_COLOR_TARGET_FORMAT :: VK.Format.R8G8B8A8_SRGB;

DEFAULT_PRESENT_MODE :: VK.Present_Mode_Khr.FIFO_KHR;

DEPTH_IMAGE_FORMAT :: VK.Format.D32_SFLOAT;

DEFAULT_TEXTURE_IMAGE_FORMAT :: VK.Format.R8G8B8A8_SRGB;

DEVICE_EXTENSIONS :: *u8.[
    VK.Extension_Names.KHR_SWAPCHAIN,
];

FRAMES_IN_FLIGHT_COUNT :: 2;

MAX_TEXTURE_COUNT        :: 256;
MAX_SAMPLER_COUNT        :: 256;
MAX_MATERIAL_COUNT       :: 256;
MAX_DRAW_COUNT           :: 4096;
MAX_INDIRECT_BUFFER_SIZE :: MAX_DRAW_COUNT * size_of(VK.Draw_Indexed_Indirect_Command);
MAX_INSTANCE_BUFFER_SIZE :: MAX_DRAW_COUNT * size_of(Instance);

#if DEBUG {
    DEBUG_INSTANCE_EXTENSIONS :: *u8.[
        VK.Extension_Names.DEBUG_UTILS,
        VK.Extension_Names.LAYER_SETTINGS,
    ];

    DEBUG_LAYERS :: *u8.[
        VK.Layer_Names.VALIDATION,
    ];

    DEBUG_UTILS_MESSENGER_CREATE_INFO := VK.Debug_Utils_Messenger_Create_Info_Ext.{
        message_severity  = .WARNING_EXT | .ERROR_EXT,
        message_type      = .GENERAL_EXT | .VALIDATION_EXT | .PERFORMANCE_EXT,
        pfn_user_callback = debug_utils_messenger_callback,
    };
}

Pipeline_Info :: struct {
    pipeline: VK.Pipeline;
    layout:   VK.Pipeline_Layout;
}

Queue_Info :: struct {
    family_index: u32;
    queue:        VK.Queue;
}

Swapchain_Info :: struct {
    swapchain:                  VK.Swapchain_Khr;
    config:                     VK.Swapchain_Create_Info_Khr;

    images:                     [..]VK.Image;
    render_complete_semaphores: [..]VK.Semaphore;

    should_recreate: bool;
}

Image_Info :: struct {
    image:      VK.Image;
    image_view: VK.Image_View;
    allocation: VMA.Allocation;
    format:     VK.Format;
}

Buffer_Info :: struct {
    buffer:          VK.Buffer;
    allocation:      VMA.Allocation;
    allocation_info: VMA.Allocation_Info;
    device_address:  VK.Device_Address;
}

Timeline_Semaphore_Info :: struct {
    semaphore:         VK.Semaphore;
    next_signal_value: u64;
}

Frame_Resources :: struct {
    command_pool:             VK.Command_Pool;
    command_buffer:           VK.Command_Buffer;
    image_acquired_semaphore: VK.Semaphore;

    indirect_draw_buffer_info: Buffer_Info;
    indirect_draw_pointer:     *VK.Draw_Indexed_Indirect_Command;

    instance_buffer_info:    Buffer_Info;
    instance_pointer: *Instance;
}

Light_Info :: struct {
    directional_light: Directional_Light;

    pool:         VK.Descriptor_Pool;
    layout:       VK.Descriptor_Set_Layout;
    sets:         [FRAMES_IN_FLIGHT_COUNT]VK.Descriptor_Set;

    buffer_infos: [FRAMES_IN_FLIGHT_COUNT]Buffer_Info;
    pointers:     [FRAMES_IN_FLIGHT_COUNT]*Directional_Light;
}

Descriptor_Info :: struct {
    pool:   VK.Descriptor_Pool;
    layout: VK.Descriptor_Set_Layout;
    set:    VK.Descriptor_Set;
}

Push_Constants :: struct @Gpu {
    vertex_buffer_address:   VK.Device_Address;
    material_buffer_address: VK.Device_Address;
    instance_buffer_address: VK.Device_Address;
}

Transforms :: struct {
    projection:      Matrix4;
    view:            Matrix4;
    view_projection: Matrix4;
}

Geometry_Info :: struct {
    index_buffer_info: Buffer_Info;
    indices_offset: u32;

    vertex_buffer_info: Buffer_Info;
    vertices_offset: u32;

    VERTEX_BUFFER_BYTE_SIZE  :: 64 * 1024 * 1024;
    INDEX_BUFFER_BYTE_SIZE   :: 32 * 1024 * 1024;
}

Materials_Info :: struct {
    samplers:             [..]VK.Sampler;
    images:               [..]Image_Info;
    material_buffer_info: Buffer_Info;
    texture_count:  u32;
    material_count: u32;
    texture_descriptor_info: Descriptor_Info;
}

create_color_target :: (
    device: VK.Device,
    allocator: VMA.Allocator,
    width: u32,
    height: u32,
) -> error: string, Color_Target {
    color_target: Color_Target;

    error:, color_target.image_info = create_image(
        device,
        allocator,
        DEFAULT_COLOR_TARGET_FORMAT,
        width,
        height,
        depth            = 1,
        tiling           = .OPTIMAL,
        usage            = .COLOR_ATTACHMENT | .TRANSFER_SRC,
        allocation_flags = .DEDICATED_MEMORY,
        aspect_mask      = .COLOR,
    );

    if error {
        return
            tprint("Failed to create color target: %", error),
            color_target;
    }

    color_target.extent = { width, height };

    return
        "",
        color_target;
}

upload_to_buffer :: (
    device:          VK.Device,
    allocator:       VMA.Allocator,
    command_pool:    VK.Command_Pool,
    bytes_to_upload: []u8,
    dst_offset:      u64,
    dst_buffer:      VK.Buffer,
    queue:           VK.Queue,
) -> error: string {
    error, staging_buffer := create_buffer(
        device,
        allocator,
        usage        = .TRANSFER_SRC,
        byte_size    = cast(u64, bytes_to_upload.count),
        memory_usage = .AUTO,
        mappable     = true,
    );
    if error {
        return error;
    }
    defer VMA.destroy_buffer(
        allocator,
        staging_buffer.buffer,
        staging_buffer.allocation,
    );

    error = map_copy_buffer_data(
        allocator,
        staging_buffer,
        buffer_offset = 0,
        bytes_to_upload.data,
        bytes_to_upload.count,
    );
    if error {
        return error;
    }

    error =, command_buffer := start_transient_command_buffer(
        device,
        command_pool,
    );
    if error {
        return error;
    }

    buffer_copy := VK.Buffer_Copy.{
        src_offset = 0,
        dst_offset = dst_offset,
        size       = cast(u64, bytes_to_upload.count),
    };

    VK.cmd_copy_buffer(
        command_buffer,
        staging_buffer.buffer,
        dst_buffer,
        .[buffer_copy],
    );

    error = submit_transient_command_buffer(
        device,
        command_pool,
        queue,
        command_buffer,
    );
    if error {
        return error;
    }

    return "";
}

create_geometry_info :: (device: VK.Device, allocator: VMA.Allocator) -> error: string, Geometry_Info {
    geometry_info: Geometry_Info;

    error:, geometry_info.index_buffer_info = create_buffer(
        device,
        allocator,
        usage = .TRANSFER_DST | .INDEX_BUFFER,
        Geometry_Info.INDEX_BUFFER_BYTE_SIZE,
        memory_usage = .AUTO,
        mappable = false,
    );
    if error {
        return
            error,
            geometry_info;
    }
    error, geometry_info.vertex_buffer_info = create_buffer(
        device,
        allocator,
        usage = .TRANSFER_DST | .SHADER_DEVICE_ADDRESS,
        Geometry_Info.VERTEX_BUFFER_BYTE_SIZE,
        memory_usage = .AUTO,
        mappable = false,
    );
    if error {
        return
            error,
            geometry_info;
    }

    return "", geometry_info;
}

create_materials_info :: (device: VK.Device, allocator: VMA.Allocator) -> error: string, Materials_Info {
    materials_info: Materials_Info;

    error:, materials_info.texture_descriptor_info = create_texture_descriptor_info(device);
    if error {
        return
            error,
            materials_info;
    }

    error, materials_info.material_buffer_info = create_buffer(
        device,
        allocator,
        usage = .TRANSFER_DST | .SHADER_DEVICE_ADDRESS,
        MAX_MATERIAL_COUNT * size_of(Material),
        memory_usage = .AUTO,
        mappable = false,
    );
    if error {
        return
            error,
            materials_info;
    }

    array_reserve(*materials_info.samplers, MAX_SAMPLER_COUNT);
    array_reserve(*materials_info.images, MAX_TEXTURE_COUNT);

    return "", materials_info;
}

destroy_materials_info :: (device: VK.Device, allocator: VMA.Allocator, materials_info: *Materials_Info) {
    for sampler: materials_info.samplers {
        VK.destroy_sampler(device, sampler);
    }
    array_free(materials_info.samplers);

    for image_info: materials_info.images {
        destroy_image(
            device,
            allocator,
            *image_info,
        );
    }
    array_free(materials_info.images);

    VMA.destroy_buffer(
        allocator,
        materials_info.material_buffer_info.buffer,
        materials_info.material_buffer_info.allocation,
    );

    destroy_descriptor_info(device, *materials_info.texture_descriptor_info);

    materials_info.* = {};
}

destroy_geometry_info :: (allocator: VMA.Allocator, geometry_info: *Geometry_Info) {
    VMA.destroy_buffer(
        allocator,
        geometry_info.index_buffer_info.buffer,
        geometry_info.index_buffer_info.allocation,
    );
    VMA.destroy_buffer(
        allocator,
        geometry_info.vertex_buffer_info.buffer,
        geometry_info.vertex_buffer_info.allocation,
    );

    geometry_info.* = {};
}

draw_node :: (
    renderer: *Renderer,
    node: Node,
    draw_index: *int,
    nodes: []Node,
    frame_resources: *Frame_Resources,
    parent_transform: Matrix4,
) {
    world_transform := parent_transform * node.local_transform;

    assert(
        draw_index.* + node.meshes.count <= MAX_DRAW_COUNT,
        "Indirect buffer size is full",
    );

    for mesh: node.meshes {
        frame_resources.indirect_draw_pointer[draw_index.*] = {
            index_count    = mesh.index_count,
            instance_count = 1,
            first_index    = mesh.index_start,
            vertex_offset  = cast(s32, mesh.vertex_start),
            first_instance = cast(u32, draw_index.*),
        };

        frame_resources.instance_pointer[draw_index.*] = {
            wvp_transform   = transpose(renderer.transforms.view_projection * world_transform),
            world_transform = transpose(world_transform),
            material_index  = mesh.material_index,
        };

        draw_index.* += 1;
    }

    for child_node_index: node.children_ids {
        child_node := nodes[child_node_index];

        draw_node(
            renderer,
            child_node,
            draw_index,
            nodes,
            frame_resources,
            world_transform,
        );
    }
}

create_fallbacks :: (renderer: *Renderer) -> error: string {
    image_id: u32;
    {
        white: u32 = 0xFFFFFFFF;
        bytes: [..]u8;
        bytes.allocator = temp;
        array_resize(*bytes, 4);
        bytes.data = cast(*u8, *white);

        white_pixel_image_params := Image_Params.{
            width         = 1,
            height        = 1,
            bytes         = bytes,
        };

        error, image_ids := upload_texture_images(
            renderer,
            .[white_pixel_image_params],,
            temp
        );
        if error {
            return error;
        }
        if image_ids.count != 1 || image_ids[0] != 0 {
            return "The ids of the fallback texture image should be the very first and the very only";
        }

        image_id = image_ids[0];
    }

    sampler_index: u32;
    {
        error:, sampler_index = upload_sampler(
            renderer,
            {
                mag_filter     = .NEAREST,
                min_filter     = .NEAREST,
                address_mode_u = .REPEAT,
                address_mode_v = .REPEAT,
                address_mode_w = .REPEAT,
                compare_enable = VK.FALSE,
            },
        );
        if error {
            return error;
        }
        if sampler_index != 0 {
            return tprint("Fallback sampler index must have been 0, but it's %", sampler_index);
        }
    }

    texture_index: u32;
    {
        error, texture_indices := upload_textures(
            renderer,
            .[{
                image_index = image_id,
                sampler_index = sampler_index,
            }],,
            temp
        );
        if error {
            return error;
        }
        if texture_indices.count != 1 || texture_indices[0] != 0 {
            return "Fallback texture should be the very first and very only";
        }
        texture_index = texture_indices[0];
    }

    error, material_ids := upload_materials(
        renderer,
        .[{
            base_color_texture_index = texture_index,
        }],,
        temp
    );
    if error {
        return error;
    }
    if material_ids.count != 1 || material_ids[0] != 0 {
        return "Fallback material should be the very first and very only";
    }

    return "";
}

submit_transient_command_buffer :: (
    device:         VK.Device,
    command_pool:   VK.Command_Pool,
    queue:          VK.Queue,
    command_buffer: VK.Command_Buffer,
) -> error: string {
    result := VK.end_command_buffer(command_buffer);
    if result != .SUCCESS {
        return tprint("Failed to end transient command buffer: %", result);
    }

    submit_info := VK.Submit_Info.{
        command_buffer_count = 1,
        p_command_buffers    = *command_buffer,
    };

    result = VK.queue_submit(queue, .[submit_info], null);
    if result != .SUCCESS {
        return tprint("Failed to submit transient command buffer: %", result);
    }

    result = VK.queue_wait_idle(queue);
    if result != .SUCCESS {
        return tprint("Failed to wait for transient command buffer submission: %", result);
    }

    VK.free_command_buffers(device, command_pool, .[command_buffer]);

    return "";
}

// Creates the image and records the transition commands, but does not submit!
create_texture_image_and_record_transition :: (
    device:         VK.Device,
    allocator:      VMA.Allocator,
    command_buffer: VK.Command_Buffer,
    image_params:   Image_Params,
) -> error: string, Image_Info, staging_buffer: Buffer_Info {
    error, image_info := create_image(
        device,
        allocator,
        DEFAULT_TEXTURE_IMAGE_FORMAT,
        image_params.width,
        image_params.height,
        depth            = 1,
        tiling           = .OPTIMAL,
        usage            = .TRANSFER_DST | .SAMPLED,
        allocation_flags = 0,
        aspect_mask      = .COLOR,
    );
    if error {
        return
            error,
            image_info,
            .{};
    }

    { // Transfer to TRANSFER_DST_OPTIMAL
        transfer_barrier := VK.Image_Memory_Barrier_2.{
            src_stage_mask  = .NONE,
            src_access_mask = .NONE,
            dst_stage_mask  = .COPY,
            dst_access_mask = .TRANSFER_WRITE,
            old_layout      = .UNDEFINED,
            new_layout      = .TRANSFER_DST_OPTIMAL,
            image           = image_info.image,
            subresource_range = {
                aspect_mask = .COLOR,
                level_count = 1,
                layer_count = 1,
            },
        };

        transfer_dependency_info := VK.Dependency_Info.{
            image_memory_barrier_count = 1,
            p_image_memory_barriers    = *transfer_barrier,
        };

        VK.cmd_pipeline_barrier_2(command_buffer, *transfer_dependency_info);
    }

    error =, staging_buffer_info := create_buffer(
        device,
        allocator,
        usage = .TRANSFER_SRC,
        cast(u64, image_params.bytes.count),
        memory_usage = .AUTO_PREFER_HOST,
        mappable = true,
    );
    if error {
        return
            error,
            image_info,
            staging_buffer_info;
    }

    { // Copy image into buffer
        error := map_copy_buffer_data(
            allocator,
            staging_buffer_info,
            buffer_offset = 0,
            image_params.bytes.data,
            image_params.bytes.count,
        );
        if error {
            return
                error,
                image_info,
                staging_buffer_info;
        }

        buffer_image_copy := VK.Buffer_Image_Copy.{
            image_subresource = {
                aspect_mask      = .COLOR,
                layer_count      = 1,
            },
            image_extent = {
                width  = image_params.width,
                height = image_params.height,
                depth  = 1,
            },
        };

        VK.cmd_copy_buffer_to_image(
            command_buffer,
            staging_buffer_info.buffer,
            image_info.image,
            dst_image_layout = .TRANSFER_DST_OPTIMAL,
            region_count = 1,
            *buffer_image_copy,
        );
    }

    { // Transition into layout suitable for sampling
        shader_read_barrier := VK.Image_Memory_Barrier_2.{
            src_stage_mask  = .COPY,
            src_access_mask = .TRANSFER_WRITE,
            dst_stage_mask  = .FRAGMENT_SHADER,
            dst_access_mask = .SHADER_READ,
            old_layout      = .TRANSFER_DST_OPTIMAL,
            new_layout      = .SHADER_READ_ONLY_OPTIMAL,
            image           = image_info.image,
            subresource_range = {
                aspect_mask      = .COLOR,
                level_count      = 1,
                layer_count      = 1,
            },
        };

        shader_read_dependency_info := VK.Dependency_Info.{
            image_memory_barrier_count = 1,
            p_image_memory_barriers    = *shader_read_barrier,
        };

        VK.cmd_pipeline_barrier_2(
            command_buffer,
            *shader_read_dependency_info,
        );
    }

    return
        "",
        image_info,
        staging_buffer_info;
}

map_copy_buffer_data :: (
    allocator:     VMA.Allocator,
    buffer:        Buffer_Info,
    buffer_offset: u64,
    data:          *void,
    byte_size:     int,
) -> error: string {
    result, buffer_pointer := VMA.map_memory(allocator, buffer.allocation);
    if result != .SUCCESS {
        return tprint("Failed to map memory");
    }

    memcpy(buffer_pointer + buffer_offset, data, byte_size);

    VMA.unmap_memory(allocator, buffer.allocation);

    result = VMA.flush_allocation(
        allocator,
        buffer.allocation,
        buffer_offset,
        cast(u64, byte_size),
    );
    if result != .SUCCESS {
        return tprint("Failed to flush allocation: %", result);
    }

    return "";
}

create_buffer :: (
    device:       VK.Device,
    allocator:    VMA.Allocator,
    usage:        VK.Buffer_Usage_Flags,
    byte_size:    u64,
    memory_usage: VMA.Memory_Usage,
    mappable:     bool,
) -> error: string, Buffer_Info {
    buffer: Buffer_Info;

    buffer_create_info := VK.Buffer_Create_Info.{
        size         = byte_size,
        usage        = usage,
        sharing_mode = .EXCLUSIVE,
    };

    allocation_create_info := VMA.Allocation_Create_Info.{
        flags = ifx mappable then VMA.Allocation_Create_Flags.HOST_ACCESS_SEQUENTIAL_WRITE else 0,
        usage = memory_usage,
    };

    result:, buffer.buffer, buffer.allocation, buffer.allocation_info = VMA.create_buffer(
        allocator,
        *buffer_create_info,
        *allocation_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create buffer: %", result),
            buffer;
    }

    if (usage & .SHADER_DEVICE_ADDRESS) {
        vertex_buffer_device_address_info := VK.Buffer_Device_Address_Info.{
            buffer = buffer.buffer,
        };

        buffer.device_address = VK.get_buffer_device_address(device, *vertex_buffer_device_address_info);
    }

    return "", buffer;
}

create_common_pipeline :: (
    device:                   VK.Device,
    get_compiled_shader:      Get_Compiled_Shader,
    color_attachment_formats: []VK.Format,
    depth_attachment_format:  VK.Format,
    descriptor_set_layouts:   []VK.Descriptor_Set_Layout,
) -> error: string, Pipeline_Info {
    pipeline_info: Pipeline_Info;

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
                tprint("Failed to create layout for common pipeline: %", result),
                pipeline_info;
        }
    }

    error, vertex_shader := create_shader_module(device, "common.vertex.spv", get_compiled_shader);
    if error {
        return
            error,
            pipeline_info;
    }
    defer VK.destroy_shader_module(device, vertex_shader);

    error =, fragment_shader := create_shader_module(device, "common.fragment.spv", get_compiled_shader);
    if error {
        return
            error,
            pipeline_info;
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
        topology = .TRIANGLE_LIST,
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
        cull_mode    = .BACK,
        front_face   = .COUNTER_CLOCKWISE,
        line_width   = 1,
    };

    multisample_state_create_info := VK.Pipeline_Multisample_State_Create_Info.{
        rasterization_samples = ._1,
    };

    color_blend_attachment_states := VK.Pipeline_Color_Blend_Attachment_State.[
        {
            blend_enable = VK.FALSE,
            color_write_mask = .R | .G | .B | .A,
        },
    ];

    color_blend_state_create_info := VK.Pipeline_Color_Blend_State_Create_Info.{
        attachment_count = color_blend_attachment_states.count,
        p_attachments    = color_blend_attachment_states.data,
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
        color_attachment_count     = cast(u32, color_attachment_formats.count),
        p_color_attachment_formats = color_attachment_formats.data,
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
        layout                 = pipeline_info.layout,
        render_pass            = null,
    };

    result:, pipeline_info.pipeline = VK.create_graphics_pipeline(
        device,
        null,
        *pipeline_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create common pipeline: %", result),
            pipeline_info;
    }

    return "", pipeline_info;
}

destroy_pipeline :: (device: VK.Device, pipeline_info: *Pipeline_Info) {
    VK.destroy_pipeline(device, pipeline_info.pipeline);
    VK.destroy_pipeline_layout(device, pipeline_info.layout);

    pipeline_info.* = {};
}

destroy_light_info :: (
    device: VK.Device,
    allocator: VMA.Allocator,
    light_info: Light_Info,
) {
    for buffer_info: light_info.buffer_infos {
        VMA.unmap_memory(allocator, buffer_info.allocation);
        VMA.destroy_buffer(
            allocator,
            buffer_info.buffer,
            buffer_info.allocation,
        );
    }
    VK.destroy_descriptor_set_layout(device, light_info.layout);
    VK.destroy_descriptor_pool(device, light_info.pool);
}

create_light_info :: (device: VK.Device, allocator: VMA.Allocator) -> error: string, Light_Info {
    light_info: Light_Info;

    { // Pool
        descriptor_pool_sizes := VK.Descriptor_Pool_Size.[
            {
                type             = .UNIFORM_BUFFER,
                descriptor_count = FRAMES_IN_FLIGHT_COUNT,
            },
        ];

        descriptor_pool_create_info := VK.Descriptor_Pool_Create_Info.{
            max_sets        = FRAMES_IN_FLIGHT_COUNT,
            pool_size_count = descriptor_pool_sizes.count,
            p_pool_sizes    = descriptor_pool_sizes.data,
        };
        result:, light_info.pool = VK.create_descriptor_pool(device, *descriptor_pool_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create descriptor pool for light: %", result),
                light_info;
        }
    }

    { // Layout
        bindings := VK.Descriptor_Set_Layout_Binding.[
            {
                binding          = 0,
                descriptor_type  = .UNIFORM_BUFFER,
                descriptor_count = 1,
                stage_flags      = .FRAGMENT,
            },
        ];

        descriptor_set_layout_create_info := VK.Descriptor_Set_Layout_Create_Info.{
            binding_count = bindings.count,
            p_bindings    = bindings.data,
        };

        result:, light_info.layout = VK.create_descriptor_set_layout(
            device,
            *descriptor_set_layout_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create descriptor set layout for light: %", result),
                light_info;
        }
    }

    { // Set
        layouts: [FRAMES_IN_FLIGHT_COUNT]VK.Descriptor_Set_Layout;
        for *layout: layouts {
            layout.* = light_info.layout;
        }
        descriptor_set_allocate_info := VK.Descriptor_Set_Allocate_Info.{
            descriptor_pool      = light_info.pool,
            descriptor_set_count = layouts.count,
            p_set_layouts        = layouts.data,
        };

        result, descriptor_sets := VK.allocate_descriptor_sets(device, *descriptor_set_allocate_info,, temp);
        if result != .SUCCESS {
            return
                tprint("Failed to allocate descriptor set for light: %", result),
                light_info;
        }

        for *set: light_info.sets {
            set.* = descriptor_sets[it_index];
        }
    }

    // Buffers
    for *buffer_info: light_info.buffer_infos {
        error, new_buffer_info := create_buffer(
            device,
            allocator,
            usage = .UNIFORM_BUFFER,
            size_of(Directional_Light),
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create light uniform buffer: %", error),
                light_info;
        }

        buffer_info.* = new_buffer_info;


        result:, light_info.pointers[it_index] = VMA.map_memory(
            allocator,
            buffer_info.allocation,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to map light uniform buffer memory: %", result),
                light_info;
        }

        descriptor_buffer_info := VK.Descriptor_Buffer_Info.{
            buffer = buffer_info.buffer,
            offset = 0,
            range = size_of(Directional_Light),
        };

        write_descriptor_set := VK.Write_Descriptor_Set.{
            dst_set          = light_info.sets[it_index],
            dst_binding      = 0,
            descriptor_count = 1,
            descriptor_type  = .UNIFORM_BUFFER,
            p_buffer_info    = *descriptor_buffer_info,
        };

        VK.update_descriptor_sets(
            device,
            .[write_descriptor_set],
            .[],
        );
    }

    return "", light_info;
}

create_texture_descriptor_info :: (device: VK.Device) -> error: string, Descriptor_Info {
    descriptor_info: Descriptor_Info;

    { // Pool
        descriptor_pool_sizes := VK.Descriptor_Pool_Size.[
            {
                type             = .COMBINED_IMAGE_SAMPLER,
                descriptor_count = MAX_TEXTURE_COUNT,
            },
        ];

        descriptor_pool_create_info := VK.Descriptor_Pool_Create_Info.{
            flags           = .UPDATE_AFTER_BIND,
            max_sets        = 1, // Only one, set = 0
            pool_size_count = descriptor_pool_sizes.count,
            p_pool_sizes    = descriptor_pool_sizes.data,
        };
        result:, descriptor_info.pool = VK.create_descriptor_pool(device, *descriptor_pool_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create descriptor pool for textures: %", result),
                descriptor_info;
        }
    }

    { // Layout
        bindings := VK.Descriptor_Set_Layout_Binding.[
            {
                binding          = 0,
                descriptor_type  = .COMBINED_IMAGE_SAMPLER,
                descriptor_count = MAX_TEXTURE_COUNT,
                stage_flags      = .FRAGMENT,
            },
        ];

        flags_per_binding := VK.Descriptor_Binding_Flags.[
            .PARTIALLY_BOUND | .UPDATE_AFTER_BIND,
        ];

        flags_create_info := VK.Descriptor_Set_Layout_Binding_Flags_Create_Info.{
            binding_count   = flags_per_binding.count,
            p_binding_flags = flags_per_binding.data,
        };

        descriptor_set_layout_create_info := VK.Descriptor_Set_Layout_Create_Info.{
            p_next        = *flags_create_info,
            flags         = .UPDATE_AFTER_BIND_POOL,
            binding_count = bindings.count,
            p_bindings    = bindings.data,
        };

        result:, descriptor_info.layout = VK.create_descriptor_set_layout(
            device,
            *descriptor_set_layout_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create descriptor set layout for textures: %", result),
                descriptor_info;
        }
    }

    { // Set
        descriptor_set_allocate_info := VK.Descriptor_Set_Allocate_Info.{
            descriptor_pool      = descriptor_info.pool,
            descriptor_set_count = 1,
            p_set_layouts        = *descriptor_info.layout,
        };

        result, descriptor_sets := VK.allocate_descriptor_sets(device, *descriptor_set_allocate_info,, temp);
        if result != .SUCCESS {
            return
                tprint("Failed to allocate descriptor set for textures: %", result),
                descriptor_info;
        }

        descriptor_info.set = descriptor_sets[0];
    }

    return "", descriptor_info;
}

destroy_descriptor_info :: (device: VK.Device, descriptor_set_info: *Descriptor_Info) {
    VK.destroy_descriptor_set_layout(device, descriptor_set_info.layout);
    VK.destroy_descriptor_pool(device, descriptor_set_info.pool);

    descriptor_set_info.* = {};
}

destroy_frame_resources :: (
    device:          VK.Device,
    allocator:       VMA.Allocator,
    frame_resources: *Frame_Resources,
) {
    VMA.unmap_memory(
        allocator,
        frame_resources.instance_buffer_info.allocation,
    );
    VMA.destroy_buffer(
        allocator,
        frame_resources.instance_buffer_info.buffer,
        frame_resources.instance_buffer_info.allocation,
    );

    VMA.unmap_memory(
        allocator,
        frame_resources.indirect_draw_buffer_info.allocation,
    );
    VMA.destroy_buffer(
        allocator,
        frame_resources.indirect_draw_buffer_info.buffer,
        frame_resources.indirect_draw_buffer_info.allocation,
    );

    VK.destroy_semaphore(
        device,
        frame_resources.image_acquired_semaphore,
    );

    VK.destroy_command_pool(
        device,
        frame_resources.command_pool,
    );

    frame_resources.* = {};
}

create_frame_resources :: (
    device:             VK.Device,
    allocator:          VMA.Allocator,
    queue_family_index: u32,
) -> error: string, Frame_Resources {
    frame_resources: Frame_Resources;

    { // Image acquired semaphore
        semaphore_create_info: VK.Semaphore_Create_Info;
        result:, frame_resources.image_acquired_semaphore = VK.create_semaphore(
            device,
            *semaphore_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create image acquired semaphore: %", result),
                frame_resources;
        }
    }

    { // Command pool
        command_pool_create_info := VK.Command_Pool_Create_Info.{
            queue_family_index = queue_family_index,
        };
        result:, frame_resources.command_pool = VK.create_command_pool(
            device,
            *command_pool_create_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to create a command pool for a frame resources: %", result),
                frame_resources;
        }
    }

    { // Command buffer
        command_buffer_allocate_info := VK.Command_Buffer_Allocate_Info.{
            command_pool         = frame_resources.command_pool,
            level                = .PRIMARY,
            command_buffer_count = 1,
        };
        result:, frame_resources.command_buffer = VK.allocate_command_buffer(
            device,
            *command_buffer_allocate_info,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to allocate a command buffer for a frame resources: %", result),
                frame_resources;
        }
    }

    { // Indirect draw buffer
        error:, frame_resources.indirect_draw_buffer_info = create_buffer(
            device,
            allocator,
            usage = .INDIRECT_BUFFER,
            MAX_INDIRECT_BUFFER_SIZE,
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create indirect draw buffer for frame resources: %", error),
                frame_resources;
        }
        result:, frame_resources.indirect_draw_pointer = VMA.map_memory(
            allocator,
            frame_resources.indirect_draw_buffer_info.allocation,
        );
        if result != .SUCCESS {
            return
                tprint("Failed to map indirect draw buffer memory: %", result),
                frame_resources;
        }
    }

    { // Instance buffer
        error:, frame_resources.instance_buffer_info = create_buffer(
            device,
            allocator,
            usage = .STORAGE_BUFFER | .SHADER_DEVICE_ADDRESS,
            MAX_INSTANCE_BUFFER_SIZE,
            memory_usage = .AUTO,
            mappable = true,
        );
        if error {
            return
                tprint("Failed to create instance buffer for frame resources: %", error),
                frame_resources;
        }

        result:, frame_resources.instance_pointer = VMA.map_memory(
            allocator,
            frame_resources.instance_buffer_info.allocation,
        );
        if result != .SUCCESS {
            return
                tprint("Fialed to map instance buffer memory: %", result),
                frame_resources;
        }
    }

    return "", frame_resources;
}

start_transient_command_buffer :: (device: VK.Device, command_pool: VK.Command_Pool) -> error: string, VK.Command_Buffer {
    command_buffer_allocate_info := VK.Command_Buffer_Allocate_Info.{
        command_pool         = command_pool,
        level                = .PRIMARY,
        command_buffer_count = 1,
    };

    result, command_buffer := VK.allocate_command_buffer(device, *command_buffer_allocate_info);
    if result != .SUCCESS {
        return
            tprint("Failed to allocate transient command buffer: %", result),
            command_buffer;
    }

    command_buffer_begin_info := VK.Command_Buffer_Begin_Info.{
        flags = .ONE_TIME_SUBMIT,
    };
    result = VK.begin_command_buffer(command_buffer, *command_buffer_begin_info);
    if result != .SUCCESS {
        return
            tprint("Failed to begin transient command buffer: %", result),
            command_buffer;
    }

    return "", command_buffer;
}

create_transient_command_pool :: (device: VK.Device, queue_family_index: u32) -> error: string, VK.Command_Pool {
    command_pool_create_info := VK.Command_Pool_Create_Info.{
        flags              = .TRANSIENT,
        queue_family_index = queue_family_index,
    };

    result, command_pool := VK.create_command_pool(device, *command_pool_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create transient command pool: %", result),
            command_pool;
    }

    return "", command_pool;
}

create_timeline_semaphore :: (device: VK.Device) -> error: string, Timeline_Semaphore_Info {
    timeline_semaphore_info: Timeline_Semaphore_Info;

    semaphore_type_create_info :=  VK.Semaphore_Type_Create_Info.{
        semaphore_type = .TIMELINE,
        initial_value  = FRAMES_IN_FLIGHT_COUNT,
    };
    semaphore_create_info := VK.Semaphore_Create_Info.{
        p_next = *semaphore_type_create_info,
    };

    result:, timeline_semaphore_info.semaphore = VK.create_semaphore(
        device,
        *semaphore_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create timeline semaphore: %", result),
            timeline_semaphore_info;
    }

    timeline_semaphore_info.next_signal_value = semaphore_type_create_info.initial_value + 1;

    return "", timeline_semaphore_info;
}

create_depth_image :: (
    device:    VK.Device,
    allocator: VMA.Allocator,
    width:     u32,
    height:    u32,
) -> error: string, Image_Info {
    error, depth_image_info := create_image(
            device,
            allocator,
            format           = DEPTH_IMAGE_FORMAT,
            width            = width,
            height           = height,
            depth            = 1,
            tiling           = .OPTIMAL,
            usage            = .DEPTH_STENCIL_ATTACHMENT,
            allocation_flags = .DEDICATED_MEMORY,
            aspect_mask      = .DEPTH,
    );

    if error {
        return
            tprint("Failed to create depth image: %", error),
            depth_image_info;
    }

    return
        "",
        depth_image_info;
}

create_swapchain :: (
    physical_device:        VK.Physical_Device,
    surface:                VK.Surface_Khr,
    device:                 VK.Device,
    window:                 Window_Type,
    get_window_render_size: Get_Window_Render_Size,
) -> error: string, Swapchain_Info {
    swapchain_info: Swapchain_Info;

    { // The swapchain
        result, surface_capabilities := VK.get_physical_device_surface_capabilities_khr(physical_device, surface);
        if result != .SUCCESS {
            return
                tprint("Failed to get surface capabilities: %", result),
                swapchain_info;
        }

        desired_image_count := ifx surface_capabilities.max_image_count > 0
            then clamp(3, surface_capabilities.min_image_count, surface_capabilities.max_image_count)
            else max(3, surface_capabilities.min_image_count);

         // If false, some of our frame resources will have to wait for a free swapchain image
        if desired_image_count < FRAMES_IN_FLIGHT_COUNT {
            return
                tprint(
                    "The number of swapchain images is less than the number of frames in flight (% vs %)",
                    desired_image_count,
                    FRAMES_IN_FLIGHT_COUNT,
                ),
                swapchain_info;
        }

        image_extent := ifx surface_capabilities.current_extent.width != U32_MAX {
            surface_capabilities.current_extent;
        } else {
            width, height := get_window_render_size(window);

            extent: VK.Extent_2D;
            extent.width = clamp(
                width,
                surface_capabilities.min_image_extent.width,
                surface_capabilities.max_image_extent.width,
            );
            extent.height = clamp(
                height,
                surface_capabilities.min_image_extent.height,
                surface_capabilities.max_image_extent.height,
            );

            extent;
        }

        swapchain_info.config = {
            surface            = surface,
            min_image_count    = cast(u32, desired_image_count),
            image_format       = DEFAULT_SURFACE_FORMAT.format,
            image_color_space  = DEFAULT_SURFACE_FORMAT.color_space,
            image_extent       = image_extent,
            image_array_layers = 1,
            image_usage        = .TRANSFER_DST,
            image_sharing_mode = .EXCLUSIVE,
            pre_transform      = surface_capabilities.current_transform,
            composite_alpha    = .OPAQUE_KHR,
            present_mode       = DEFAULT_PRESENT_MODE,
            clipped            = VK.TRUE,
        };

        result, swapchain_info.swapchain = VK.create_swapchain_khr(device, *swapchain_info.config);
        if result != .SUCCESS {
            return
                tprint("Failed to create swapchain: %", result),
                swapchain_info;
        }
    }

    { // Images
        result:, swapchain_info.images = VK.get_swapchain_images_khr(device, swapchain_info.swapchain);
        if result != .SUCCESS {
            return
                tprint("Failed to get swapchain images: %", result),
                swapchain_info;
        }
    }

    // Render complete semaphores
    for swapchain_info.images {
        semaphore_create_info: VK.Semaphore_Create_Info;

        result, semaphore := VK.create_semaphore(device, *semaphore_create_info);
        if result != .SUCCESS {
            return
                tprint("Failed to create semaphore for swapchain: %", result),
                swapchain_info;
        }

        array_add(
            *swapchain_info.render_complete_semaphores,
            semaphore,
        );
    }

    return "", swapchain_info;
}

destroy_swapchain :: (device: VK.Device, swapchain_info: *Swapchain_Info) {
    for semaphore: swapchain_info.render_complete_semaphores {
        VK.destroy_semaphore(device, semaphore);
    }
    array_free(swapchain_info.render_complete_semaphores);

    array_free(swapchain_info.images);

    VK.destroy_swapchain_khr(device, swapchain_info.swapchain);

    swapchain_info.* = {};
}

create_allocator :: (
    instance: VK.Instance,
    physical_device: VK.Physical_Device,
    device: VK.Device,
) -> error: string, VMA.Allocator {
    allocator_create_info := VMA.Allocator_Create_Info.{
        flags              = .BUFFER_DEVICE_ADDRESS,
        physical_device    = physical_device,
        device             = device,
        instance           = instance,
        vulkan_api_version = VULKAN_API_VERSION,
    };

    result, allocator := VMA.create_allocator(*allocator_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create VMA allocator: %", result),
            allocator;
    }

    return "", allocator;
}

create_device :: (physical_device: VK.Physical_Device, queues_to_create: []Queue_Info) -> error: string, VK.Device {
    { // Check for features support
        features_14: VK.Physical_Device_Vulkan_1_4_Features;
        features_13  := VK.Physical_Device_Vulkan_1_3_Features.{ p_next = *features_14 };
        features_12  := VK.Physical_Device_Vulkan_1_2_Features.{ p_next = *features_13 };
        features     := VK.Physical_Device_Features_2.{ p_next = *features_12 };
        VK.get_physical_device_features_2(physical_device, *features);

        if (
            !features_13.dynamic_rendering
            || !features_13.synchronization_2
            || !features_12.timeline_semaphore
            || !features_12.buffer_device_address
            || !features_12.descriptor_binding_sampled_image_update_after_bind
            || !features_12.descriptor_binding_partially_bound
            || !features_12.scalar_block_layout
            || !features_12.runtime_descriptor_array
            || !features.features.multi_draw_indirect
            || !features.features.draw_indirect_first_instance
            || !features.features.shader_int64
        ) {
            return
                "Some of the required device features are not supported",
                null;
        };
    }

    required_features_14: VK.Physical_Device_Vulkan_1_4_Features;
    required_features_13 := VK.Physical_Device_Vulkan_1_3_Features.{
        p_next            = *required_features_14,
        synchronization_2 = VK.TRUE,
        dynamic_rendering = VK.TRUE,
    };
    required_features_12 := VK.Physical_Device_Vulkan_1_2_Features.{
        p_next                                             = *required_features_13,
        timeline_semaphore                                 = VK.TRUE,
        buffer_device_address                              = VK.TRUE,
        descriptor_binding_sampled_image_update_after_bind = VK.TRUE,
        descriptor_binding_partially_bound                 = VK.TRUE,
        scalar_block_layout                                = VK.TRUE,
        runtime_descriptor_array                           = VK.TRUE,
    };
    required_features := VK.Physical_Device_Features_2.{
        p_next = *required_features_12,
        features = {
            multi_draw_indirect          = VK.TRUE,
            shader_int64                 = VK.TRUE,
            draw_indirect_first_instance = VK.TRUE,
        }
    };

    device_queue_create_infos: [..]VK.Device_Queue_Create_Info;
    device_queue_create_infos.allocator = temp;
    queue_priorities := float.[1];
    for queue_info: queues_to_create {
        array_add(
            *device_queue_create_infos,
            {
                queue_family_index = queue_info.family_index,
                queue_count        = 1,
                p_queue_priorities = queue_priorities.data,
            },
        );
    }

    extensions: [..]*u8;
    extensions.allocator = temp;
    for extension: DEVICE_EXTENSIONS {
        array_add(*extensions, extension);
    }

    device_create_info := VK.Device_Create_Info.{
        p_next                     = *required_features,
        queue_create_info_count    = cast(u32, device_queue_create_infos.count),
        p_queue_create_infos       = device_queue_create_infos.data,
        enabled_extension_count    = cast(u32, extensions.count),
        pp_enabled_extension_names = extensions.data,
    };

    result, device := VK.create_device(physical_device, *device_create_info);
    if result != .SUCCESS {
        return
            "Failed to create device",
            device;
    }

    return
        "",
        device;
}

find_graphics_queue_family_index :: (physical_device: VK.Physical_Device, surface: VK.Surface_Khr) -> error: string, u32 {
    found: bool;
    graphics_queue_family_index: u32;

    queue_family_properties_list := VK.get_physical_device_queue_family_properties_2(physical_device,, temp);

    for queue_family_properties: queue_family_properties_list {
        result, has_present_support := VK.get_physical_device_surface_support_khr(
            physical_device,
            cast(u32, it_index),
            surface,
        );
        if result != .SUCCESS {
            continue;
        }

        if (
            has_present_support
            && queue_family_properties.queue_family_properties.queue_flags & .GRAPHICS
        ) {
            found = true;
            graphics_queue_family_index = cast(u32, it_index);
            break;
        }
    }

    if !found {
        return
            "No suitable queue family",
            graphics_queue_family_index;
    }

    return
        "",
        graphics_queue_family_index;
}

find_physical_device :: (instance: VK.Instance, surface: VK.Surface_Khr) -> error: string, VK.Physical_Device {
    the_suitable_device: VK.Physical_Device;

    result, physical_devices := VK.enumerate_physical_devices(instance,, temp);
    if result != .SUCCESS {
        return
            tprint("Failed to enumerate physical devices: %", result),
            the_suitable_device;
    }

    for candidate: physical_devices {
        candidate_props := VK.get_physical_device_properties(candidate);

        supports_needed_surface_format: bool;
        {
            result, supported_formats := VK.get_physical_device_surface_formats_khr(candidate, surface,, temp);
            if result != .SUCCESS {
                continue;
            }

            for format: supported_formats {
                if (
                    format.format == DEFAULT_SURFACE_FORMAT.format
                    && format.color_space == DEFAULT_SURFACE_FORMAT.color_space
                ) {
                    supports_needed_surface_format = true;
                    break;
                }
            }
        }

        supports_default_present_mode: bool;
        {
            result, supported_present_modes := VK.get_physical_device_surface_present_modes_khr(candidate, surface,, temp);
            if result != .SUCCESS {
                continue;
            }

            for supported_present_mode: supported_present_modes {
                if supported_present_mode == DEFAULT_PRESENT_MODE {
                    supports_default_present_mode = true;
                    break;
                }
            }
        }

        if (
            (candidate_props.device_type == .DISCRETE_GPU || candidate_props.device_type == .INTEGRATED_GPU)
            && candidate_props.api_version >= VULKAN_API_VERSION
            && supports_needed_surface_format
            && supports_default_present_mode
        ) {
            the_suitable_device = candidate;

            // If we got an integrated gpu, try more
            if candidate_props.device_type == .DISCRETE_GPU {
                break;
            }
        }
    }
    if !the_suitable_device {
        return
            tprint("No suitable GPUs"),
            the_suitable_device;
    }

    return
        "",
        the_suitable_device;
}

create_surface :: (
    instance: VK.Instance,
    window:   Window_Type,
    create_window_surface: Create_Window_Surface,
) -> error: string, VK.Surface_Khr {
    surface := create_window_surface(window, instance);
    if !surface {
        return
            "Failed to create surface",
            surface;
    }

    return
        "",
        surface;
}

create_instance :: (get_additional_extensions: Get_Additional_Instance_Extensions) -> error: string, VK.Instance {
    application_info := VK.Application_Info.{
        p_application_name = APPLICATION_NAME,
        api_version        = VULKAN_API_VERSION,
    };

    extensions: [..]*u8;
    extensions.allocator = temp;
    {
        #if DEBUG {
            for extension: DEBUG_INSTANCE_EXTENSIONS {
                array_add(*extensions, extension);
            }
        }

        additional_extensions := get_additional_extensions(,, temp);
        for extension: additional_extensions {
            array_add(*extensions, extension);
        };
    }

    layers: [..]*u8;
    layers.allocator = temp;
    {
        #if DEBUG {
            for layer: DEBUG_LAYERS {
                array_add(*layers, layer);
            }
        }
    }

    instance_create_info := VK.Instance_Create_Info.{
        p_application_info         = *application_info,
        enabled_layer_count        = cast(u32, layers.count),
        pp_enabled_layer_names     = layers.data,
        enabled_extension_count    = cast(u32, extensions.count),
        pp_enabled_extension_names = extensions.data,
    };
    #if DEBUG {
        debug_utils_messenger_create_info := DEBUG_UTILS_MESSENGER_CREATE_INFO;
        enable := VK.TRUE;
        settings := VK.Layer_Setting_EXT.[
            {
                p_layer_name   = VK.Layer_Names.VALIDATION,
                p_setting_name = VK.Layer_Setting_Names.VALIDATE_SYNC,
                type           = .BOOL32_EXT,
                value_count    = 1,
                p_values       = *enable,
            },
            {
                p_layer_name   = VK.Layer_Names.VALIDATION,
                p_setting_name = VK.Layer_Setting_Names.GPUAV,
                type           = .BOOL32_EXT,
                value_count    = 1,
                p_values       = *enable,
            },
            {
                p_layer_name   = VK.Layer_Names.VALIDATION,
                p_setting_name = VK.Layer_Setting_Names.VALIDATE_BEST_PRACTICES,
                type           = .BOOL32_EXT,
                value_count    = 1,
                p_values       = *enable,
            },
            {
                p_layer_name   = VK.Layer_Names.VALIDATION,
                p_setting_name = VK.Layer_Setting_Names.PRINTF_ENABLE,
                type           = .BOOL32_EXT,
                value_count    = 1,
                p_values       = *enable,
            },
            {
                p_layer_name   = VK.Layer_Names.VALIDATION,
                p_setting_name = VK.Layer_Setting_Names.PRINTF_TO_STDOUT,
                type           = .BOOL32_EXT,
                value_count    = 1,
                p_values       = *enable,
            },
        ];
        settings_create_info := VK.Layer_Settings_Create_Info_EXT.{
            setting_count = settings.count,
            p_settings    = settings.data,
        };
        debug_utils_messenger_create_info.p_next = *settings_create_info;

        instance_create_info.p_next = *debug_utils_messenger_create_info;
    }

    result, instance := VK.create_instance(*instance_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create instance: %", result),
            instance;
    }

    return
        "",
        instance;
}

create_image :: (
    device:           VK.Device,
    allocator:        VMA.Allocator,
    format:           VK.Format,
    width:            u32,
    height:           u32,
    depth:            u32,
    tiling:           VK.Image_Tiling,
    usage:            VK.Image_Usage_Flags,
    allocation_flags: VMA.Allocation_Create_Flags,
    aspect_mask:      VK.Image_Aspect_Flags,
) -> error: string, Image_Info {
    image_info: Image_Info;

    image_create_info := VK.Image_Create_Info.{
        image_type = ._2D,
        format     = format,
        extent = {
            width  = width,
            height = height,
            depth  = depth,
        },
        mip_levels     = 1,
        array_layers   = 1,
        samples        = ._1,
        tiling         = tiling,
        usage          = usage,
        initial_layout = .UNDEFINED,
        sharing_mode   = .EXCLUSIVE,
    };

    allocation_create_info := VMA.Allocation_Create_Info.{
        flags = allocation_flags,
        usage = .AUTO,
    };

    result:, image_info.image, image_info.allocation = VMA.create_image(
        allocator,
        *image_create_info,
        *allocation_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create image: %", result),
            image_info;
    }

    error:, image_info.image_view = create_image_view(
        device,
        image_info.image,
        format,
        aspect_mask,
    );
    if error {
        return error, image_info;
    }

    image_info.format = format;

    return "", image_info;
}

destroy_image :: (
    device: VK.Device,
    allocator: VMA.Allocator,
    image_info: *Image_Info,
) {
    VK.destroy_image_view(device, image_info.image_view);
    VMA.destroy_image(allocator, image_info.image, image_info.allocation);

    image_info.* = {};
}

create_image_view :: (
    device: VK.Device,
    image: VK.Image,
    format: VK.Format,
    aspect_mask: VK.Image_Aspect_Flags,
) -> error: string, VK.Image_View {
    image_view_create_info := VK.Image_View_Create_Info.{
        image     = image,
        view_type = ._2D,
        format    = format,
        subresource_range = {
            aspect_mask = aspect_mask,
            level_count = 1,
            layer_count = 1,
        },
    };

    result, image_view := VK.create_image_view(device, *image_view_create_info);
    if result != .SUCCESS {
        return
            tprint("Failed to create image view: %", result),
            image_view;
    }

    return "", image_view;
}

create_shader_module :: (
    device: VK.Device,
    name: string,
    get_compiled_shader: Get_Compiled_Shader,
) -> error: string, VK.Shader_Module {
    error, content := get_compiled_shader(name,, temp);
    if error {
        return
            error,
            null;
    }

    shader_module_create_info := VK.Shader_Module_Create_Info.{
        code_size = cast(u32, content.count * size_of(u8)),
        p_code    = cast(*u32, content.data),
    };

    result, shader_module := VK.create_shader_module(
        device,
        *shader_module_create_info,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to create shader module: %", result),
            shader_module;
    }

    return "", shader_module;
}

#if DEBUG {
    create_debug_utils_messenger :: (instance: VK.Instance) -> VK.Debug_Utils_Messenger_Ext {
        create_debug_utils_messenger_ext: VK.Pfn_Create_Debug_Utils_Messenger_Ext = VK.get_instance_proc_addr(
            instance,
            "vkCreateDebugUtilsMessengerEXT",
        );
        assert(create_debug_utils_messenger_ext != null);

        debug_utils_messenger: VK.Debug_Utils_Messenger_Ext;

        result := create_debug_utils_messenger_ext(instance, *DEBUG_UTILS_MESSENGER_CREATE_INFO, null, *debug_utils_messenger);
        assert(result == .SUCCESS);

        return debug_utils_messenger;
    }

    destroy_debug_utils_messenger :: (
        instance:  VK.Instance,
        messenger: VK.Debug_Utils_Messenger_Ext,
    ) {
        destroy_debug_utils_messenger_ext: VK.Pfn_Destroy_Debug_Utils_Messenger_Ext = VK.get_instance_proc_addr(
            instance,
            "vkDestroyDebugUtilsMessengerEXT",
        );
        assert(destroy_debug_utils_messenger_ext != null);

        destroy_debug_utils_messenger_ext(instance, messenger, null);
    }

    debug_utils_messenger_callback: VK.Pfn_Debug_Utils_Messenger_Callback_Ext : (
        message_severity: VK.Debug_Utils_Message_Severity_Flags_Ext,
        message_types:    VK.Debug_Utils_Message_Type_Flags_Ext,
        p_callback_data:  *VK.Debug_Utils_Messenger_Callback_Data_Ext,
        p_user_data:      *void,
    ) -> VK.Bool #c_call {
        if message_severity >= .WARNING_EXT {
            push_context {
                print(
                    "VK Validation (% - %): %\n",
                    message_severity,
                    message_types,
                    to_string(p_callback_data.p_message),
                );
            }
        }

        return VK.FALSE;
    }
}

scale_keeping_ratio_and_get_rect :: (src: VK.Extent_2D, dst: VK.Extent_2D) -> (
    left_x: s32,
    left_y: s32,
    right_x: s32,
    right_y: s32
) {
    scale := min(
        cast(float, dst.width)  / cast(float, src.width),
        cast(float, dst.height) / cast(float, src.height),
    );

    width  := cast(s32, cast(float, src.width)  * scale);
    height := cast(s32, cast(float, src.height) * scale);

    left_x := (cast(s32, dst.width)  - width)  / 2;
    left_y := (cast(s32, dst.height) - height) / 2;

    return left_x, left_y, left_x + width, left_y + height;
}

#import "Basic";
#import "Math";
VK  :: #import "vendored/Jai_Vulkan";
VMA :: #import "vendored/Vulkan_Memory_Allocator"(DEBUG = DEBUG);

#if DEBUG {
    #import "Print_Vars";
}

#load "model.jai";
