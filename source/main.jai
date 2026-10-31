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
}

state: State;

main :: () {
    #if DEBUG {
        defer report_memory_leaks();
    }

    setup_formatting();

    init();
    defer deinit();

    Renderer.set_directional_light(*state.renderer, { color = {0.9, 0.7, 0.7}, direction = { 1, -1, -1 } });
    state.renderer.normalized_clear_color = { 0.3, 0.1, 0.1, 1 };

    add_model :: (path: string) {
        error, model := asset_manager_upload_model(*state.asset_manager, path);
        assert(!error, error);
        array_add(*state.models, model);
    }

    add_model("assets/models/snowy_mountain/snowy_mountain.glb");
    state.models[0].transform = make_scale_matrix4({ 100, 100, 100 });
    add_model("assets/models/gundam5/scene.gltf");
    add_model("assets/models/gundam2/scene.gltf");

    while !state.should_quit {
        process_input();

        update();

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
                state.renderer.should_recreate_swapchain = true;
        }
    }
}

update :: () {
    DELTA_TIME :: 0.016;

    update_camera(*state.camera, DELTA_TIME);
}

render :: () {
    Renderer.start_drawing(*state.renderer, state.camera);
    for model: state.models {
        Renderer.draw_model(*state.renderer, model);
    }
    Renderer.finish_drawing(*state.renderer);
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
    error = Input.set_cursor_capture(*state.input_state, should_capture = true);
    if error {
        log("Failed to enable cursor capture: %", error, flags = .WARNING);
    }

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
