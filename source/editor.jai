init_editor :: (state: *State) {
    editor.state = state;

    editor.ctx = IM.create_context();
    editor.io = IM.get_io();

    editor.io.log_filename = null;

    IM.impl_sdl3_init_for_vulkan(cast(*void, state.window));

    pool_sizes := VK.Descriptor_Pool_Size.[
        {
            type = .SAMPLED_IMAGE,
            descriptor_count = IM.IMPL_VULKAN_MINIMUM_SAMPLED_IMAGE_POOL_SIZE,
        },
        {
            type = .SAMPLER,
            descriptor_count = IM.IMPL_VULKAN_MINIMUM_SAMPLER_POOL_SIZE,
        },
    ];
    pool_info := VK.Descriptor_Pool_Create_Info.{
        flags           = .FREE_DESCRIPTOR_SET,
        max_sets        = 16,
        pool_size_count = pool_sizes.count,
        p_pool_sizes    = pool_sizes.data,
    };
    result:, editor.descriptor_pool = VK.create_descriptor_pool(state.renderer.device, *pool_info);
    assert(result == .SUCCESS, "%", result);

    vulkan_init_info := IM.Impl_Vulkan_Init_Info.{
        api_version           = VK.make_version(1, 4, 0),
        instance              = state.renderer.instance,
        physical_device       = state.renderer.physical_device,
        device                = state.renderer.device,
        queue_family          = state.renderer.graphics_queue_info.family_index,
        queue                 = state.renderer.graphics_queue_info.queue,
        descriptor_pool       = editor.descriptor_pool,
        min_image_count       = state.renderer.swapchain_info.config.min_image_count,
        image_count           = xx state.renderer.swapchain_info.images.count,
        use_dynamic_rendering = true,
        pipeline_info_main.pipeline_rendering_create_info = {
            color_attachment_count     = 1,
            p_color_attachment_formats = *state.
                renderer.
                swapchain_info
                .config.
                image_format,
        },
    };

    IM.impl_vulkan_init(*vulkan_init_info);

    Renderer.set_overlay_callback(*state.renderer, draw_overlay, null);
    Input.set_raw_event_callback(*state.input_state, process_editor_events);
}

draw_editor :: (draw_editing_stuff: bool) {
    IM.impl_vulkan_new_frame();
    IM.impl_sdl3_new_frame();
    IM.new_frame();

    draw_fps_stat();

    if draw_editing_stuff {
        draw_whole_editor();
    }

    IM.render();
}

deinit_editor :: () {
    VK.device_wait_idle(editor.state.renderer.device);

    Input.set_raw_event_callback(*editor.state.input_state, process_editor_events);
    Renderer.set_overlay_callback(*editor.state.renderer, null, null);

    IM.impl_vulkan_shutdown();
    VK.destroy_descriptor_pool(editor.state.renderer.device, editor.descriptor_pool);
    IM.impl_sdl3_shutdown();

    IM.destroy_context(editor.ctx);

    editor = {};
}



#scope_file

draw_whole_editor :: () {
    IM.show_demo_window();

    IM.begin(
        "Editor",
    );
    draw_camera_section();
    IM.end();
}

draw_camera_section :: () {
    if !IM.collapsing_header("Camera", flags = .DEFAULT_OPEN) {
        return;
    }

    IM.push_item_width(200);

    IM.drag_float3(
        "Position",
        *editor.state.camera.position.component,
        v_speed = 0.1,
        v_min = 0,
        v_max = 0,
    );

    { // FOV
        SPEED :: 1;
        MIN   :: 1;
        MAX   :: 120;

        current_fov_in_degrees := rad_to_deg(editor.state.camera.fov_vertical);

        if IM.drag_float(
            "FOV vertical",
            *current_fov_in_degrees,
            v_speed = SPEED,
            v_min = MIN,
            v_max = MAX,
        ) {
            editor.state.camera.fov_vertical = deg_to_rad(current_fov_in_degrees);
        }
    }

    IM.drag_float(
        "Exposure",
        *editor.state.camera.exposure,
        v_speed = 0.1,
        v_min = 0,
        v_max = 0,
    );
}

draw_fps_stat :: () {
    WIDTH :: 80;

    viewport := IM.get_main_viewport();

    IM.set_next_window_bg_alpha(0.5);
    IM.set_next_window_pos({ viewport.work_pos.x + viewport.work_size.x - WIDTH, 0 });
    IM.set_next_window_size({ WIDTH, 0 });

    IM.begin(
        "FPS",
        flags = .NO_TITLE_BAR | .NO_RESIZE | .NO_COLLAPSE | .NO_DECORATION | .NO_NAV_FOCUS,
    );

    IM.text(tprint("FPS: %", cast(int, editor.io.framerate)));

    IM.end();
}

process_editor_events :: (event: *Input.Raw_Event_Type) {
    IM.impl_sdl3_process_event(cast(*void, event));
}

draw_overlay : Renderer.Overlay_Callback : (command_buffer: VK.Command_Buffer, user_data: *void) {
    draw_data := IM.get_draw_data();

    if draw_data {
        IM.impl_vulkan_render_draw_data(draw_data, cast(*void, command_buffer));
    }
}

Editor :: struct {
    state: *State;

    ctx: *IM.Context;
    io:  *IM.IO;

    descriptor_pool: VK.Descriptor_Pool;
}

editor: Editor;

IM    :: #import "Dear_ImGui";
VK    :: #import "Jai_Vulkan";
Input :: #import "Input";
Renderer      :: #import "Renderer";
