#placeholder DEBUG;
#placeholder DEVELOPER;

#if DEBUG {
    #import "Print_Vars";
}

Game :: struct {
    window:        *Windowing.Window;
    input_state:   Input.Input_State;
    asset_manager: Asset_Manager;
    renderer:      Renderer.Renderer;
    audio_player:  Audio_Player.Audio_Player;

    camera: Camera;

    entity_manager: Entity_Manager;

    directional_light: Renderer.Directional_Light_Params;

    grid: Grid;

    conductor: Conductor;

    #if DEVELOPER {
        is_in_editor_mode: bool = false;
    }

    should_quit: bool;

    last_frame_time: float64;
}

game: Game;

main :: () {
    #if DEBUG {
        defer report_memory_leaks({ scan_global_memory_to_remove_leaks = false });
    }

    setup_formatting();

    init();
    defer deinit();

    load_level_1();

    start_conductor(*game.conductor);

    while !game.should_quit {
        dt := calculate_delta_time();

        process_input();

        update(dt);

        render();

        reset_temporary_storage();
    }
}

get_orbit_camera_input :: () -> Orbit_Camera_Input {
    move_direction: Move_Direction;

    return {
        orbit_delta = game.input_state.mouse.delta,
    };
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

#import "Random";

Windowing     :: #import "Windowing";
Input         :: #import "Input";
Renderer      :: #import "Renderer"()(
    Window_Type      = *Windowing.Window,
    APPLICATION_NAME = "metal",
    DEBUG            = DEBUG,
);
Audio_Player :: #import "Audio_Player";

#import "More_Math";

#load "asset_manager.jai";
#load "animation.jai";
#load "camera.jai";
#load "camera_controllers.jai";
#load "grid.jai";
#load "conductor.jai";
#load "entity_manager.jai";
#load "entity.jai";
#load "entities/cube.jai";
#load "entities/mech.jai";
#load "entities/sourceless_spot_light.jai";

#if DEVELOPER {
    #load "developer/editor.jai";
    #load "developer/debug_drawing.jai";
}

load_level_1 :: () {
    game.directional_light = {
        color = { 1, 1, 1 },
        direction = { 0, -1, -1 },
    };
    game.renderer.clear_color = { 0, 0, 0, 1 };
    game.renderer.shadow_distance = 10;

    track_handle := asset_manager_upload_audio(
        *game.asset_manager,
        "../../planet-carrion.flac",
        *game.audio_player,
    );
    game.conductor.track = asset_manager_get_audio(game.asset_manager, track_handle);

    spawn_entity(
        *game.entity_manager,
        Cube.{
            name = "Floor",
            scale = { 100, 0.01, 100 },
            position = { 0, -2, 0 },
        },
    );

    spawn_entity(
        *game.entity_manager,
        Cube.{
            name = "Building",
            scale = { 1, 1, 1 },
            position = { 3, -2, 0 },
        },
    );

    spawn_entity(
        *game.entity_manager,
        Sourceless_Spot_Light.{
            name = "Light",
        },
    );

    spawn_entity(*game.entity_manager, Mech.{});
}

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

    update_entity_manager(*game.entity_manager);

    update_grid(*game.grid);

    update_conductor(*game.conductor);

    for *mech: game.entity_manager.storage._Mech {
        simulate_mech(mech, dt);
    }

    for entity: game.entity_manager.all {
        update_animation(entity, dt, game.asset_manager);
    }
}

render :: () {
    error := Renderer.start_drawing(*game.renderer, game.camera);
    assert(!error, error);

    #if DEVELOPER {
        draw_editor(game.is_in_editor_mode);
    }

    for entity: game.entity_manager.all {
        if entity.flags & .INVISIBLE {
            continue;
        }

        model_asset := asset_manager_get_model(game.asset_manager, entity.model_asset_handle);

        Renderer.draw_model(
            *game.renderer,
            model_asset.model_accessor,
            make_world_transform(entity),
            entity.tint,
            entity.animation_player.pose,
        );
    }

    for *ssl: game.entity_manager.storage._Sourceless_Spot_Light {
        ssl.params.position = ssl.position;

        Renderer.draw_spot_light(*game.renderer, ssl.params);
    }

    error = Renderer.draw_directional_light(
        *game.renderer,
        game.directional_light,
    );
    assert(!error, error);

    #if DEBUG {
        submit_debug_drawing();
    }

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

    error, game.audio_player = Audio_Player.init();
    assert(!error, "Failed to initialize Audio_Player: %", error);

    display_ids := Windowing.get_display_ids(,, temp);
    assert(display_ids.count > 0, "No displays(?!)");
    error =, display_info := Windowing.get_display_info(display_ids[0]);
    assert(!error, error);
    Renderer.set_render_resolution(
        *game.renderer,
        cast(u32, display_info.width * display_info.dpi),
        cast(u32, display_info.height * display_info.dpi),
    );

    game.entity_manager = init_entity_manager(*game.asset_manager, *game.renderer);

    #if DEVELOPER {
        init_editor(*game);
        init_debug_drawing(*game.renderer);
    }
}

deinit :: () {
    #if DEVELOPER {
        deinit_debug_drawing();
        deinit_editor();
    }

    #if DEBUG {
        destroy_entity_manager(*game.entity_manager);

        Audio_Player.deinit(*game.audio_player);

        Renderer.deinit(*game.renderer);

        deinit_asset_manager(*game.asset_manager);

        Input.deinit(*game.input_state);
    }

    Windowing.destroy_window(game.window);
    Windowing.deinit();
}

calculate_delta_time :: () -> float {
    now := seconds_since_init();

    dt  := now - game.last_frame_time;

    game.last_frame_time = now;

    return cast(float, dt);
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
