#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER                 = DEBUG,
    TEMP_ALLOCATOR_OVERWRITE_MEMORY = DEBUG,
);

#if DEBUG {
    #import "Print_Vars";
}

Windowing     :: #import,dir "Windowing";
Input         :: #import,dir "Input";
Renderer      :: #import,dir "Renderer"()(
    Window_Type      = *Windowing.Window,
    APPLICATION_NAME = "metal",
    DEBUG            = DEBUG,
);
Asset_Manager :: #import,dir "Asset_Manager";

State :: struct {
    window:        *Windowing.Window;
    asset_manager: Asset_Manager.Asset_Manager;
    renderer:      Renderer.Renderer;

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

    while !state.should_quit {
        process_input();

        Renderer.start_drawing(*state.renderer);
        Renderer.draw(*state.renderer);
        Renderer.finish_drawing(*state.renderer);

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
                // Do nothing
        }
    }
}

init :: () {
    ok := Windowing.init();
    assert(ok, "Failed to create window");
    state.window = Windowing.create_window("metal", 800, 600, .RESIZABLE | .VULKAN);
    assert(state.window != null, "Failed to create window");

    Input.init();

    state.asset_manager = Asset_Manager.init();

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

    Asset_Manager.deinit(*state.asset_manager);

    Input.deinit();

    Windowing.destroy_window(state.window);
    Windowing.deinit();
}

get_compiled_shader :: (name: string) -> error: string, shader: string {
    error, shader := Asset_Manager.get_compiled_shader(state.asset_manager, name);
    return error, shader;
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
