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

    // error, model := asset_manager_upload_model(*state.asset_manager, "assets/models/viking_room/scene.gltf");
    // error, model := asset_manager_upload_model(*state.asset_manager, "assets/models/Suzanne/gltf/Suzanne.gltf");
    // error, barn_model := asset_manager_upload_model(*state.asset_manager, "assets/models/barn/scene.gltf");
    // error, model := asset_manager_upload_model(*state.asset_manager, "assets/models/Fox/glb/Fox.glb");
    // error, model := asset_manager_upload_model(*state.asset_manager, "assets/models/Fox/gltf/Fox.gltf");
    error, gundam_model1 := asset_manager_upload_model(*state.asset_manager, "assets/models/gundam1/gundam.glb");
    assert(!error, error);
    array_add(*state.models, gundam_model1);
    error =, gundam_model2 := asset_manager_upload_model(*state.asset_manager, "assets/models/gundam2/scene.gltf");
    assert(!error, error);
    array_add(*state.models, gundam_model2);
    error =, gundam_model3 := asset_manager_upload_model(*state.asset_manager, "assets/models/gundam3/scene.gltf");
    assert(!error, error);
    array_add(*state.models, gundam_model3);
    error =, gundam_model4 := asset_manager_upload_model(*state.asset_manager, "assets/models/gundam4/model.gltf");
    assert(!error, error);
    array_add(*state.models, gundam_model4);
    error =, gundam_model5 := asset_manager_upload_model(*state.asset_manager, "assets/models/gundam5/scene.gltf");
    assert(!error, error);
    array_add(*state.models, gundam_model5);

    while !state.should_quit {
        process_input();

        update();

        render();

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

update :: () {
    update_camera(*state.camera);
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
