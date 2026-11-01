// It's just a wrapper around SDL. Maybe later we should change this to a custom module

Window :: #type SDL.Window;

Create_Window_Flags :: enum_flags {
    VULKAN    :: 0x0000000010000000;
    RESIZABLE :: 0x0000000000000020;
}

Display_Info :: struct {
    width:  u32;
    height: u32;
    dpi:    float;
}

init :: () -> ok: bool {
    ok := SDL.init_subsystem(.VIDEO);

    return ok;
}

deinit :: () {
    SDL.quit_subsystem(.VIDEO);
}

// =============================================================================
// Windowing
// =============================================================================

create_window :: (
    name: string,
    width: u32,
    height: u32,
    flags: Create_Window_Flags,
) -> *Window {
    window := SDL.create_window(
        temp_c_string(name),
        cast(s32, width),
        cast(s32, height),
        cast(SDL.Window_Flags, flags),
    );

    return window;
}

destroy_window :: (window: *Window) {
    SDL.destroy_window(window);
}

get_renderable_size :: (window: *Window) -> width: u32, height: u32 {
    width, height := SDL.get_window_size_in_pixels(window);

    return cast(u32, width), cast(u32, height);
}

get_display_ids :: () -> [..]u32 {
    result: [..]u32;

    display_ids := SDL.get_displays();
    array_resize(*result, display_ids.count);
    for display_id: display_ids {
        result[it_index] = display_id;
    }
    SDL.free(display_ids);

    return result;
}

get_display_info :: (id: u32) -> error: string, Display_Info {
    display_mode := SDL.get_desktop_display_mode(id);
    if !display_mode {
        error := SDL.get_error();

        return to_string(error), .{};
    }

    display_info := Display_Info.{
        width  = cast(u32, display_mode.w),
        height = cast(u32, display_mode.h),
        dpi    = display_mode.pixel_density,
    };

    return "", display_info;
}

get_window_relative_cursor_mode :: (window: *Window) -> bool {
    return SDL.get_window_relative_mouse_mode(window);
}

set_window_relative_cursor_mode :: (window: *Window, enabled: bool) -> error: string {
    ok := SDL.set_window_relative_mouse_mode(window, enabled);
    if !ok {
        error := SDL.get_error();
        return to_string(error);
    }

    return "";
}

// =============================================================================
// Vulkan-specific
// =============================================================================

create_vulkan_surface :: (
    window: *Window,
    instance: VK.Instance,
    allocator: *VK.Allocation_Callbacks = null
) -> VK.Surface_Khr {
    _, surface := SDL.create_vulkan_surface(window, instance, allocator);

    return surface;
}

get_vulkan_instance_extensions :: () -> [..]*u8 {
    extensions: [..]*u8;

    count: u32;
    raw_extensions := SDL.vulkan_get_instance_extensions(*count);

    array_resize(*extensions, count);

    for 0 .. count - 1 {
        extensions[it] = raw_extensions[it];
    }

    return extensions;
}



#scope_file

#import "Basic";
SDL :: #import "vendored/SDL3";
VK  :: #import "vendored/Jai_Vulkan";
