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
Renderer      :: #import,dir "Renderer"()(Window_Type = *Windowing.Window, APPLICATION_NAME = "metal", DEBUG = DEBUG);

#load "gltf_converter.jai";

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

    init();
    defer deinit();

    model_dto := convert_gltf("assets/models/Fox/glb/Fox.glb");

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

    error:, state.renderer = Renderer.init(
        state.window,
        Windowing.get_vulkan_instance_extensions,
        Windowing.get_renderable_size,
        Windowing.create_vulkan_surface,
        read_shader_from_file,
    );
    assert(error == "", "Failed to initialize Renderer: %", error);
}

deinit :: () {
    Renderer.deinit(*state.renderer);

    Input.deinit();

    Windowing.destroy_window(state.window);
    Windowing.deinit();
}

read_shader_from_file :: (name: string) -> error: string, shader: string {
    System :: #import "System";
    String :: #import "String";
    File   :: #import "File";

    exe_path := System.get_path_of_running_executable();

    root_path := String.path_strip_filename(exe_path);
    path := String.path_join(root_path, "shaders", name,, temp);

    content, ok := File.read_entire_file(path);
    if !ok {
        return
            tprint("Failed to read shader file at '%'", path),
            content;
    }

    return "", content;
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
