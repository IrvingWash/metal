#load "vulkan_backend.jai";
#load "sdl_backend.jai";
#load "imguizmo.jai";

ID :: #type u32;


Wchar32 :: u32;
Wchar16 :: u16;
Wchar   :: Wchar16;

S8  :: s8;
U8  :: u8;
S16 :: s16;
U16 :: u16;
S32 :: s32;
U32 :: u32;
S64 :: s64;
U64 :: u64;

Key_Chord :: #type s32;

Draw_Callback :: #type (parent_list: *Draw_List, cmd: *Draw_Cmd) #c_call;

Context :: struct {} // @Todo

IO :: struct {
    config_flags:              Config_Flags; // = 0              // See ImGuiConfigFlags_ enum. Set by user/application. Keyboard/Gamepad navigation options, etc.
    backend_flags:             Backend_Flags; // = 0              // See ImGuiBackendFlags_ enum. Set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
    display_size:              Vector2; // <unset>          // Main display size, in pixels (== GetMainViewport()->Size). May change every frame.
    display_framebuffer_scale: Vector2; // = (1, 1)         // Main display density. For retina display where window coordinates are different from framebuffer coordinates. This will affect font density + will end up in ImDrawData::FramebufferScale.
    delta_time:                float; // = 1.0f/60.0f     // Time elapsed since last frame, in seconds. May change every frame.
    ini_saving_rate:           float; // = 5.0f           // Minimum time between saving positions/sizes to .ini file, in seconds.
    ini_filename:              *u8; // = "imgui.ini"    // Path to .ini file (important: default "imgui.ini" is relative to current working dir!). Set NULL to disable automatic .ini loading/saving or if you want to manually call LoadIniSettingsXXX() / SaveIniSettingsXXX() functions.
    log_filename:              *u8; // = "imgui_log.txt"// Path to .log file (default parameter to ImGui::LogToFile when no file is specified).
    user_data:                 *void; // = NULL           // Store your own data.

    fonts:                   *Font_Atlas; // <auto>           // Font atlas: load, rasterize and pack one or more fonts into a single texture.
    font_default:            *Font; // = NULL           // Font to use on NewFrame(). Use NULL to uses Fonts->Fonts[0].
    font_allow_user_scaling: bool; // = false          // Allow user scaling text of individual window with Ctrl+Wheel.

    config_nav_swap_gamepad_buttons:      bool; // = false          // Swap Activate<>Cancel (A<>B) buttons, matching typical "Nintendo/Japanese style" gamepad layout.
    config_nav_move_set_mouse_pos:        bool; // = false          // Directional/tabbing navigation teleports the mouse cursor. May be useful on TV/console systems where moving a virtual mouse is difficult. Will update io.MousePos and set io.WantSetMousePos=true.
    config_nav_capture_keyboard:          bool; // = true           // Sets io.WantCaptureKeyboard when io.NavActive is set.
    config_nav_escape_clear_focus_item:   bool; // = true           // Pressing Escape can clear focused item + navigation id/highlight. Set to false if you want to always keep highlight on.
    config_nav_escape_clear_focus_window: bool; // = false          // Pressing Escape can clear focused window as well (super set of io.ConfigNavEscapeClearFocusItem).
    config_nav_cursor_visible_auto:       bool; // = true           // Using directional navigation key makes the cursor visible. Mouse click hides the cursor.
    config_nav_cursor_visible_always:     bool; // = false          // Navigation cursor is always visible.

    config_mac_osx_behaviors:                  bool; // = defined(__APPLE__) // Swap Cmd<>Ctrl keys + OS X style text editing cursor movement using Alt instead of Ctrl, Shortcuts using Cmd/Super instead of Ctrl, Line/Text Start and End using Cmd+Arrows instead of Home/End, Double click selects by word instead of selecting whole text, Multi-selection in lists uses Cmd/Super instead of Ctrl.
    config_input_trickle_event_queue:          bool; // = true           // Enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
    config_input_text_cursor_blink:            bool; // = true           // Enable blinking cursor (optional as some users consider it to be distracting).
    config_input_text_enter_keep_active:       bool; // = false          // [BETA] Pressing Enter will reactivate item and select all text (single-line only). Ctrl+Enter or Shift+Enter will deactivate normally.
    config_color_edit_flags:                   Color_Edit_Flags; // = <defaults>     // Current settings for ColorEdit/ColorPicker widgets. Must have one bit of ImGuiColorEditFlags_DisplayMask_, one bit of ImGuiColorEditFlags_DataTypeMask_, one bit of ImGuiColorEditFlags_PickerMask_, one bit of ImGuiColorEditFlags_InputMask_. Defaults to ImGuiColorEditFlags_DefaultOptions_. May be further edited by users, unless you also set ImGuiColorEditFlags_NoOptions.
    config_drag_click_to_input_text:           bool; // = false          // [BETA] Enable turning DragXXX widgets into text input with a simple mouse click-release (without moving). Not desirable on devices without a keyboard.
    config_windows_resize_from_edges:          bool; // = true           // Enable resizing of windows from their edges and from the lower-left corner. This requires ImGuiBackendFlags_HasMouseCursors for better mouse cursor feedback. (This used to be a per-window ImGuiWindowFlags_ResizeFromAnySide flag)
    config_windows_move_from_title_bar_only:   bool; // = false      // Enable allowing to move windows only when clicking on their title bar. Does not apply to windows without a title bar.
    config_windows_copy_contents_with_ctrl_c:  bool; // = false      // [EXPERIMENTAL] Ctrl+C copy the contents of focused window into the clipboard. Experimental because: (1) has known issues with nested Begin/End pairs (2) text output quality varies (3) text output is in submission order rather than spatial order.
    config_scrollbar_scroll_by_page:           bool; // = true           // Enable scrolling page by page when clicking outside the scrollbar grab. When disabled, always scroll to clicked location. When enabled, Shift+Click scrolls to clicked location.

    config_ini_settings_save_last_used_date:  bool; // = true         // Enable loading/saving last used day (YYYYMMDD) in some .ini struct, making things easier to audit and allowing custom tools to cleanup old data.
    config_ini_settings_auto_discard_months:  s32; // = 0          // [BETA] Set number of months after which unused .ini entries are discarded on load. Require platform_io.Platform_SessionDate to be set. For systems supporting the feature, .ini entries without a LastUsed field will always be discarded! Please report if you are using this.
    config_debug_ini_settings:                bool; // = false          // Save .ini data with extra comments (particularly helpful for Docking, but makes saving slower)

    mouse_draw_cursor:           bool; // = false          // Request ImGui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). Cannot be easily renamed to 'io.ConfigXXX' because this is frequently used by backend implementations.
    config_memory_compact_timer: float; // = 60.0f          // Timer (in seconds) to free transient windows/tables memory buffers when unused. Set to -1.0f to disable.

    mouse_double_click_time:     float; // = 0.30f          // Time for consecutive clicks to account as a double-click, in seconds.
    mouse_double_click_max_dist: float; // = 6.0f           // Distance threshold to stay in to validate a double-click or multiple clicks, in pixels.
    mouse_single_click_delay:    float; // = 0.60f          // Time for a delayed click when using GetItemClickedCountWithSingleClickDelay() or IsMouseReleasedWithDelay(), in seconds. Must be > io.MouseDoubleClickTime.
    mouse_drag_threshold:        float; // = 6.0f           // Distance threshold before considering we are dragging.
    key_repeat_delay:            float; // = 0.275f         // When holding a key/button, time before it starts repeating, in seconds (for buttons in Repeat mode, etc.).
    key_repeat_rate:             float; // = 0.050f         // When holding a key/button, rate at which it repeats, in seconds.

    config_error_recovery:                  bool; // = true       // Enable error recovery support. Some errors won't be detected and lead to direct crashes if recovery is disabled.
    config_error_recovery_enable_assert:    bool; // = true       // Enable asserts on recoverable error. By default call IM_ASSERT() when returning from a failing IM_ASSERT_USER_ERROR()
    config_error_recovery_enable_debug_log: bool; // = true       // Enable debug log output on recoverable errors.
    config_error_recovery_enable_tooltip:   bool; // = true       // Enable tooltip on recoverable errors. The tooltip include a way to enable asserts if they were disabled.

    config_debug_is_debugger_present: bool; // = false // Enable various tools calling IM_DEBUG_BREAK().

    config_debug_highlight_id_conflicts:                  bool; // = true           // Highlight and show an error message popup when multiple items have conflicting identifiers.
    config_debug_highlight_id_conflicts_show_item_picker: bool; //=true // Show "Item Picker" button in aforementioned popup.

    config_debug_begin_return_value_once: bool; // = false          // First-time calls to Begin()/BeginChild() will return false. NEEDS TO BE SET AT APPLICATION BOOT TIME if you don't want to miss windows.
    config_debug_begin_return_value_loop: bool; // = false          // Some calls to Begin()/BeginChild() will return false. Will cycle through window depths then repeat. Suggested use: add "io.ConfigDebugBeginReturnValue = io.KeyShift" in your main loop then occasionally press SHIFT. Windows should be flickering while running.

    config_debug_ignore_focus_loss: bool; // = false // Ignore io.AddFocusEvent(false), consequently not calling io.ClearInputKeys()/io.ClearInputMouse() in input processing.

    config_debug_draw_list_defaults_to_stroke_legacy: bool; // false // Default all ImDrawList to ImDrawFlags_StrokeLegacy mode, mimicking pre-1.93.0 rendering.

    backend_platform_name:      *u8;   // = NULL
    backend_renderer_name:      *u8;   // = NULL
    backend_platform_user_data: *void; // = NULL // User data for platform backend
    backend_renderer_user_data: *void; // = NULL // User data for renderer backend
    backend_language_user_data: *void; // = NULL // User data for non      C++ programming language backend

    // Input Functions
    add_key_event :: (this: *IO, key: Key, down: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO11AddKeyEventE8ImGuiKeyb";
    add_key_analog_event :: (this: *IO, key: Key, down: bool, v: float) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO17AddKeyAnalogEventE8ImGuiKeybf";
    add_mouse_pos_event :: (this: *IO, x: float, y: float) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO16AddMousePosEventEff";
    add_mouse_button_event :: (this: *IO, button: s32, down: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO19AddMouseButtonEventEib";
    add_mouse_wheel_event :: (this: *IO, wheel_x: float, wheel_y: float) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO18AddMouseWheelEventEff";
    add_mouse_source_event :: (this: *IO, source: Mouse_Source) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO19AddMouseSourceEventE16ImGuiMouseSource";
    add_focus_event :: (this: *IO, focused: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO13AddFocusEventEb";
    add_input_character :: (this: *IO, c: u32) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO17AddInputCharacterEj";
    add_input_character_u_t_f16 :: (this: *IO, c: Wchar16) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO22AddInputCharacterUTF16Et";
    add_input_characters_u_t_f8 :: (this: *IO, str: *u8) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO22AddInputCharactersUTF8EPKc";

    set_key_event_native_data :: (this: *IO, key: Key, native_keycode: s32, native_scancode: s32, native_legacy_index: s32 = -1) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO21SetKeyEventNativeDataE8ImGuiKeyiii";
    set_app_accepting_events :: (this: *IO, accepting_events: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO21SetAppAcceptingEventsEb";
    clear_events_queue :: (this: *IO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO16ClearEventsQueueEv";
    clear_input_keys :: (this: *IO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO14ClearInputKeysEv";
    clear_input_mouse :: (this: *IO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO15ClearInputMouseEv";

    want_capture_mouse:      bool; // Set when Dear ImGui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
    want_capture_keyboard:   bool; // Set when Dear ImGui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. InputText active, or an imgui window is focused and navigation is enabled, etc.).
    want_text_input:         bool; // Mobile/console: when set, you may display an on-screen keyboard. This is set by Dear ImGui when it wants textual keyboard input to happen (e.g. when a InputText widget is active).
    want_set_mouse_pos:      bool; // MousePos has been altered, backend should reposition mouse on next frame. Rarely used! Set only when io.ConfigNavMoveSetMousePos is enabled.
    want_save_ini_settings:  bool; // When manual .ini load/save is active (io.IniFilename == NULL), this will be set to notify your application that you can call SaveIniSettingsToMemory() and save yourself. Important: clear io.WantSaveIniSettings yourself after saving!
    nav_active:              bool; // Keyboard/Gamepad navigation is currently allowed (will handle ImGuiKey_NavXXX events) = a window is focused and it doesn't use the ImGuiWindowFlags_NoNavInputs flag.
    nav_visible:             bool; // Keyboard/Gamepad navigation highlight is visible and allowed (will handle ImGuiKey_NavXXX events).
    framerate:               float; // Estimate of application framerate (rolling average over 60 frames, based on io.DeltaTime), in frame per second. Solely for convenience. Slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
    metrics_render_vertices: s32; // Vertices output during last call to Render()
    metrics_render_indices:  s32; // Indices output during last call to Render() = number of triangles * 3
    metrics_render_windows:  s32; // Number of visible windows
    metrics_active_windows:  s32; // Number of active windows
    mouse_delta:             Vector2; // Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.

    Ctx: *Context; // Parent UI context (needs to be set explicitly by parent).

    mouse_pos:     Vector2; // Mouse position, in pixels. Set to ImVec2(-FLT_MAX, -FLT_MAX) if mouse is unavailable (on another screen, etc.)
    mouse_down:    [5]bool; // Mouse buttons: 0=left, 1=right, 2=middle + extras (ImGuiMouseButton_COUNT == 5). Dear ImGui mostly uses left and right buttons. Other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via IsMouse** API.
    mouse_wheel:   float; // Mouse wheel Vertical: 1 unit scrolls about 5 lines text. >0 scrolls Up, <0 scrolls Down. Hold Shift to turn vertical scroll into horizontal scroll.
    mouse_wheel_h: float; // Mouse wheel Horizontal. >0 scrolls Left, <0 scrolls Right. Most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
    mouse_source:  Mouse_Source; // Mouse actual input peripheral (Mouse/TouchScreen/Pen).
    key_ctrl:      bool; // Keyboard modifier down: Ctrl (non-macOS), Cmd (macOS)
    key_shift:     bool; // Keyboard modifier down: Shift
    key_alt:       bool; // Keyboard modifier down: Alt
    key_super:     bool; // Keyboard modifier down: Windows/Super (non-macOS), Ctrl (macOS)

    key_mods:                              Key_Chord; // Key mods flags (any of ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Alt/ImGuiMod_Super flags, same as io.KeyCtrl/KeyShift/KeyAlt/KeySuper but merged into flags). Read-only, updated by NewFrame()
    keys_data:                             [155]Key_Data; // Key state for all known keys. MUST use 'key - ImGuiKey_NamedKey_BEGIN' as index. Use IsKeyXXX() functions to access this.
    want_capture_mouse_unless_popup_close: bool; // Alternative to WantCaptureMouse: (WantCaptureMouse == true && WantCaptureMouseUnlessPopupClose == false) when a click over void is expected to close a popup.
    mouse_pos_prev:                        Vector2; // Previous mouse position (note that MouseDelta is not necessary == MousePos-MousePosPrev, in case either position is invalid)
    mouse_clicked_pos:                     [5]Vector2; // Position at time of clicking
    mouse_clicked_time:                    [5]float64; // Time of last click (used to figure out double-click)
    mouse_clicked:                         [5]bool; // Mouse button went from !Down to Down (same as MouseClickedCount[x] != 0)
    mouse_double_clicked:                  [5]bool; // Has mouse button been double-clicked? (same as MouseClickedCount[x] == 2)
    mouse_clicked_count:                   [5]U16; // == 0 (not clicked), == 1 (same as MouseClicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !Down to Down
    mouse_clicked_last_count:              [5]U16; // Count successive number of clicks. Stays valid after mouse release. Reset after another click is done.
    mouse_released:                        [5]bool; // Mouse button went from Down to !Down
    mouse_released_time:                   [5]float64; // Time of last released (rarely used! but useful to handle delayed single-click when trying to disambiguate them from double-click).
    mouse_down_owned:                      [5]bool; // Track if button was clicked inside a dear imgui window or over void blocked by a popup. We don't request mouse capture from the application if click started outside ImGui bounds.
    mouse_down_owned_unless_popup_close:   [5]bool; // Track if button was clicked inside a dear imgui window.
    mouse_wheel_request_axis_swap:         bool; // On a non-Mac system, holding Shift requests WheelY to perform the equivalent of a WheelX event. On a Mac system this is already enforced by the system.
    mouse_ctrl_left_as_right_click:        bool; // (OSX) Set to true when the current click was a Ctrl+Click that spawned a simulated right click
    mouse_down_duration:                   [5]float; // Duration the mouse button has been down (0.0f == just clicked)
    mouse_down_duration_prev:              [5]float; // Previous time the mouse button has been down
    mouse_drag_max_distance_sqr:           [5]float; // Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
    pen_pressure:                          float; // Touch/Pen pressure (0.0f to 1.0f, should be >0.0f only when MouseDown[0] == true). Helper storage currently unused by Dear ImGui.
    app_focus_lost:                        bool; // Only modify via AddFocusEvent()
    app_accepting_events:                  bool; // Only modify via SetAppAcceptingEvents()
    input_queue_surrogate:                 Wchar16; // For AddInputCharacterUTF16()
    input_queue_characters:                Vector(Wchar); // Queue of _characters_ input (obtained by platform backend). Fill using AddInputCharacter() helper.

    font_global_scale: float; // Moved io.FontGlobalScale to style.FontScaleMain in 1.92.0 (June 2025)

    constructor :: (this: *IO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIOC1Ev";
}

Font_Atlas :: struct {} // @Todo

Font :: struct {} // @Todo

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

Key_Data :: struct {
    down:               bool; // True for if key is down
    down_duration:      float; // Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
    down_duration_prev: float; // Last frame duration the key has been down
    analog_value:       float; // 0.0f..1.0f for gamepad values
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

Mouse_Source :: enum s32 {
    MOUSE        :: 0;
    TOUCH_SCREEN :: 1;
    PEN          :: 2;
    COUNT        :: 3;
}

Key :: enum s32 {
    NONE            :: 0;
    NAMED_KEY_BEGIN :: 512;

    TAB             :: 512;
    LEFT_ARROW      :: 513;
    RIGHT_ARROW     :: 514;
    UP_ARROW        :: 515;
    DOWN_ARROW      :: 516;
    PAGE_UP         :: 517;
    PAGE_DOWN       :: 518;
    HOME            :: 519;
    END             :: 520;
    INSERT          :: 521;
    DELETE          :: 522;
    BACKSPACE       :: 523;
    SPACE           :: 524;
    ENTER           :: 525;
    ESCAPE          :: 526;
    LEFT_CTRL       :: 527;
    LEFT_SHIFT      :: 528;
    LEFT_ALT        :: 529;
    LEFT_SUPER      :: 530;
    RIGHT_CTRL      :: 531;
    RIGHT_SHIFT     :: 532;
    RIGHT_ALT       :: 533;
    RIGHT_SUPER     :: 534;
    MENU            :: 535;
    _0              :: 536;
    _1              :: 537;
    _2              :: 538;
    _3              :: 539;
    _4              :: 540;
    _5              :: 541;
    _6              :: 542;
    _7              :: 543;
    _8              :: 544;
    _9              :: 545;
    A               :: 546;
    B               :: 547;
    C               :: 548;
    D               :: 549;
    E               :: 550;
    F               :: 551;
    G               :: 552;
    H               :: 553;
    I               :: 554;
    J               :: 555;
    K               :: 556;
    L               :: 557;
    M               :: 558;
    N               :: 559;
    O               :: 560;
    P               :: 561;
    Q               :: 562;
    R               :: 563;
    S               :: 564;
    T               :: 565;
    U               :: 566;
    V               :: 567;
    W               :: 568;
    X               :: 569;
    Y               :: 570;
    Z               :: 571;
    F1              :: 572;
    F2              :: 573;
    F3              :: 574;
    F4              :: 575;
    F5              :: 576;
    F6              :: 577;
    F7              :: 578;
    F8              :: 579;
    F9              :: 580;
    F10             :: 581;
    F11             :: 582;
    F12             :: 583;
    F13             :: 584;
    F14             :: 585;
    F15             :: 586;
    F16             :: 587;
    F17             :: 588;
    F18             :: 589;
    F19             :: 590;
    F20             :: 591;
    F21             :: 592;
    F22             :: 593;
    F23             :: 594;
    F24             :: 595;
    APOSTROPHE      :: 596;
    COMMA           :: 597;
    MINUS           :: 598;
    PERIOD          :: 599;
    SLASH           :: 600;
    SEMICOLON       :: 601;
    EQUAL           :: 602;
    LEFT_BRACKET    :: 603;
    BACKSLASH       :: 604;
    RIGHT_BRACKET   :: 605;
    GRAVE_ACCENT    :: 606;
    CAPS_LOCK       :: 607;
    SCROLL_LOCK     :: 608;
    NUM_LOCK        :: 609;
    PRINT_SCREEN    :: 610;
    PAUSE           :: 611;
    KEYPAD0         :: 612;
    KEYPAD1         :: 613;
    KEYPAD2         :: 614;
    KEYPAD3         :: 615;
    KEYPAD4         :: 616;
    KEYPAD5         :: 617;
    KEYPAD6         :: 618;
    KEYPAD7         :: 619;
    KEYPAD8         :: 620;
    KEYPAD9         :: 621;
    KEYPAD_DECIMAL  :: 622;
    KEYPAD_DIVIDE   :: 623;
    KEYPAD_MULTIPLY :: 624;
    KEYPAD_SUBTRACT :: 625;
    KEYPAD_ADD      :: 626;
    KEYPAD_ENTER    :: 627;
    KEYPAD_EQUAL    :: 628;
    APP_BACK        :: 629;
    APP_FORWARD     :: 630;
    OEM102          :: 631;

    GAMEPAD_START         :: 632;
    GAMEPAD_BACK          :: 633;
    GAMEPAD_FACE_LEFT     :: 634;
    GAMEPAD_FACE_RIGHT    :: 635;
    GAMEPAD_FACE_UP       :: 636;
    GAMEPAD_FACE_DOWN     :: 637;
    GAMEPAD_DPAD_LEFT     :: 638;
    GAMEPAD_DPAD_RIGHT    :: 639;
    GAMEPAD_DPAD_UP       :: 640;
    GAMEPAD_DPAD_DOWN     :: 641;
    GAMEPAD_L1            :: 642;
    GAMEPAD_R1            :: 643;
    GAMEPAD_L2            :: 644;
    GAMEPAD_R2            :: 645;
    GAMEPAD_L3            :: 646;
    GAMEPAD_R3            :: 647;
    GAMEPAD_L_STICK_LEFT  :: 648;
    GAMEPAD_L_STICK_RIGHT :: 649;
    GAMEPAD_L_STICK_UP    :: 650;
    GAMEPAD_L_STICK_DOWN  :: 651;
    GAMEPAD_R_STICK_LEFT  :: 652;
    GAMEPAD_R_STICK_RIGHT :: 653;
    GAMEPAD_R_STICK_UP    :: 654;
    GAMEPAD_R_STICK_DOWN  :: 655;

    MOUSE_LEFT    :: 656;
    MOUSE_RIGHT   :: 657;
    MOUSE_MIDDLE  :: 658;
    MOUSE_X1      :: 659;
    MOUSE_X2      :: 660;
    MOUSE_WHEEL_X :: 661;
    MOUSE_WHEEL_Y :: 662;

    RESERVED_FOR_MOD_CTRL  :: 663;
    RESERVED_FOR_MOD_SHIFT :: 664;
    RESERVED_FOR_MOD_ALT   :: 665;
    RESERVED_FOR_MOD_SUPER :: 666;

    NAMED_KEY_END       :: 667;
    NAMED_KEY_C_O_U_N_T :: 155;

    MOD_NONE  :: 0;
    MOD_CTRL  :: 4096;
    MOD_SHIFT :: 8192;
    MOD_ALT   :: 16384;
    MOD_SUPER :: 32768;
    MOD_MASK  :: 61440;

    COUNT :: 667;
}

Config_Flags :: enum_flags u32 {
    NONE                   :: 0x0;
    NAV_ENABLE_KEYBOARD    :: 0x1;
    NAV_ENABLE_GAMEPAD     :: 0x2;
    NO_MOUSE               :: 0x10;
    NO_MOUSE_CURSOR_CHANGE :: 0x20;
    NO_KEYBOARD            :: 0x40;

    IS_SRGB         :: 0x100000;
    IS_TOUCH_SCREEN :: 0x200000;

    NAV_ENABLE_SET_MOUSE_POS :: 0x4;
    NAV_NO_CAPTURE_KEYBOARD  :: 0x8;
}

Color_Edit_Flags :: enum_flags u32 {
    NONE             :: 0x0;
    NO_ALPHA         :: 0x2;
    NO_PICKER        :: 0x4;
    NO_OPTIONS       :: 0x8;
    NO_SMALL_PREVIEW :: 0x10;
    NO_INPUTS        :: 0x20;
    NO_TOOLTIP       :: 0x40;
    NO_LABEL         :: 0x80;
    NO_SIDE_PREVIEW  :: 0x100;
    NO_DRAG_DROP     :: 0x200;
    NO_BORDER        :: 0x400;
    NO_COLOR_MARKERS :: 0x800;

    ALPHA_OPAQUE       :: 0x1000;
    ALPHA_NO_BG        :: 0x2000;
    ALPHA_PREVIEW_HALF :: 0x4000;

    ALPHA_BAR        :: 0x40000;
    HDR              :: 0x80000;
    DISPLAY_RGB      :: 0x100000;
    DISPLAY_HSV      :: 0x200000;
    DISPLAY_HEX      :: 0x400000;
    UINT8            :: 0x800000;
    FLOAT            :: 0x1000000;
    PICKER_HUE_BAR   :: 0x2000000;
    PICKER_HUE_WHEEL :: 0x4000000;
    PICKER_NO_ROTATE :: 0x8000000;
    INPUT_R_G_B      :: 0x10000000;
    INPUT_H_S_V      :: 0x20000000;

    DEFAULT_OPTIONS :: 0x12900000;

    ALPHA_MASK     :: 0x7002;
    DISPLAY_MASK   :: 0x700000;
    DATA_TYPE_MASK :: 0x1800000;
    PICKER_MASK    :: 0x6000000;
    INPUT_MASK     :: 0x30000000;

    ALPHA_PREVIEW :: 0x0;
}

Backend_Flags :: enum_flags u32 {
    NONE                    :: 0x0;
    HAS_GAMEPAD             :: 0x1;
    HAS_MOUSE_CURSORS       :: 0x2;
    HAS_SET_MOUSE_POS       :: 0x4;
    RENDERER_HAS_VTX_OFFSET :: 0x8;
    RENDERER_HAS_TEXTURES   :: 0x10;
}

Tree_Node_Flags :: enum_flags u32 {
    NONE                   :: 0x0;
    SELECTED               :: 0x1;
    FRAMED                 :: 0x2;
    ALLOW_OVERLAP          :: 0x4;
    NO_TREE_PUSH_ON_OPEN   :: 0x8;
    NO_AUTO_OPEN_ON_LOG    :: 0x10;
    DEFAULT_OPEN           :: 0x20;
    OPEN_ON_DOUBLE_CLICK   :: 0x40;
    OPEN_ON_ARROW          :: 0x80;
    LEAF                   :: 0x100;
    BULLET                 :: 0x200;
    FRAME_PADDING          :: 0x400;
    SPAN_AVAIL_WIDTH       :: 0x800;
    SPAN_FULL_WIDTH        :: 0x1000;
    SPAN_LABEL_WIDTH       :: 0x2000;
    SPAN_ALL_COLUMNS       :: 0x4000;
    LABEL_SPAN_ALL_COLUMNS :: 0x8000;

    NAV_LEFT_JUMPS_TO_PARENT :: 0x20000;
    COLLAPSING_HEADER        :: 0x1a;

    DRAW_LINES_NONE     :: 0X40000;
    DRAW_LINES_FULL     :: 0x80000;
    DRAW_LINES_TO_NODES :: 0x100000;

    NAV_LEFT_JUMPS_BACK_HERE :: 0X20000;
}

Slider_Flags :: enum_flags u32 {
    NONE               :: 0x0;
    LOGARITHMIC        :: 0x20;
    NO_ROUND_TO_FORMAT :: 0x40;
    NO_INPUT           :: 0x80;
    WRAP_AROUND        :: 0x100;
    CLAMP_ON_INPUT     :: 0x200;
    CLAMP_ZERO_RANGE   :: 0x400;
    NO_SPEED_TWEAKS    :: 0x800;
    COLOR_MARKERS      :: 0x1000;
    ALWAYS_CLAMP       :: 0x600;

    INVALID_MASK       :: 0x7000000f;
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
    text_c_format("%s", formatted_text.data);
} @PrintLike

text_c_format :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui4TextEPKcz";

get_draw_data :: () -> *Draw_Data #foreign libimgui "_ZN5ImGui11GetDrawDataEv";

collapsing_header :: (
    label: *u8,
    flags: Tree_Node_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui16CollapsingHeaderEPKci";

collapsing_header :: (
    label: *u8,
    p_visible: *bool,
    flags: Tree_Node_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui16CollapsingHeaderEPKcPbi";

drag_float :: (
    label: *u8,
    v: *float,
    v_speed: float = 1.0,
    v_min: float = 0.0,
    v_max: float = 0.0,
    format: *u8 = "%.3f",
    flags: Slider_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui9DragFloatEPKcPffffS1_i";

drag_float3 :: (
    label: *u8,
    v: *[3] float,
    v_speed: float = 1.0,
    v_min: float = 0.0,
    v_max: float = 0.0,
    format: *u8 = "%.3f",
    flags: Slider_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui10DragFloat3EPKcPffffS1_i";

drag_float4 :: (
    label: *u8,
    v: *[4] float,
    v_speed: float = 1.0,
    v_min: float = 0.0,
    v_max: float = 0.0,
    format: *u8 = "%.3f",
    flags: Slider_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui10DragFloat4EPKcPffffS1_i";

combo :: (
    label: *u8,
    current_item: *s32,
    items: **u8,
    items_count: s32,
    popup_max_height_in_items: s32 = -1,
) -> bool #foreign libimgui "_ZN5ImGui5ComboEPKcPiPKS1_ii";

combo :: (
    label: *u8,
    current_item: *s32,
    items_separated_by_zeros: *u8,
    popup_max_height_in_items: s32 = -1,
) -> bool #foreign libimgui "_ZN5ImGui5ComboEPKcPiS1_i";

combo :: (
    label: *u8,
    current_item: *s32,
    getter: #type (user_data: *void, idx: s32) -> *u8 #c_call,
    user_data: *void,
    items_count: s32,
    popup_max_height_in_items: s32 = -1,
) -> bool #foreign libimgui "_ZN5ImGui5ComboEPKcPiPFS1_PviES3_ii";

separator_text :: (label: *u8) -> void #foreign libimgui "_ZN5ImGui13SeparatorTextEPKc";

color_edit3 :: (
    label: *u8,
    col: *[3] float,
    flags: Color_Edit_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui10ColorEdit3EPKcPfi";

color_picker3 :: (
    label: *u8,
    col: *[3] float,
    flags: Color_Edit_Flags = .NONE,
) -> bool #foreign libimgui "_ZN5ImGui12ColorPicker3EPKcPfi";

color_picker4 :: (
    label: *u8,
    col: *[4] float,
    flags: Color_Edit_Flags = .NONE,
    ref_col: *float = null,
) -> bool #foreign libimgui "_ZN5ImGui12ColorPicker4EPKcPfiPKf";

button :: (label: *u8, size: *Vector2) -> bool #foreign libimgui "_ZN5ImGui6ButtonEPKcRK6ImVec2";

button :: inline (label: *u8, size: Vector2 = {}) -> bool {
    return button(label, *size);
}

set_next_item_open :: (is_open: bool, cond: Condition = .NONE) -> void #foreign libimgui "_ZN5ImGui15SetNextItemOpenEbi";

is_item_toggled_selection :: () -> bool #foreign libimgui "_ZN5ImGui22IsItemToggledSelectionEv";

same_line :: (
    offset_from_start_x: float = 0.0,
    spacing: float = -1.0,
) -> void #foreign libimgui "_ZN5ImGui8SameLineEff";

push_item_width :: (item_width: float) -> void #foreign libimgui "_ZN5ImGui13PushItemWidthEf";

show_demo_window :: (p_open: *bool = null) -> void #foreign libimgui "_ZN5ImGui14ShowDemoWindowEPb";

#if OS == .LINUX {
    libimgui :: #library,no_dll "./LINUX/libimgui";
} else #if OS == .MACOS {
    libimgui :: #library,no_dll "./MACOS/libimgui";
} else #if OS == .WINDOWS {
    libimgui :: #library,no_dll "./WINDOWS/libimgui";
}



#scope_file

#import "Basic";
#import "Math";
