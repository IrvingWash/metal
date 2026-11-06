#placeholder DEBUG;
#placeholder DEVELOPER;

Game :: struct {
    window:        *Windowing.Window;
    input_state:   Input.Input_State;
    asset_manager: Asset_Manager;
    renderer:      Renderer.Renderer;

    camera: Camera;

    camera_controller_kind: Camera_Controller_Kind = .FLY;

    entities: [..]Entity;

    #if DEVELOPER {
        is_in_editor_mode: bool = false;
    }

    should_quit: bool;

    last_frame_time: float64;
}

Entity :: struct {
    name: string;

    position: Vector3;
    rotation: Quaternion;
    scale:    Vector3 = { 1, 1, 1 };

    model_handle: Model_Handle;
}

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
        *game.renderer,
        cast(u32, display_info.width * display_info.dpi),
        cast(u32, display_info.height * display_info.dpi),
    );
    game.renderer.normalized_clear_color = { 142.0 / 255.0, 204.0 / 255.0, 254.0 / 255.0, 1 };

    add_entity(
        name       = "Damaged Helmet",
        model_path = "../../Models/damaged_helmet/scene.glb",
        position   = { -1, -4.5 ,0 },
    );
    add_entity(
        name       = "SciFiHelmet",
        model_path = "../../Models/SciFiHelmet/glTF/SciFiHelmet.gltf",
        position   = {1, -4.5, 0 },
    );
    add_entity(
        name       = "Mountains",
        model_path = "../../Models/death_valley.glb",
        scale      = { 100, 100, 100 },
    );

    while !game.should_quit {
        dt := calculate_delta_time();

        process_input();

        update(dt);

        render();

        reset_temporary_storage();
    }
}

get_fly_camera_input :: () -> Fly_Camera_Input {
    move_direction: Move_Direction;

    if game.input_state.keys[Input.Scan_Code.W] & .DOWN
        move_direction |= .FORWARD;
    if game.input_state.keys[Input.Scan_Code.S] & .DOWN
        move_direction |= .BACKWARD;
    if game.input_state.keys[Input.Scan_Code.A] & .DOWN
        move_direction |= .LEFT;
    if game.input_state.keys[Input.Scan_Code.D] & .DOWN
        move_direction |= .RIGHT;
    if game.input_state.keys[Input.Scan_Code.E] & .DOWN
        move_direction |= .UP;
    if game.input_state.keys[Input.Scan_Code.Q] & .DOWN
        move_direction |= .DOWN;

    return {
        look_delta     = game.input_state.mouse.delta,
        zoom_delta     = game.input_state.wheel.delta.y,
        sprint         = game.input_state.keys[Input.Scan_Code.LSHIFT] == .DOWN,
        move_direction = move_direction,
    };
}


#scope_file

#import "Basic"()(
    MEMORY_DEBUGGER                 = DEBUG,
    TEMP_ALLOCATOR_OVERWRITE_MEMORY = DEBUG,
);

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
#load "camera_controllers.jai";

#if DEVELOPER {
    #load "editor.jai";
}

game: Game;

process_input :: () {
    Input.update(*game.input_state);

    for event: game.input_state.window_events_this_frame {
        if event.kind == {
            case .QUIT;
                game.should_quit = true;
            case .WINDOW_PIXEL_SIZE_CHANGED;
                game.renderer.swapchain_info.should_recreate = true;
        }
    }

    #if DEVELOPER {
        if game.input_state.keys[Input.Scan_Code.F1] & .PRESSED {
            game.is_in_editor_mode = !game.is_in_editor_mode;

            Windowing.set_window_relative_cursor_mode(game.window, !game.is_in_editor_mode);
        }
    }
}

update :: (dt: float) {
    #if DEVELOPER {
        if game.is_in_editor_mode {
            update_editor(dt);
            return;
        }
    }

    if #complete game.camera_controller_kind == {
        case .FLY;
            fly_camera(*game.camera, dt, get_fly_camera_input());
    }
}

render :: () {
    #if DEVELOPER {
        draw_editor(game.is_in_editor_mode);
    }

    error := Renderer.start_drawing(*game.renderer, game.camera);
    assert(!error, error);
    for entity: game.entities {
        Renderer.draw_model(
            *game.renderer,
            asset_manager_get_model(game.asset_manager, entity.model_handle),
            make_world_transform(entity),
        );
    }

    Renderer.draw_line(
        *game.renderer,
        {
            game.entities[0].position,
            game.entities[1].position,
            { 0, 1, 0, 1 },
        },
    );

    error = Renderer.finish_drawing(*game.renderer);
    assert(!error, error);
}

init :: () {
    ok := Windowing.init();
    assert(ok, "Failed to create window");
    game.window = Windowing.create_window("metal", 800, 600, .RESIZABLE | .VULKAN);
    assert(game.window != null, "Failed to create window");
    error := Windowing.set_window_relative_cursor_mode(game.window, enabled = true);
    if error {
        log("Failed to enable window relative cursor mode: %", error, flags = .WARNING);
    }

    game.input_state = Input.init();

    game.asset_manager = init_asset_manager();

    error, game.renderer = Renderer.init(
        game.window,
        Windowing.get_vulkan_instance_extensions,
        Windowing.get_renderable_size,
        Windowing.create_vulkan_surface,
        get_compiled_shader,
    );
    assert(error == "", "Failed to initialize Renderer: %", error);

    #if DEVELOPER {
        init_editor(*game);
    }
}

deinit :: () {
    array_free(game.entities);

    #if DEVELOPER {
        deinit_editor();
    }

    Renderer.deinit(*game.renderer);

    deinit_asset_manager(*game.asset_manager);

    Input.deinit(*game.input_state);

    Windowing.destroy_window(game.window);
    Windowing.deinit();
}

add_entity :: (
    name: string,
    position: Vector3 = {},
    rotation: Quaternion = {},
    scale:    Vector3 = { 1, 1, 1 },
    model_path: string,
) {
    model_handle := asset_manager_upload_model(*game.asset_manager, model_path, *game.renderer);

    entity: Entity = {
        name = name,
        position = position,
        rotation = rotation,
        scale = scale,
        model_handle = model_handle,
    };

    array_add(*game.entities, entity);
}


calculate_delta_time :: () -> float {
    now := seconds_since_init();

    dt  := now - game.last_frame_time;

    game.last_frame_time = now;

    return cast(float, dt);
}

make_world_transform :: (entity: Entity) -> Matrix4 {
    translation := make_translation_matrix4(entity.position);
    scale       := make_scale_matrix4(entity.scale);
    rotation    := rotation_matrix(Matrix4, entity.rotation);

    return translation * rotation * scale;
}

get_compiled_shader :: (name: string) -> error: string, shader: string {
    error, shader := asset_manager_get_compiled_shader(game.asset_manager, name);
    return error, shader;
}

setup_formatting :: () {
    print_style := *context.print_style;

    print_style.default_format_struct.draw_type_name = true;
    print_style.default_format_struct.use_long_form_if_more_than_this_many_members = 0;
    print_style.default_format_struct.use_newlines_if_long_form = true;
}
