// It's just a wrapper around SDL. Maybe later we should change this to a custom module

Input_State :: struct {
    window_events_this_frame: [..]Window_Event;
    keys:                     [SCAN_CODE_COUNT]Key_State;
    cursor:                   Cursor_State;
    wheel:                    Wheel_State;

    raw_event_callback: Raw_Event_Callback;
}

Raw_Event_Callback :: #type (event: *Raw_Event_Type);

Raw_Event_Type :: #type SDL.Event;

Window_Event :: union kind: Window_Event_Kind {
    .NONE,, none: void;
    .QUIT,, quit: bool = true;

    .WINDOW_PIXEL_SIZE_CHANGED,, window_pixel_size_changed: struct {
        new_width: u32;
        new_height: u32;
    };
}

Window_Event_Kind :: enum {
    NONE;
    QUIT;
    WINDOW_PIXEL_SIZE_CHANGED;
}

Scan_Code :: SDL.Scancode;

Key_State :: enum_flags {
    DOWN;
    PRESSED;
    RELEASED;
}

Cursor_State :: struct {
    position:      Vector2;
    delta:         Vector2;
}

Wheel_State :: struct {
    delta: Vector2;
}

init :: () -> Input_State {
    input_state: Input_State;

    {
        x, y: float;
        SDL.get_mouse_state(*x, *y);
        input_state.cursor.position = { x, y };
    }

    return input_state;
}

deinit :: (input_state: *Input_State) {
    array_free(input_state.window_events_this_frame);

    input_state.* = {};
}

set_raw_event_callback :: (input_state: *Input_State, proc: Raw_Event_Callback) {
    input_state.raw_event_callback = proc;
}

update :: (input_state: *Input_State) {
    array_reset_keeping_memory(*input_state.window_events_this_frame);

    for *key_state: input_state.keys {
        key_state.* &= ~(.PRESSED | .RELEASED);
    }

    input_state.cursor.delta = {};

    input_state.wheel.delta = {};

    sdl_event: SDL.Event;
    while SDL.poll_event(*sdl_event) {
        if input_state.raw_event_callback {
            input_state.raw_event_callback(*sdl_event);
        }

        if sdl_event.type == {
            case .QUIT;
                event: Window_Event;
                event.kind = .QUIT;
                event.quit = true;
                array_add(*input_state.window_events_this_frame, event);
            case .WINDOW_PIXEL_SIZE_CHANGED;
                event: Window_Event;
                event.kind = .WINDOW_PIXEL_SIZE_CHANGED;
                event.window_pixel_size_changed = {
                    new_width = cast(u32, sdl_event.window.data1),
                    new_height = cast(u32, sdl_event.window.data2),
                };
                array_add(*input_state.window_events_this_frame, event);
            case .MOUSE_MOTION;
                input_state.cursor.position = {
                    sdl_event.motion.x,
                    sdl_event.motion.y,
                };
                input_state.cursor.delta += {
                    sdl_event.motion.xrel,
                    sdl_event.motion.yrel,
                };
            case .KEY_DOWN;
                if !sdl_event.key.repeat {
                    key := *input_state.keys[sdl_event.key.scancode];
                    key.* |= .DOWN | .PRESSED;
                }
            case .KEY_UP;
                key := *input_state.keys[sdl_event.key.scancode];
                key.* &= ~.DOWN;
                key.* |= .RELEASED;
            case .MOUSE_WHEEL;
                input_state.wheel.delta += {
                    sdl_event.wheel.x,
                    sdl_event.wheel.y,
                };
        }
    }
}

set_cursor_capture :: (input_state: *Input_State, should_capture: bool) -> error: string {
    ok := SDL.capture_mouse(should_capture);
    if !ok {
        error := SDL.get_error();
        return to_string(error);
    }

    return "";
}



#scope_file

SCAN_CODE_COUNT :: #run enum_highest_value(Scan_Code);

#import "Basic";
#import "Math";
SDL :: #import "SDL3";
