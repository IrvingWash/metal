#placeholder DEBUG;

#import "Basic"()(
    MEMORY_DEBUGGER                 = DEBUG,
    TEMP_ALLOCATOR_OVERWRITE_MEMORY = DEBUG,
);

Windowing :: #import,dir "Windowing";
Input     :: #import,dir "Input";
Renderer  :: #import,dir "Renderer"()(Window_Type = *Windowing.Window, APPLICATION_NAME = "metal", DEBUG = DEBUG);

State :: struct {
    window:   *Windowing.Window;
    renderer: Renderer.Renderer;

    should_quit: bool;
}

state: State;

main :: () {
    #if DEBUG {
        defer report_memory_leaks();
    }

    setup_formatting();

    print("Hello, Sailor!\n");

    init();
    defer deinit();

    while !state.should_quit {
        process_input();

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

    state.renderer = Renderer.init(
        state.window,
        Windowing.get_vulkan_instance_extensions,
        Windowing.get_renderable_size,
        Windowing.create_vulkan_surface,
    );
}

deinit :: () {
    Renderer.deinit(*state.renderer);

    Input.deinit();

    Windowing.destroy_window(state.window);
    Windowing.deinit();
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
