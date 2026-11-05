#load "vulkan_backend.jai";
#load "sdl_backend.jai";

ID :: #type u32;

Draw_Callback :: #type (parent_list: *Draw_List, cmd: *Draw_Cmd) #c_call;

Context :: struct {} // @Todo

IO :: struct {
} // @Todo

Font_Atlas :: struct {} // @Todo

Draw_List :: struct {} // @Todo

Draw_Cmd :: struct {} // @Todo

Draw_Data :: struct {} // @Todo

Vector :: struct (T: Type) {
    size:     s32;
    capacity: s32;
    data:     *T;
}

Viewport :: struct {
    id:                ID;
    flags:             Viewport_Flags; // See ImGuiViewportFlags_
    pos:               Vector2; // Main Area: Position of the viewport (Dear ImGui coordinates are the same as OS desktop/native coordinates)
    size:              Vector2; // Main Area: Size of the viewport.
    framebuffer_scale: Vector2; // Density of the viewport for Retina display (always 1,1 on Windows, may be 2,2 etc on macOS/iOS). This will affect font rasterizer density.
    work_pos:          Vector2; // Work Area: Position of the viewport minus task bars, menus bars, status bars (>= Pos)
    work_size:         Vector2; // Work Area: Size of the viewport minus task bars, menu bars, status bars (<= Size)

    platform_handle:     *void; // void* to hold higher-level, platform window handle (e.g. HWND, GLFWWindow*, SDL_Window*)
    platform_handle_raw: *void; // void* to hold lower-level, platform-native window handle (under Win32 this is expected to be a HWND, unused for other platforms)
}

Viewport_Flags :: enum_flags u32 {
    NONE                :: 0x0;
    IS_PLATFORM_WINDOW  :: 0x1;
    IS_PLATFORM_MONITOR :: 0x2;
    OWNED_BY_APP        :: 0x4;
}

Condition :: enum u32 {
    NONE           :: 0;
    ALWAYS         :: 1;
    ONCE           :: 2;
    FIRST_USE_EVER :: 4;
    APPEARING      :: 8;
}

Window_Flags :: enum_flags u32 {
    NONE                        :: 0x0;
    NO_TITLE_BAR                :: 0x1;
    NO_RESIZE                   :: 0x2;
    NO_MOVE                     :: 0x4;
    NO_SCROLLBAR                :: 0x8;
    NO_SCROLL_WITH_MOUSE        :: 0x10;
    NO_COLLAPSE                 :: 0x20;
    ALWAYS_AUTO_RESIZE          :: 0x40;
    NO_BACKGROUND               :: 0x80;
    NO_SAVED_SETTINGS           :: 0x100;
    NO_MOUSE_INPUTS             :: 0x200;
    MENU_BAR                    :: 0x400;
    HORIZONTAL_SCROLLBAR        :: 0x800;
    NO_FOCUS_ON_APPEARING       :: 0x1000;
    NO_BRING_TO_FRONT_ON_FOCUS  :: 0x2000;
    ALWAYS_VERTICAL_SCROLLBAR   :: 0x4000;
    ALWAYS_HORIZONTAL_SCROLLBAR :: 0x8000;
    NO_NAV_INPUTS               :: 0x10000;
    NO_NAV_FOCUS                :: 0x20000;
    UNSAVED_DOCUMENT            :: 0x40000;
    NO_NAV                      :: 0x30000;
    NO_DECORATION               :: 0x2b;
    NO_INPUTS                   :: 0x30200;

    CHILD_WINDOW :: 0x1000000;
    TOOLTIP      :: 0x2000000;
    POPUP        :: 0x4000000;
    MODAL        :: 0x8000000;
    CHILD_MENU   :: 0x10000000;
}

create_context :: (shared_font_atlas: *Font_Atlas = null) -> *Context #foreign libimgui "_ZN5ImGui13CreateContextEP11ImFontAtlas";

get_io :: () -> *IO #foreign libimgui "_ZN5ImGui5GetIOEv";

new_frame :: () -> void #foreign libimgui "_ZN5ImGui8NewFrameEv";

render :: () -> void #foreign libimgui "_ZN5ImGui6RenderEv";

destroy_context :: (ctx: *Context = null) -> void #foreign libimgui "_ZN5ImGui14DestroyContextEP12ImGuiContext";

get_main_viewport :: () -> *Viewport #foreign libimgui "_ZN5ImGui15GetMainViewportEv";

set_next_window_pos :: (
    position:  Vector2,
    condition: Condition = .NONE,
    pivot:     Vector2   = {},
) #no_context {
    set_next_window_pos(*position, condition, *pivot);
}

set_next_window_pos :: (
    position:  *Vector2,
    condition: Condition = .NONE,
    pivot:     *Vector2,
) -> void #foreign libimgui "_ZN5ImGui16SetNextWindowPosERK6ImVec2iS2_";

set_next_window_size :: (size: Vector2, condition: Condition = .NONE) #no_context {
    set_next_window_size(*size, condition);
}

set_next_window_size :: (
    size: *Vector2,
    condition: Condition = .NONE,
) -> void #foreign libimgui "_ZN5ImGui17SetNextWindowSizeERK6ImVec2i";

set_next_window_bg_alpha :: (alpha: float) -> void #foreign libimgui "_ZN5ImGui20SetNextWindowBgAlphaEf";

begin :: (
    name: *u8,
    p_open: *bool = null,
    flags: Window_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui5BeginEPKcPbi";

end :: () -> void #foreign libimgui "_ZN5ImGui3EndEv";

text :: (fmt: string, __args: ..Any) {
    push_allocator(temp);
    formatted_text_builder: String_Builder;
    print_to_builder(*formatted_text_builder, fmt, ..__args);
    append(*formatted_text_builder, "\0");
    formatted_text := builder_to_string(*formatted_text_builder);
    text_c_format("%", formatted_text.data);
} @PrintLike

text_c_format :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui4TextEPKcz";

get_draw_data :: () -> *Draw_Data #foreign libimgui "_ZN5ImGui11GetDrawDataEv";

show_demo_window :: (p_open: *bool = null) -> void #foreign libimgui "_ZN5ImGui14ShowDemoWindowEPb";

#if OS == .LINUX {
    libimgui :: #library,no_dll "./LINUX/libimgui";
}



#scope_file

#import "Math";
