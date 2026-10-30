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

#load "asset_manager.jai";

State :: struct {
    window:        *Windowing.Window;
    asset_manager: Asset_Manager;
    renderer:      Renderer.Renderer;
    camera:        Renderer.Camera = {
        position     = { 3, 3, 5 },
        z_near       = 0.1,
        z_far        = 1000,
        fov_vertical = 1.047198,
    };

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

    error, suzanne_model := asset_manager_upload_model(*state.asset_manager, "assets/models/Suzanne/gltf/Suzanne.gltf");
    assert(!error, error);

    while !state.should_quit {
        process_input();

        Renderer.start_drawing(*state.renderer, state.camera);
        Renderer.draw_model(*state.renderer, suzanne_model);
        Renderer.finish_drawing(*state.renderer, suzanne_model);

        reset_temporary_storage();
    }
}

process_input :: () {
    events := Input.get_events(,, temp);

    for event: events {
        if #complete event.kind == {
            case .QUIT;
                state.should_quit = true;
            case .WINDOW_PIXEL_SIZE_CHANGED;
                state.renderer.should_recreate_swapchain = true;
        }
    }
}

init :: () {
    ok := Windowing.init();
    assert(ok, "Failed to create window");
    state.window = Windowing.create_window("metal", 800, 600, .RESIZABLE | .VULKAN);
    assert(state.window != null, "Failed to create window");

    Input.init();

    state.asset_manager = init_asset_manager();

    error:, state.renderer = Renderer.init(
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

    Input.deinit();

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
