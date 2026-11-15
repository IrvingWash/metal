impl_sdl3_init_for_vulkan :: (window: *SDL.Window) -> bool #foreign libimgui "?ImGui_ImplSDL3_InitForVulkan@@YA_NPEAUSDL_Window@@@Z";

impl_sdl3_new_frame :: () -> void #foreign libimgui "?ImGui_ImplSDL3_NewFrame@@YAXXZ";

impl_sdl3_shutdown :: () -> void #foreign libimgui "?ImGui_ImplSDL3_Shutdown@@YAXXZ";

impl_sdl3_process_event :: (event: *SDL.Event) -> bool #foreign libimgui "?ImGui_ImplSDL3_ProcessEvent@@YA_NPEBTSDL_Event@@@Z";



#scope_file

SDL :: #import "SDL3";
