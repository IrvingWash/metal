impl_sdl3_init_for_vulkan :: (window: *SDL.Window) -> bool #foreign libimgui "_Z28ImGui_ImplSDL3_InitForVulkanP10SDL_Window";

impl_sdl3_new_frame :: () -> void #foreign libimgui "_Z23ImGui_ImplSDL3_NewFramev";

impl_sdl3_shutdown :: () -> void #foreign libimgui "_Z23ImGui_ImplSDL3_Shutdownv";

impl_sdl3_process_event :: (event: *SDL.Event) -> bool #foreign libimgui "_Z27ImGui_ImplSDL3_ProcessEventPK9SDL_Event";



#scope_file

SDL :: #import "SDL3";
