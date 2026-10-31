// It's just a wrapper around SDL. Maybe later we should change this to a custom module

Event :: union kind: Event_Kind {
    .QUIT,, quit: bool = true;

    .WINDOW_PIXEL_SIZE_CHANGED,, window_pixel_size_changed: struct {
        new_width: u32;
        new_height: u32;
    };
}

Event_Kind :: enum {
    QUIT;
    WINDOW_PIXEL_SIZE_CHANGED;
}

Scan_Code :: SDL.Scancode;

init :: () {}

deinit :: () {}

// @Todo: return an enum PRESS, DOWN, UP, etc
get_keyboard_state :: () -> []bool {
    count: s32;

    states := SDL.get_keyboard_state(*count);

    result: []bool;
    result.count = count;
    result.data = states;

    return result;
}

get_events :: () -> []Event {
    result: [..]Event;

    sdl_event: SDL.Event;
    while SDL.poll_event(*sdl_event) {
        if sdl_event.type == {
            case .QUIT;
                event: Event;
                event.kind = .QUIT;
                event.quit = true;
                array_add(*result, event);
            case .WINDOW_PIXEL_SIZE_CHANGED;
                event: Event;
                event.kind = .WINDOW_PIXEL_SIZE_CHANGED;
                event.window_pixel_size_changed = {
                    new_width = cast(u32, sdl_event.window.data1),
                    new_height = cast(u32, sdl_event.window.data2),
                };
                array_add(*result, event);
        }
    }

    return result;
}



#scope_file

#import "Basic";
SDL :: #import "vendored/SDL3";
