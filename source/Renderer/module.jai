#module_parameters()(DEBUG: bool = false);

Renderer :: struct {
}

init :: () -> Renderer {
    renderer: Renderer;

    return renderer;
}

deinit :: (renderer: *Renderer) {
    renderer.* = {};
}



#scope_file

Vulkan :: #import "Jai_Vulkan";
VMA    :: #import "Vulkan_Memory_Allocator"(DEBUG = DEBUG);
