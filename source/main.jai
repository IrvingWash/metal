#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER                 = DEBUG,
    TEMP_ALLOCATOR_OVERWRITE_MEMORY = DEBUG,
);

#if DEBUG {
    #import "Print_Vars";
}

Windowing     :: #import "Windowing";
Input         :: #import "Input";
Renderer      :: #import "Renderer"()(
    Window_Type      = *Windowing.Window,
    APPLICATION_NAME = "metal",
    DEBUG            = DEBUG,
);
#import "More_Math";

#load "asset_manager.jai";
#load "camera.jai";

State :: struct {
    window:        *Windowing.Window;
    input_state:   Input.Input_State;
    asset_manager: Asset_Manager;
    renderer:      Renderer.Renderer;

    camera:        Camera;

    models: [..]Renderer.Model;

    should_quit: bool;

    last_frame_time: float;
}

state: State;

main :: () {
    #if DEBUG {
        defer report_memory_leaks();
    }

    setup_formatting();

    init();
    defer deinit();

    display_ids := Windowing.get_display_ids(,, temp);
    assert(display_ids.count > 0, "No displays(?!)");
    error, display_info := Windowing.get_display_info(display_ids[0]);
    assert(!error, error);
    Renderer.set_render_resolution(
        *state.renderer,
        cast(u32, display_info.width * display_info.dpi),
        cast(u32, display_info.height * display_info.dpi),
    );
    state.renderer.normalized_clear_color = { 142.0 / 255.0, 204.0 / 255.0, 254.0 / 255.0, 1 };

    add_model :: (path: string, translation: Vector3 = {}, scale: Vector3 = {1, 1, 1}) {
        model := asset_manager_upload_model(*state.asset_manager, path);

        transform := make_translation_matrix4(translation) * make_scale_matrix4(scale);

        model.transform = transform;
        array_add(*state.models, model);
    }

    add_model("../../Models/damaged_helmet/scene.glb", translation = { -1, 0 ,0 });
    add_model("../../Models/SciFiHelmet/glTF/SciFiHelmet.gltf", translation = {1, 0, 0 });
    // add_model("assets/models/snowy_mountain/snowy_mountain.glb", scale = { 100, 100, 100 });
    add_model("../../Models/death_valley.glb", scale = { 100, 100, 100 });
    // add_model("../../Models/AlphaBlendModeTest/glTF-Binary/AlphaBlendModeTest.glb");
    // add_model("../../Models/Sponza/Sponza.gltf");

    while !state.should_quit {
        dt := calculate_delta_time();

        process_input();

        update(dt);

        render();

        reset_temporary_storage();
    }
}

process_input :: () {
    Input.update(*state.input_state);

    for event: state.input_state.window_events_this_frame {
        if event.kind == {
            case .QUIT;
                state.should_quit = true;
            case .WINDOW_PIXEL_SIZE_CHANGED;
                state.renderer.swapchain_info.should_recreate = true;
        }
    }

    #if DEBUG {
        if state.input_state.keys[Input.Scan_Code.F1] & .PRESSED {
            current := Windowing.get_window_relative_cursor_mode(state.window);
            Windowing.set_window_relative_cursor_mode(state.window, !current);
        }
    }
}

update :: (dt: float) {
    update_camera(*state.camera, dt);
}

render :: () {
    error := Renderer.start_drawing(*state.renderer, state.camera);
    assert(!error, error);
    for model: state.models {
        Renderer.draw_model(*state.renderer, model);
    }
    error = Renderer.finish_drawing(*state.renderer);
    assert(!error, error);
}

init :: () {
    ok := Windowing.init();
    assert(ok, "Failed to create window");
    state.window = Windowing.create_window("metal", 800, 600, .RESIZABLE | .VULKAN);
    assert(state.window != null, "Failed to create window");
    error := Windowing.set_window_relative_cursor_mode(state.window, enabled = true);
    if error {
        log("Failed to enable window relative cursor mode: %", error, flags = .WARNING);
    }

    state.input_state = Input.init();

    state.asset_manager = init_asset_manager();

    error, state.renderer = Renderer.init(
        state.window,
        Windowing.get_vulkan_instance_extensions,
        Windowing.get_renderable_size,
        Windowing.create_vulkan_surface,
        get_compiled_shader,
    );
    assert(error == "", "Failed to initialize Renderer: %", error);
}

deinit :: () {
    Renderer.deinit(*state.renderer);

    deinit_asset_manager(*state.asset_manager);

    Input.deinit(*state.input_state);

    Windowing.destroy_window(state.window);
    Windowing.deinit();
}

calculate_delta_time :: () -> float {
    now := cast(float, seconds_since_init());

    dt  := now - state.last_frame_time;

    state.last_frame_time = now;

    return dt;
}

get_compiled_shader :: (name: string) -> error: string, shader: string {
    error, shader := asset_manager_get_compiled_shader(state.asset_manager, name);
    return error, shader;
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
