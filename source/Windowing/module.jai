// It's just a wrapper around SDL. Maybe later we should change this to a custom module

Window :: #type SDL.Window;

Create_Window_Flags :: enum_flags {
    VULKAN    :: 0x0000000010000000;
    RESIZABLE :: 0x0000000000000020;
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

get_window_size_in_pixels :: (window: *Window) -> width: u32, height: u32 {
    width, height := SDL.get_window_size_in_pixels(window);

    return cast(u32, width), cast(u32, height);
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

get_vulkan_instance_extensinos :: () -> [..]*u8 {
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
SDL :: #import "SDL3";
VK  :: #import "Jai_Vulkan";
