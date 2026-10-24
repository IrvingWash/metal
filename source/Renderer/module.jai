#module_parameters()(Window_Type: Type, DEBUG: bool = false);

Additional_Instance_Extensions_Getter :: #type () -> [..]*u8;
Window_Pixel_Size_Getter              :: #type (window: Window_Type) -> width: u32, height: u32;
Window_Surface_Creator :: #type (
    window: Window_Type,
    instance: VK.Instance,
    allocator: *VK.Allocation_Callbacks = null,
) -> VK.Surface_Khr;

Renderer :: struct {
    window:                Window_Type;
    get_window_pixel_size: Window_Pixel_Size_Getter;
    create_window_surface:        Window_Surface_Creator;
}

init :: (
    window:                                Window_Type,
    additional_instance_extensions_getter: Additional_Instance_Extensions_Getter,
    window_pixel_size_getter:              Window_Pixel_Size_Getter,
    window_surface_creator:                Window_Surface_Creator,
) -> Renderer {
    renderer: Renderer;

    renderer.window = window;
    renderer.get_window_pixel_size = window_pixel_size_getter;
    renderer.create_window_surface = window_surface_creator;

    return renderer;
}

deinit :: (renderer: *Renderer) {
    renderer.* = {};
}



#scope_file

VK :: #import "Jai_Vulkan";
VMA    :: #import "Vulkan_Memory_Allocator"(DEBUG = DEBUG);
