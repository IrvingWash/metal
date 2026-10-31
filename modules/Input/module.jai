// It's just a wrapper around SDL. Maybe later we should change this to a custom module

Input_State :: struct {
    window_events_this_frame: [..]Window_Event;
    key_states_this_frame:     [SCAN_CODE_COUNT]Key_State;
}

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

Key_State :: enum {
    RELEASED;
    JUST_PRESSED;
    HELD;
    JUST_RELEASED;
}

init :: () -> Input_State {
    input_state: Input_State;

    return input_state;
}

deinit :: (input_state: *Input_State) {
    array_free(input_state.window_events_this_frame);

    input_state.* = {};
}

update :: (input_state: *Input_State) {
    { // Window_Event
        array_reset_keeping_memory(*input_state.window_events_this_frame);

        sdl_event: SDL.Event;
        while SDL.poll_event(*sdl_event) {
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
            }
        }
    }

    { // Key_State
        prev_frame := input_state.key_states_this_frame;

        sdl_key_states: []bool;
        {
            count: s32;
            pointer := SDL.get_keyboard_state(*count);
            sdl_key_states.count = count;
            sdl_key_states.data = pointer;
        }

        for sdl_key_pressed: sdl_key_states {
            if sdl_key_pressed {
                if #complete prev_frame[it_index] == {
                    case .JUST_RELEASED; #through;
                    case .RELEASED;
                        input_state.key_states_this_frame[it_index] = .JUST_PRESSED;
                    case .HELD; #through;
                    case .JUST_PRESSED;
                        input_state.key_states_this_frame[it_index] = .HELD;
                }
            } else {
                if #complete prev_frame[it_index] == {
                    case .JUST_RELEASED; #through;
                    case .RELEASED;
                        input_state.key_states_this_frame[it_index] = .RELEASED;
                    case .HELD; #through;
                    case .JUST_PRESSED;
                        input_state.key_states_this_frame[it_index] = .JUST_RELEASED;
                }
            }
        }
    }
}



#scope_file

SCAN_CODE_COUNT :: #run enum_highest_value(Scan_Code);

#import "Basic";
SDL :: #import "vendored/SDL3";
