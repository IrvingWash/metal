//
// This file was auto-generated using the following command:
//
// jai ./modules/Dear_ImGui/generate.jai
//



IMGUI_VERSION :: "1.93.1 WIP";
IMGUI_VERSION_NUM :: 19302;

ImTextureID_Invalid :: cast(ImTextureID) 0;

IMGUI_PAYLOAD_TYPE_COLOR_3F :: "_COL3F";
IMGUI_PAYLOAD_TYPE_COLOR_4F :: "_COL4F";

IM_UNICODE_CODEPOINT_INVALID :: 0xFFFD;

IM_UNICODE_CODEPOINT_MAX :: 0xFFFF;

IM_COL32_R_SHIFT :: 0;
IM_COL32_G_SHIFT :: 8;
IM_COL32_B_SHIFT :: 16;
IM_COL32_A_SHIFT :: 24;
IM_COL32_A_MASK :: 0xFF000000;

ImFontAtlasRectId_Invalid :: -1;

ImDrawCallback_ResetRenderState :: cast(ImDrawCallback) (-8);

// Scalar data types
ImGuiID :: u32;
ImS8 :: s8;
ImU8 :: u8;
ImS16 :: s16;
ImU16 :: u16;
ImS32 :: s32;
ImU32 :: u32;
ImS64 :: s64;
ImU64 :: u64;

ImDrawListSharedData :: struct {}

ImFontAtlasBuilder :: struct {}

ImFontLoader :: struct {}

// Forward declarations: ImGui layer
ImGuiContext :: struct {}

// Enumerations
// - We don't use strongly typed enums much because they add constraints (can't extend in private code, can't store typed in bit fields, extra casting on iteration)
// - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
//   - In Visual Studio: Ctrl+Comma ("Edit.GoToAll") can follow symbols inside comments, whereas Ctrl+F12 ("Edit.GoToImplementation") cannot.
//   - In Visual Studio w/ Visual Assist installed: Alt+G ("VAssistX.GoToImplementation") can also follow symbols inside comments.
//   - In VS Code, CLion, etc.: Ctrl+Click can follow symbols inside comments.
ImGuiDir :: enum s32 {
    None  :: -1;
    Left  :: 0;
    Right :: 1;
    Up    :: 2;
    Down  :: 3;
    COUNT :: 4;

    ImGuiDir_None  :: None;
    ImGuiDir_Left  :: Left;
    ImGuiDir_Right :: Right;
    ImGuiDir_Up    :: Up;
    ImGuiDir_Down  :: Down;
    ImGuiDir_COUNT :: COUNT;
}

// A key identifier (ImGuiKey_XXX or ImGuiMod_XXX value): can represent Keyboard, Mouse and Gamepad values.
// All our named keys are >= 512. Keys value 0 to 511 are left unused and were legacy native/opaque key values (< 1.87).
// Support for legacy keys was completely removed in 1.91.5.
// Read details about the 1.87+ transition : https://github.com/ocornut/imgui/issues/4921
// Note that "Keys" related to physical keys and are not the same concept as input "Characters", the latter are submitted via io.AddInputCharacter().
// The keyboard key enum values are named after the keys on a standard US keyboard, and on other keyboard types the keys reported may not match the keycaps.
ImGuiKey :: enum s32 {
    None                :: 0;
    NamedKey_BEGIN      :: 512;

    Tab                 :: 512;
    LeftArrow           :: 513;
    RightArrow          :: 514;
    UpArrow             :: 515;
    DownArrow           :: 516;
    PageUp              :: 517;
    PageDown            :: 518;
    Home                :: 519;
    End                 :: 520;
    Insert              :: 521;
    Delete              :: 522;
    Backspace           :: 523;
    Space               :: 524;
    Enter               :: 525;
    Escape              :: 526;
    LeftCtrl            :: 527;
    LeftShift           :: 528;
    LeftAlt             :: 529;
    LeftSuper           :: 530;
    RightCtrl           :: 531;
    RightShift          :: 532;
    RightAlt            :: 533;
    RightSuper          :: 534;
    Menu                :: 535;
    _0                  :: 536;
    _1                  :: 537;
    _2                  :: 538;
    _3                  :: 539;
    _4                  :: 540;
    _5                  :: 541;
    _6                  :: 542;
    _7                  :: 543;
    _8                  :: 544;
    _9                  :: 545;
    A                   :: 546;
    B                   :: 547;
    C                   :: 548;
    D                   :: 549;
    E                   :: 550;
    F                   :: 551;
    G                   :: 552;
    H                   :: 553;
    I                   :: 554;
    J                   :: 555;
    K                   :: 556;
    L                   :: 557;
    M                   :: 558;
    N                   :: 559;
    O                   :: 560;
    P                   :: 561;
    Q                   :: 562;
    R                   :: 563;
    S                   :: 564;
    T                   :: 565;
    U                   :: 566;
    V                   :: 567;
    W                   :: 568;
    X                   :: 569;
    Y                   :: 570;
    Z                   :: 571;
    F1                  :: 572;
    F2                  :: 573;
    F3                  :: 574;
    F4                  :: 575;
    F5                  :: 576;
    F6                  :: 577;
    F7                  :: 578;
    F8                  :: 579;
    F9                  :: 580;
    F10                 :: 581;
    F11                 :: 582;
    F12                 :: 583;
    F13                 :: 584;
    F14                 :: 585;
    F15                 :: 586;
    F16                 :: 587;
    F17                 :: 588;
    F18                 :: 589;
    F19                 :: 590;
    F20                 :: 591;
    F21                 :: 592;
    F22                 :: 593;
    F23                 :: 594;
    F24                 :: 595;
    Apostrophe          :: 596;
    Comma               :: 597;
    Minus               :: 598;
    Period              :: 599;
    Slash               :: 600;
    Semicolon           :: 601;
    Equal               :: 602;
    LeftBracket         :: 603;
    Backslash           :: 604;
    RightBracket        :: 605;
    GraveAccent         :: 606;
    CapsLock            :: 607;
    ScrollLock          :: 608;
    NumLock             :: 609;
    PrintScreen         :: 610;
    Pause               :: 611;
    Keypad0             :: 612;
    Keypad1             :: 613;
    Keypad2             :: 614;
    Keypad3             :: 615;
    Keypad4             :: 616;
    Keypad5             :: 617;
    Keypad6             :: 618;
    Keypad7             :: 619;
    Keypad8             :: 620;
    Keypad9             :: 621;
    KeypadDecimal       :: 622;
    KeypadDivide        :: 623;
    KeypadMultiply      :: 624;
    KeypadSubtract      :: 625;
    KeypadAdd           :: 626;
    KeypadEnter         :: 627;
    KeypadEqual         :: 628;
    AppBack             :: 629;
    AppForward          :: 630;
    Oem102              :: 631;

    GamepadStart        :: 632;
    GamepadBack         :: 633;
    GamepadFaceLeft     :: 634;
    GamepadFaceRight    :: 635;
    GamepadFaceUp       :: 636;
    GamepadFaceDown     :: 637;
    GamepadDpadLeft     :: 638;
    GamepadDpadRight    :: 639;
    GamepadDpadUp       :: 640;
    GamepadDpadDown     :: 641;
    GamepadL1           :: 642;
    GamepadR1           :: 643;
    GamepadL2           :: 644;
    GamepadR2           :: 645;
    GamepadL3           :: 646;
    GamepadR3           :: 647;
    GamepadLStickLeft   :: 648;
    GamepadLStickRight  :: 649;
    GamepadLStickUp     :: 650;
    GamepadLStickDown   :: 651;
    GamepadRStickLeft   :: 652;
    GamepadRStickRight  :: 653;
    GamepadRStickUp     :: 654;
    GamepadRStickDown   :: 655;

    MouseLeft           :: 656;
    MouseRight          :: 657;
    MouseMiddle         :: 658;
    MouseX1             :: 659;
    MouseX2             :: 660;
    MouseWheelX         :: 661;
    MouseWheelY         :: 662;

    ReservedForModCtrl  :: 663;
    ReservedForModShift :: 664;
    ReservedForModAlt   :: 665;
    ReservedForModSuper :: 666;

    NamedKey_END        :: 667;
    NamedKey_COUNT      :: 155;

    ImGuiMod_None       :: 0;
    ImGuiMod_Ctrl       :: 4096;
    ImGuiMod_Shift      :: 8192;
    ImGuiMod_Alt        :: 16384;
    ImGuiMod_Super      :: 32768;
    ImGuiMod_Mask_      :: 61440;

    COUNT               :: 667;

    ImGuiKey_None                :: None;
    ImGuiKey_NamedKey_BEGIN      :: NamedKey_BEGIN;

    ImGuiKey_Tab                 :: Tab;
    ImGuiKey_LeftArrow           :: LeftArrow;
    ImGuiKey_RightArrow          :: RightArrow;
    ImGuiKey_UpArrow             :: UpArrow;
    ImGuiKey_DownArrow           :: DownArrow;
    ImGuiKey_PageUp              :: PageUp;
    ImGuiKey_PageDown            :: PageDown;
    ImGuiKey_Home                :: Home;
    ImGuiKey_End                 :: End;
    ImGuiKey_Insert              :: Insert;
    ImGuiKey_Delete              :: Delete;
    ImGuiKey_Backspace           :: Backspace;
    ImGuiKey_Space               :: Space;
    ImGuiKey_Enter               :: Enter;
    ImGuiKey_Escape              :: Escape;
    ImGuiKey_LeftCtrl            :: LeftCtrl;
    ImGuiKey_LeftShift           :: LeftShift;
    ImGuiKey_LeftAlt             :: LeftAlt;
    ImGuiKey_LeftSuper           :: LeftSuper;
    ImGuiKey_RightCtrl           :: RightCtrl;
    ImGuiKey_RightShift          :: RightShift;
    ImGuiKey_RightAlt            :: RightAlt;
    ImGuiKey_RightSuper          :: RightSuper;
    ImGuiKey_Menu                :: Menu;
    ImGuiKey_0                   :: _0;
    ImGuiKey_1                   :: _1;
    ImGuiKey_2                   :: _2;
    ImGuiKey_3                   :: _3;
    ImGuiKey_4                   :: _4;
    ImGuiKey_5                   :: _5;
    ImGuiKey_6                   :: _6;
    ImGuiKey_7                   :: _7;
    ImGuiKey_8                   :: _8;
    ImGuiKey_9                   :: _9;
    ImGuiKey_A                   :: A;
    ImGuiKey_B                   :: B;
    ImGuiKey_C                   :: C;
    ImGuiKey_D                   :: D;
    ImGuiKey_E                   :: E;
    ImGuiKey_F                   :: F;
    ImGuiKey_G                   :: G;
    ImGuiKey_H                   :: H;
    ImGuiKey_I                   :: I;
    ImGuiKey_J                   :: J;
    ImGuiKey_K                   :: K;
    ImGuiKey_L                   :: L;
    ImGuiKey_M                   :: M;
    ImGuiKey_N                   :: N;
    ImGuiKey_O                   :: O;
    ImGuiKey_P                   :: P;
    ImGuiKey_Q                   :: Q;
    ImGuiKey_R                   :: R;
    ImGuiKey_S                   :: S;
    ImGuiKey_T                   :: T;
    ImGuiKey_U                   :: U;
    ImGuiKey_V                   :: V;
    ImGuiKey_W                   :: W;
    ImGuiKey_X                   :: X;
    ImGuiKey_Y                   :: Y;
    ImGuiKey_Z                   :: Z;
    ImGuiKey_F1                  :: F1;
    ImGuiKey_F2                  :: F2;
    ImGuiKey_F3                  :: F3;
    ImGuiKey_F4                  :: F4;
    ImGuiKey_F5                  :: F5;
    ImGuiKey_F6                  :: F6;
    ImGuiKey_F7                  :: F7;
    ImGuiKey_F8                  :: F8;
    ImGuiKey_F9                  :: F9;
    ImGuiKey_F10                 :: F10;
    ImGuiKey_F11                 :: F11;
    ImGuiKey_F12                 :: F12;
    ImGuiKey_F13                 :: F13;
    ImGuiKey_F14                 :: F14;
    ImGuiKey_F15                 :: F15;
    ImGuiKey_F16                 :: F16;
    ImGuiKey_F17                 :: F17;
    ImGuiKey_F18                 :: F18;
    ImGuiKey_F19                 :: F19;
    ImGuiKey_F20                 :: F20;
    ImGuiKey_F21                 :: F21;
    ImGuiKey_F22                 :: F22;
    ImGuiKey_F23                 :: F23;
    ImGuiKey_F24                 :: F24;
    ImGuiKey_Apostrophe          :: Apostrophe;
    ImGuiKey_Comma               :: Comma;
    ImGuiKey_Minus               :: Minus;
    ImGuiKey_Period              :: Period;
    ImGuiKey_Slash               :: Slash;
    ImGuiKey_Semicolon           :: Semicolon;
    ImGuiKey_Equal               :: Equal;
    ImGuiKey_LeftBracket         :: LeftBracket;
    ImGuiKey_Backslash           :: Backslash;
    ImGuiKey_RightBracket        :: RightBracket;
    ImGuiKey_GraveAccent         :: GraveAccent;
    ImGuiKey_CapsLock            :: CapsLock;
    ImGuiKey_ScrollLock          :: ScrollLock;
    ImGuiKey_NumLock             :: NumLock;
    ImGuiKey_PrintScreen         :: PrintScreen;
    ImGuiKey_Pause               :: Pause;
    ImGuiKey_Keypad0             :: Keypad0;
    ImGuiKey_Keypad1             :: Keypad1;
    ImGuiKey_Keypad2             :: Keypad2;
    ImGuiKey_Keypad3             :: Keypad3;
    ImGuiKey_Keypad4             :: Keypad4;
    ImGuiKey_Keypad5             :: Keypad5;
    ImGuiKey_Keypad6             :: Keypad6;
    ImGuiKey_Keypad7             :: Keypad7;
    ImGuiKey_Keypad8             :: Keypad8;
    ImGuiKey_Keypad9             :: Keypad9;
    ImGuiKey_KeypadDecimal       :: KeypadDecimal;
    ImGuiKey_KeypadDivide        :: KeypadDivide;
    ImGuiKey_KeypadMultiply      :: KeypadMultiply;
    ImGuiKey_KeypadSubtract      :: KeypadSubtract;
    ImGuiKey_KeypadAdd           :: KeypadAdd;
    ImGuiKey_KeypadEnter         :: KeypadEnter;
    ImGuiKey_KeypadEqual         :: KeypadEqual;
    ImGuiKey_AppBack             :: AppBack;
    ImGuiKey_AppForward          :: AppForward;
    ImGuiKey_Oem102              :: Oem102;

    ImGuiKey_GamepadStart        :: GamepadStart;
    ImGuiKey_GamepadBack         :: GamepadBack;
    ImGuiKey_GamepadFaceLeft     :: GamepadFaceLeft;
    ImGuiKey_GamepadFaceRight    :: GamepadFaceRight;
    ImGuiKey_GamepadFaceUp       :: GamepadFaceUp;
    ImGuiKey_GamepadFaceDown     :: GamepadFaceDown;
    ImGuiKey_GamepadDpadLeft     :: GamepadDpadLeft;
    ImGuiKey_GamepadDpadRight    :: GamepadDpadRight;
    ImGuiKey_GamepadDpadUp       :: GamepadDpadUp;
    ImGuiKey_GamepadDpadDown     :: GamepadDpadDown;
    ImGuiKey_GamepadL1           :: GamepadL1;
    ImGuiKey_GamepadR1           :: GamepadR1;
    ImGuiKey_GamepadL2           :: GamepadL2;
    ImGuiKey_GamepadR2           :: GamepadR2;
    ImGuiKey_GamepadL3           :: GamepadL3;
    ImGuiKey_GamepadR3           :: GamepadR3;
    ImGuiKey_GamepadLStickLeft   :: GamepadLStickLeft;
    ImGuiKey_GamepadLStickRight  :: GamepadLStickRight;
    ImGuiKey_GamepadLStickUp     :: GamepadLStickUp;
    ImGuiKey_GamepadLStickDown   :: GamepadLStickDown;
    ImGuiKey_GamepadRStickLeft   :: GamepadRStickLeft;
    ImGuiKey_GamepadRStickRight  :: GamepadRStickRight;
    ImGuiKey_GamepadRStickUp     :: GamepadRStickUp;
    ImGuiKey_GamepadRStickDown   :: GamepadRStickDown;

    ImGuiKey_MouseLeft           :: MouseLeft;
    ImGuiKey_MouseRight          :: MouseRight;
    ImGuiKey_MouseMiddle         :: MouseMiddle;
    ImGuiKey_MouseX1             :: MouseX1;
    ImGuiKey_MouseX2             :: MouseX2;
    ImGuiKey_MouseWheelX         :: MouseWheelX;
    ImGuiKey_MouseWheelY         :: MouseWheelY;

    ImGuiKey_ReservedForModCtrl  :: ReservedForModCtrl;
    ImGuiKey_ReservedForModShift :: ReservedForModShift;
    ImGuiKey_ReservedForModAlt   :: ReservedForModAlt;
    ImGuiKey_ReservedForModSuper :: ReservedForModSuper;

    ImGuiKey_NamedKey_END        :: NamedKey_END;
    ImGuiKey_NamedKey_COUNT      :: NamedKey_COUNT;

    ImGuiKey_COUNT               :: COUNT;
}

// Enumeration for AddMouseSourceEvent() actual source of Mouse Input data.
// Historically we use "Mouse" terminology everywhere to indicate pointer data, e.g. MousePos, IsMousePressed(), io.AddMousePosEvent()
// But that "Mouse" data can come from different source which occasionally may be useful for application to know about.
// You can submit a change of pointer type using io.AddMouseSourceEvent().
ImGuiMouseSource :: enum s32 {
    Mouse       :: 0;
    TouchScreen :: 1;
    Pen         :: 2;
    COUNT       :: 3;

    ImGuiMouseSource_Mouse       :: Mouse;
    ImGuiMouseSource_TouchScreen :: TouchScreen;
    ImGuiMouseSource_Pen         :: Pen;
    ImGuiMouseSource_COUNT       :: COUNT;
}

// A sorting direction
ImGuiSortDirection :: enum ImU8 {
    None       :: 0;
    Ascending  :: 1;
    Descending :: 2;

    ImGuiSortDirection_None       :: None;
    ImGuiSortDirection_Ascending  :: Ascending;
    ImGuiSortDirection_Descending :: Descending;
}

ImGuiCol :: s32;
ImGuiCond :: s32;
ImGuiDataType :: s32;
ImGuiMouseButton :: s32;
ImGuiMouseCursor :: s32;
ImGuiStyleVar :: s32;
ImGuiTableBgTarget :: s32;

// Flags (declared as int to allow using as flags without overhead, and to not pollute the top of this file)
// - Tip: Use your programming IDE navigation facilities on the names in the _central column_ below to find the actual flags/enum lists!
//   - In Visual Studio: Ctrl+Comma ("Edit.GoToAll") can follow symbols inside comments, whereas Ctrl+F12 ("Edit.GoToImplementation") cannot.
//   - In Visual Studio w/ Visual Assist installed: Alt+G ("VAssistX.GoToImplementation") can also follow symbols inside comments.
//   - In VS Code, CLion, etc.: Ctrl+Click can follow symbols inside comments.
ImDrawFlags :: s32;
ImDrawTextFlags :: s32;
ImFontFlags :: s32;
ImFontAtlasFlags :: s32;
ImGuiBackendFlags :: s32;
ImGuiButtonFlags :: s32;
ImGuiChildFlags :: s32;
ImGuiColorEditFlags :: s32;
ImGuiConfigFlags :: s32;
ImGuiComboFlags :: s32;
ImGuiDragDropFlags :: s32;
ImGuiFocusedFlags :: s32;
ImGuiHoveredFlags :: s32;
ImGuiInputFlags :: s32;
ImGuiInputTextFlags :: s32;
ImGuiItemFlags :: s32;
ImGuiKeyChord :: s32;
ImGuiListClipperFlags :: s32;
ImGuiPopupFlags :: s32;
ImGuiMultiSelectFlags :: s32;
ImGuiSelectableFlags :: s32;
ImGuiSliderFlags :: s32;
ImGuiTabBarFlags :: s32;
ImGuiTabItemFlags :: s32;
ImGuiTableFlags :: s32;
ImGuiTableColumnFlags :: s32;
ImGuiTableRowFlags :: s32;
ImGuiTreeNodeFlags :: s32;
ImGuiViewportFlags :: s32;
ImGuiWindowFlags :: s32;

// Character types
// (we generally use UTF-8 encoded string in the API. This is storage specifically for a decoded character used for keyboard input and display)
ImWchar32 :: u32;
ImWchar16 :: u16;

ImWchar :: ImWchar16;

// Multi-Selection item index or identifier when using BeginMultiSelect()
// - Used by SetNextItemSelectionUserData() + and inside ImGuiMultiSelectIO structure.
// - Most users are likely to use this store an item INDEX but this may be used to store a POINTER/ID as well. Read comments near ImGuiMultiSelectIO for details.
ImGuiSelectionUserData :: ImS64;

// Callback and functions types
ImGuiInputTextCallback :: #type (data: *ImGuiInputTextCallbackData) -> s32 #c_call;
ImGuiSizeCallback :: #type (data: *ImGuiSizeCallbackData) -> void #c_call;
ImGuiMemAllocFunc :: #type (sz: u64, user_data: *void) -> *void #c_call;
ImGuiMemFreeFunc :: #type (ptr: *void, user_data: *void) -> void #c_call;

// ImVec2: 2D vector used to store positions, sizes etc. [Compile-time configurable type]
// - This is a frequently used type in the API. Consider using IM_VEC2_CLASS_EXTRA to create implicit cast from/to our preferred type.
// - Add '#define IMGUI_DEFINE_MATH_OPERATORS' before including this file (or in imconfig.h) to access courtesy maths operators for ImVec2 and ImVec4.
ImVec2 :: struct {
    x: float;
    y: float;
}

// ImVec4: 4D vector used to store clipping rectangles, colors etc. [Compile-time configurable type]
ImVec4 :: struct {
    x: float;
    y: float;
    z: float;
    w: float;
}

ImTextureID :: ImU64;

// ImTextureRef = higher-level identifier for a texture. Store a ImTextureID _or_ a ImTextureData*.
// The identifier is valid even before the texture has been uploaded to the GPU/graphics system.
// This is what gets passed to functions such as `ImGui::Image()`, `ImDrawList::AddImage()`.
// This is what gets stored in draw commands (`ImDrawCmd`) to identify a texture during rendering.
// - When a texture is created by user code (e.g. custom images), we directly store the low-level ImTextureID.
//   Because of this, when displaying your own texture you are likely to ever only manage ImTextureID values on your side.
// - When a texture is created by the backend, we stores a ImTextureData* which becomes an indirection
//   to extract the ImTextureID value during rendering, after texture upload has happened.
// - To create a ImTextureRef from a ImTextureData you can use ImTextureData::GetTexRef().
//   We intentionally do not provide an ImTextureRef constructor for this: we don't expect this
//   to be frequently useful to the end-user, and it would be erroneously called by many legacy code.
// - If you want to bind the current atlas when using custom rectangle, you can use io.Fonts->TexRef.
// - Binding generators for languages such as C (which don't have constructors), should provide a helper, e.g.
//      inline ImTextureRef ImTextureRefFromID(ImTextureID tex_id) { ImTextureRef tex_ref = { ._TexData = NULL, .TexID = tex_id }; return tex_ref; }
// In 1.92 we changed most drawing functions using ImTextureID to use ImTextureRef.
// We intentionally do not provide an implicit ImTextureRef -> ImTextureID cast operator because it is technically lossy to convert ImTextureRef to ImTextureID before rendering.
ImTextureRef :: struct {
    _TexData: *ImTextureData; //      A texture, generally owned by a ImFontAtlas. Will convert to ImTextureID during render loop, after texture has been uploaded.
    _TexID:   ImTextureID; // _OR_ Low-level backend texture identifier, if already uploaded or created by user/app. Generally provided to e.g. ImGui::Image() calls.
}

//-----------------------------------------------------------------------------
// [SECTION] Dear ImGui end-user API functions
// (Note that ImGui:: being a namespace, you can add extra ImGui:: functions in your own separate file. Please don't modify imgui source files!)
//-----------------------------------------------------------------------------
ImGui :: struct {
    // Context creation and access
    // - Each context create its own ImFontAtlas by default. You may instance one yourself and pass it to CreateContext() to share a font atlas between contexts.
    // - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    //   for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for details.
    CreateContext :: (shared_font_atlas: *ImFontAtlas = null) -> *ImGuiContext #foreign libimgui "_ZN5ImGui13CreateContextEP11ImFontAtlas";
    DestroyContext :: (ctx: *ImGuiContext = null) -> void #foreign libimgui "_ZN5ImGui14DestroyContextEP12ImGuiContext";
    GetCurrentContext :: () -> *ImGuiContext #foreign libimgui "_ZN5ImGui17GetCurrentContextEv";
    SetCurrentContext :: (ctx: *ImGuiContext) -> void #foreign libimgui "_ZN5ImGui17SetCurrentContextEP12ImGuiContext";

    // Main
    GetIO :: () -> *ImGuiIO #foreign libimgui "_ZN5ImGui5GetIOEv";
    GetPlatformIO :: () -> *ImGuiPlatformIO #foreign libimgui "_ZN5ImGui13GetPlatformIOEv";
    GetStyle :: () -> *ImGuiStyle #foreign libimgui "_ZN5ImGui8GetStyleEv";
    NewFrame :: () -> void #foreign libimgui "_ZN5ImGui8NewFrameEv";
    EndFrame :: () -> void #foreign libimgui "_ZN5ImGui8EndFrameEv";
    Render :: () -> void #foreign libimgui "_ZN5ImGui6RenderEv";
    GetDrawData :: () -> *ImDrawData #foreign libimgui "_ZN5ImGui11GetDrawDataEv";

    ShowMetricsWindow :: (p_open: *bool = null) -> void #foreign libimgui "_ZN5ImGui17ShowMetricsWindowEPb";
    ShowDebugLogWindow :: (p_open: *bool = null) -> void #foreign libimgui "_ZN5ImGui18ShowDebugLogWindowEPb";
    ShowIDStackToolWindow :: (p_open: *bool = null) -> void #foreign libimgui "_ZN5ImGui21ShowIDStackToolWindowEPb";

    ShowFontSelector :: (label: *u8) -> void #foreign libimgui "_ZN5ImGui16ShowFontSelectorEPKc";

    GetVersion :: () -> *u8 #foreign libimgui "_ZN5ImGui10GetVersionEv";

    // Styles
    StyleColorsDark :: (dst: *ImGuiStyle = null) -> void #foreign libimgui "_ZN5ImGui15StyleColorsDarkEP10ImGuiStyle";
    StyleColorsLight :: (dst: *ImGuiStyle = null) -> void #foreign libimgui "_ZN5ImGui16StyleColorsLightEP10ImGuiStyle";
    StyleColorsClassic :: (dst: *ImGuiStyle = null) -> void #foreign libimgui "_ZN5ImGui18StyleColorsClassicEP10ImGuiStyle";

    // Windows
    // - Begin() = push window to the stack and start appending to it. End() = pop window from the stack.
    // - Passing 'bool* p_open != NULL' shows a window-closing widget in the upper-right corner of the window,
    //   which clicking will set the boolean to false when clicked.
    // - You may append multiple times to the same window during the same frame by calling Begin()/End() pairs multiple times.
    //   Some information such as 'flags' or 'p_open' will only be considered by the first call to Begin().
    // - Begin() return false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
    //   anything to the window. Always call a matching End() for each Begin() call, regardless of its return value!
    //   [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
    //    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
    //    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    // - Note that the bottom of window stack always contains a window called "Debug".
    Begin :: (name: *u8, p_open: *bool = null, flags: ImGuiWindowFlags = 0) -> bool #foreign libimgui "_ZN5ImGui5BeginEPKcPbi";
    End :: () -> void #foreign libimgui "_ZN5ImGui3EndEv";

    // Child Windows
    // - Use child windows to begin into a self-contained independent scrolling/clipping regions within a host window. Child windows can embed their own child.
    // - Before 1.90 (November 2023), the "ImGuiChildFlags child_flags = 0" parameter was "bool border = false".
    //   This API is backward compatible with old code, as we guarantee that ImGuiChildFlags_Borders == true.
    //   Consider updating your old code:
    //      BeginChild("Name", size, false)   -> Begin("Name", size, 0); or Begin("Name", size, ImGuiChildFlags_None);
    //      BeginChild("Name", size, true)    -> Begin("Name", size, ImGuiChildFlags_Borders);
    // - Manual sizing (each axis can use a different setting e.g. ImVec2(0.0f, 400.0f)):
    //     == 0.0f: use remaining parent window size for this axis.
    //      > 0.0f: use specified size for this axis.
    //      < 0.0f: right/bottom-align to specified distance from available content boundaries.
    // - Specifying ImGuiChildFlags_AutoResizeX or ImGuiChildFlags_AutoResizeY makes the sizing automatic based on child contents.
    //   Combining both ImGuiChildFlags_AutoResizeX _and_ ImGuiChildFlags_AutoResizeY defeats purpose of a scrolling region and is NOT recommended.
    // - BeginChild() returns false to indicate the window is collapsed or fully clipped, so you may early out and omit submitting
    //   anything to the window. Always call a matching EndChild() for each BeginChild() call, regardless of its return value.
    //   [Important: due to legacy reason, Begin/End and BeginChild/EndChild are inconsistent with all other functions
    //    such as BeginMenu/EndMenu, BeginPopup/EndPopup, etc. where the EndXXX call should only be called if the corresponding
    //    BeginXXX function returned true. Begin and BeginChild are the only odd ones out. Will be fixed in a future update.]
    BeginChild :: (str_id: *u8, size: *ImVec2, child_flags: ImGuiChildFlags = 0, window_flags: ImGuiWindowFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10BeginChildEPKcRK6ImVec2ii";
    BeginChild :: (str_id: *u8, size: ImVec2 = ImVec2.{0, 0}, child_flags: ImGuiChildFlags = 0, window_flags: ImGuiWindowFlags = 0) -> bool #no_context {
        return BeginChild(str_id, *size, child_flags, window_flags);
    }
    BeginChild :: (id: ImGuiID, size: *ImVec2, child_flags: ImGuiChildFlags = 0, window_flags: ImGuiWindowFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10BeginChildEjRK6ImVec2ii";
    BeginChild :: (id: ImGuiID, size: ImVec2 = ImVec2.{0, 0}, child_flags: ImGuiChildFlags = 0, window_flags: ImGuiWindowFlags = 0) -> bool #no_context {
        return BeginChild(id, *size, child_flags, window_flags);
    }
    EndChild :: () -> void #foreign libimgui "_ZN5ImGui8EndChildEv";

    // Windows Utilities
    // - 'current window' = the window we are appending into while inside a Begin()/End() block. 'next window' = next window we will Begin() into.
    IsWindowAppearing :: () -> bool #foreign libimgui "_ZN5ImGui17IsWindowAppearingEv";
    IsWindowCollapsed :: () -> bool #foreign libimgui "_ZN5ImGui17IsWindowCollapsedEv";
    IsWindowFocused :: (flags: ImGuiFocusedFlags = 0) -> bool #foreign libimgui "_ZN5ImGui15IsWindowFocusedEi";
    IsWindowHovered :: (flags: ImGuiHoveredFlags = 0) -> bool #foreign libimgui "_ZN5ImGui15IsWindowHoveredEi";
    GetWindowDrawList :: () -> *ImDrawList #foreign libimgui "_ZN5ImGui17GetWindowDrawListEv";
    GetWindowPos :: () -> ImVec2 #foreign libimgui "_ZN5ImGui12GetWindowPosEv";
    GetWindowSize :: () -> ImVec2 #foreign libimgui "_ZN5ImGui13GetWindowSizeEv";
    GetWindowWidth :: () -> float #foreign libimgui "_ZN5ImGui14GetWindowWidthEv";
    GetWindowHeight :: () -> float #foreign libimgui "_ZN5ImGui15GetWindowHeightEv";

    // Window manipulation
    // - Prefer using SetNextXXX functions (before Begin) rather that SetXXX functions (after Begin).
    SetNextWindowPos :: (pos: *ImVec2, cond: ImGuiCond = 0, pivot: *ImVec2) -> void #foreign libimgui "_ZN5ImGui16SetNextWindowPosERK6ImVec2iS2_";
    SetNextWindowPos :: (pos: ImVec2, cond: ImGuiCond = 0, pivot: ImVec2 = ImVec2.{0, 0}) #no_context {
        SetNextWindowPos(*pos, cond, *pivot);
    }
    SetNextWindowSize :: (size: *ImVec2, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui17SetNextWindowSizeERK6ImVec2i";
    SetNextWindowSize :: (size: ImVec2, cond: ImGuiCond = 0) #no_context {
        SetNextWindowSize(*size, cond);
    }
    SetNextWindowSizeConstraints :: (size_min: *ImVec2, size_max: *ImVec2, custom_callback: ImGuiSizeCallback = null, custom_callback_data: *void = null) -> void #foreign libimgui "_ZN5ImGui28SetNextWindowSizeConstraintsERK6ImVec2S2_PFvP21ImGuiSizeCallbackDataEPv";
    SetNextWindowSizeConstraints :: (size_min: ImVec2, size_max: ImVec2, custom_callback: ImGuiSizeCallback = null, custom_callback_data: *void = null) #no_context {
        SetNextWindowSizeConstraints(*size_min, *size_max, custom_callback, custom_callback_data);
    }
    SetNextWindowContentSize :: (size: *ImVec2) -> void #foreign libimgui "_ZN5ImGui24SetNextWindowContentSizeERK6ImVec2";
    SetNextWindowContentSize :: (size: ImVec2) #no_context {
        SetNextWindowContentSize(*size);
    }
    SetNextWindowCollapsed :: (collapsed: bool, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui22SetNextWindowCollapsedEbi";
    SetNextWindowFocus :: () -> void #foreign libimgui "_ZN5ImGui18SetNextWindowFocusEv";
    SetNextWindowScroll :: (scroll: *ImVec2) -> void #foreign libimgui "_ZN5ImGui19SetNextWindowScrollERK6ImVec2";
    SetNextWindowScroll :: (scroll: ImVec2) #no_context {
        SetNextWindowScroll(*scroll);
    }
    SetNextWindowBgAlpha :: (alpha: float) -> void #foreign libimgui "_ZN5ImGui20SetNextWindowBgAlphaEf";
    SetWindowPos :: (pos: *ImVec2, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui12SetWindowPosERK6ImVec2i";
    SetWindowPos :: (pos: ImVec2, cond: ImGuiCond = 0) #no_context {
        SetWindowPos(*pos, cond);
    }
    SetWindowSize :: (size: *ImVec2, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui13SetWindowSizeERK6ImVec2i";
    SetWindowSize :: (size: ImVec2, cond: ImGuiCond = 0) #no_context {
        SetWindowSize(*size, cond);
    }
    SetWindowCollapsed :: (collapsed: bool, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui18SetWindowCollapsedEbi";
    SetWindowFocus :: () -> void #foreign libimgui "_ZN5ImGui14SetWindowFocusEv";
    SetWindowPos :: (name: *u8, pos: *ImVec2, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui12SetWindowPosEPKcRK6ImVec2i";
    SetWindowPos :: (name: *u8, pos: ImVec2, cond: ImGuiCond = 0) #no_context {
        SetWindowPos(name, *pos, cond);
    }
    SetWindowSize :: (name: *u8, size: *ImVec2, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui13SetWindowSizeEPKcRK6ImVec2i";
    SetWindowSize :: (name: *u8, size: ImVec2, cond: ImGuiCond = 0) #no_context {
        SetWindowSize(name, *size, cond);
    }
    SetWindowCollapsed :: (name: *u8, collapsed: bool, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui18SetWindowCollapsedEPKcbi";
    SetWindowFocus :: (name: *u8) -> void #foreign libimgui "_ZN5ImGui14SetWindowFocusEPKc";

    // Windows Scrolling
    // - Any change of Scroll will be applied at the beginning of next frame in the first call to Begin().
    // - You may instead use SetNextWindowScroll() prior to calling Begin() to avoid this delay, as an alternative to using SetScrollX()/SetScrollY().
    GetScrollX :: () -> float #foreign libimgui "_ZN5ImGui10GetScrollXEv";
    GetScrollY :: () -> float #foreign libimgui "_ZN5ImGui10GetScrollYEv";
    SetScrollX :: (scroll_x: float) -> void #foreign libimgui "_ZN5ImGui10SetScrollXEf";
    SetScrollY :: (scroll_y: float) -> void #foreign libimgui "_ZN5ImGui10SetScrollYEf";
    GetScrollMaxX :: () -> float #foreign libimgui "_ZN5ImGui13GetScrollMaxXEv";
    GetScrollMaxY :: () -> float #foreign libimgui "_ZN5ImGui13GetScrollMaxYEv";
    SetScrollHereX :: (center_x_ratio: float = 0.5) -> void #foreign libimgui "_ZN5ImGui14SetScrollHereXEf";
    SetScrollHereY :: (center_y_ratio: float = 0.5) -> void #foreign libimgui "_ZN5ImGui14SetScrollHereYEf";
    SetScrollFromPosX :: (local_x: float, center_x_ratio: float = 0.5) -> void #foreign libimgui "_ZN5ImGui17SetScrollFromPosXEff";
    SetScrollFromPosY :: (local_y: float, center_y_ratio: float = 0.5) -> void #foreign libimgui "_ZN5ImGui17SetScrollFromPosYEff";

    // Parameters stacks (font)
    //  - PushFont(font, 0.0f)                       // Change font and keep current size
    //  - PushFont(NULL, 20.0f)                      // Keep font and change current size
    //  - PushFont(font, 20.0f)                      // Change font and set size to 20.0f
    //  - PushFont(font, style.FontSizeBase * 2.0f)  // Change font and set size to be twice bigger than current size.
    //  - PushFont(font, font->LegacySize)           // Change font and set size to size passed to AddFontXXX() function. Same as pre-1.92 behavior.
    // *IMPORTANT* before 1.92, fonts had a single size. They can now be dynamically be adjusted.
    //  - In 1.92 we have REMOVED the single parameter version of PushFont() because it seems like the easiest way to provide an error-proof transition.
    //  - PushFont(font) before 1.92 = PushFont(font, font->LegacySize) after 1.92          // Use default font size as passed to AddFontXXX() function.
    // *IMPORTANT* global scale factors are applied over the provided size.
    //  - Global scale factors are: 'style.FontScaleMain', 'style.FontScaleDpi' and maybe more.
    // -  If you want to apply a factor to the _current_ font size:
    //  - CORRECT:   PushFont(NULL, style.FontSizeBase)         // use current unscaled size    == does nothing
    //  - CORRECT:   PushFont(NULL, style.FontSizeBase * 2.0f)  // use current unscaled size x2 == make text twice bigger
    //  - INCORRECT: PushFont(NULL, GetFontSize())              // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
    //  - INCORRECT: PushFont(NULL, GetFontSize() * 2.0f)       // INCORRECT! using size after global factors already applied == GLOBAL SCALING FACTORS WILL APPLY TWICE!
    PushFont :: (font: *ImFont, font_size_base_unscaled: float) -> void #foreign libimgui "_ZN5ImGui8PushFontEP6ImFontf";
    PopFont :: () -> void #foreign libimgui "_ZN5ImGui7PopFontEv";
    GetFont :: () -> *ImFont #foreign libimgui "_ZN5ImGui7GetFontEv";
    GetFontSize :: () -> float #foreign libimgui "_ZN5ImGui11GetFontSizeEv";
    GetFontBaked :: () -> *ImFontBaked #foreign libimgui "_ZN5ImGui12GetFontBakedEv";

    // Parameters stacks (shared)
    PushStyleColor :: (idx: ImGuiCol, col: ImU32) -> void #foreign libimgui "_ZN5ImGui14PushStyleColorEij";
    PushStyleColor :: (idx: ImGuiCol, col: *ImVec4) -> void #foreign libimgui "_ZN5ImGui14PushStyleColorEiRK6ImVec4";
    PushStyleColor :: (idx: ImGuiCol, col: ImVec4) #no_context {
        PushStyleColor(idx, *col);
    }
    PopStyleColor :: (count: s32 = 1) -> void #foreign libimgui "_ZN5ImGui13PopStyleColorEi";
    PushStyleVar :: (idx: ImGuiStyleVar, val: float) -> void #foreign libimgui "_ZN5ImGui12PushStyleVarEif";
    PushStyleVar :: (idx: ImGuiStyleVar, val: *ImVec2) -> void #foreign libimgui "_ZN5ImGui12PushStyleVarEiRK6ImVec2";
    PushStyleVar :: (idx: ImGuiStyleVar, val: ImVec2) #no_context {
        PushStyleVar(idx, *val);
    }
    PushStyleVarX :: (idx: ImGuiStyleVar, val_x: float) -> void #foreign libimgui "_ZN5ImGui13PushStyleVarXEif";
    PushStyleVarY :: (idx: ImGuiStyleVar, val_y: float) -> void #foreign libimgui "_ZN5ImGui13PushStyleVarYEif";
    PopStyleVar :: (count: s32 = 1) -> void #foreign libimgui "_ZN5ImGui11PopStyleVarEi";
    PushItemFlag :: (option: ImGuiItemFlags, enabled: bool) -> void #foreign libimgui "_ZN5ImGui12PushItemFlagEib";
    PopItemFlag :: () -> void #foreign libimgui "_ZN5ImGui11PopItemFlagEv";

    // Parameters stacks (current window)
    PushItemWidth :: (item_width: float) -> void #foreign libimgui "_ZN5ImGui13PushItemWidthEf";
    PopItemWidth :: () -> void #foreign libimgui "_ZN5ImGui12PopItemWidthEv";
    SetNextItemWidth :: (item_width: float) -> void #foreign libimgui "_ZN5ImGui16SetNextItemWidthEf";
    CalcItemWidth :: () -> float #foreign libimgui "_ZN5ImGui13CalcItemWidthEv";
    PushTextWrapPos :: (wrap_local_pos_x: float = 0.0) -> void #foreign libimgui "_ZN5ImGui15PushTextWrapPosEf";
    PopTextWrapPos :: () -> void #foreign libimgui "_ZN5ImGui14PopTextWrapPosEv";

    // Style read access
    // - Use the ShowStyleEditor() function to interactively see/edit the colors.
    GetFontTexUvWhitePixel :: () -> ImVec2 #foreign libimgui "_ZN5ImGui22GetFontTexUvWhitePixelEv";
    GetColorU32 :: (idx: ImGuiCol, alpha_mul: float = 1.0) -> ImU32 #foreign libimgui "_ZN5ImGui11GetColorU32Eif";
    GetColorU32 :: (col: *ImVec4) -> ImU32 #foreign libimgui "_ZN5ImGui11GetColorU32ERK6ImVec4";
    GetColorU32 :: (col: ImVec4) -> ImU32 #no_context {
        return GetColorU32(*col);
    }
    GetColorU32 :: (col: ImU32, alpha_mul: float = 1.0) -> ImU32 #foreign libimgui "_ZN5ImGui11GetColorU32Ejf";
    GetStyleColorVec4 :: (idx: ImGuiCol) -> *ImVec4 #foreign libimgui "_ZN5ImGui17GetStyleColorVec4Ei";

    // Layout cursor positioning
    // - By "cursor" we mean the current output position.
    // - The typical widget behavior is to output themselves at the current cursor position, then move the cursor one line down.
    // - You can call SameLine() between widgets to undo the last carriage return and output at the right of the preceding widget.
    // - YOU CAN DO 99% OF WHAT YOU NEED WITH ONLY GetCursorScreenPos() and GetContentRegionAvail().
    // - Attention! We currently have inconsistencies between window-local and absolute positions we will aim to fix with future API:
    //    - Absolute coordinate:        GetCursorScreenPos(), SetCursorScreenPos(), all ImDrawList:: functions. -> this is the preferred way forward.
    //    - Window-local coordinates:   SameLine(offset), GetCursorPos(), SetCursorPos(), GetCursorStartPos(), PushTextWrapPos()
    //    - Window-local coordinates:   GetContentRegionMax(), GetWindowContentRegionMin(), GetWindowContentRegionMax() --> all obsoleted. YOU DON'T NEED THEM.
    // - GetCursorScreenPos() = GetCursorPos() + GetWindowPos(). GetWindowPos() is almost only ever useful to convert from window-local to absolute coordinates. Try not to use it.
    GetCursorScreenPos :: () -> ImVec2 #foreign libimgui "_ZN5ImGui18GetCursorScreenPosEv";
    SetCursorScreenPos :: (pos: *ImVec2) -> void #foreign libimgui "_ZN5ImGui18SetCursorScreenPosERK6ImVec2";
    SetCursorScreenPos :: (pos: ImVec2) #no_context {
        SetCursorScreenPos(*pos);
    }
    GetContentRegionAvail :: () -> ImVec2 #foreign libimgui "_ZN5ImGui21GetContentRegionAvailEv";
    GetCursorPos :: () -> ImVec2 #foreign libimgui "_ZN5ImGui12GetCursorPosEv";
    GetCursorPosX :: () -> float #foreign libimgui "_ZN5ImGui13GetCursorPosXEv";
    GetCursorPosY :: () -> float #foreign libimgui "_ZN5ImGui13GetCursorPosYEv";
    SetCursorPos :: (local_pos: *ImVec2) -> void #foreign libimgui "_ZN5ImGui12SetCursorPosERK6ImVec2";
    SetCursorPos :: (local_pos: ImVec2) #no_context {
        SetCursorPos(*local_pos);
    }
    SetCursorPosX :: (local_x: float) -> void #foreign libimgui "_ZN5ImGui13SetCursorPosXEf";
    SetCursorPosY :: (local_y: float) -> void #foreign libimgui "_ZN5ImGui13SetCursorPosYEf";
    GetCursorStartPos :: () -> ImVec2 #foreign libimgui "_ZN5ImGui17GetCursorStartPosEv";

    // Other layout functions
    Separator :: () -> void #foreign libimgui "_ZN5ImGui9SeparatorEv";
    SameLine :: (offset_from_start_x: float = 0.0, spacing: float = -1.0) -> void #foreign libimgui "_ZN5ImGui8SameLineEff";
    NewLine :: () -> void #foreign libimgui "_ZN5ImGui7NewLineEv";
    Spacing :: () -> void #foreign libimgui "_ZN5ImGui7SpacingEv";
    Dummy :: (size: *ImVec2) -> void #foreign libimgui "_ZN5ImGui5DummyERK6ImVec2";
    Dummy :: (size: ImVec2) #no_context {
        Dummy(*size);
    }
    Indent :: (indent_w: float = 0.0) -> void #foreign libimgui "_ZN5ImGui6IndentEf";
    Unindent :: (indent_w: float = 0.0) -> void #foreign libimgui "_ZN5ImGui8UnindentEf";
    BeginGroup :: () -> void #foreign libimgui "_ZN5ImGui10BeginGroupEv";
    EndGroup :: () -> void #foreign libimgui "_ZN5ImGui8EndGroupEv";
    AlignTextToFramePadding :: () -> void #foreign libimgui "_ZN5ImGui23AlignTextToFramePaddingEv";
    GetTextLineHeight :: () -> float #foreign libimgui "_ZN5ImGui17GetTextLineHeightEv";
    GetTextLineHeightWithSpacing :: () -> float #foreign libimgui "_ZN5ImGui28GetTextLineHeightWithSpacingEv";
    GetFrameHeight :: () -> float #foreign libimgui "_ZN5ImGui14GetFrameHeightEv";
    GetFrameHeightWithSpacing :: () -> float #foreign libimgui "_ZN5ImGui25GetFrameHeightWithSpacingEv";

    // ID stack/scopes
    // Read the FAQ (docs/FAQ.md or http://dearimgui.com/faq) for more details about how ID are handled in dear imgui.
    // - Those questions are answered and impacted by understanding of the ID stack system:
    //   - "Q: Why is my widget not reacting when I click on it?"
    //   - "Q: How can I have widgets with an empty label?"
    //   - "Q: How can I have multiple widgets with the same label?"
    // - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
    //   want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
    // - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
    // - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
    //   whereas "str_id" denote a string that is only used as an ID and not normally displayed.
    PushID :: (str_id: *u8) -> void #foreign libimgui "_ZN5ImGui6PushIDEPKc";
    PushID :: (str_id_begin: *u8, str_id_end: *u8) -> void #foreign libimgui "_ZN5ImGui6PushIDEPKcS1_";
    PushID :: (ptr_id: *void) -> void #foreign libimgui "_ZN5ImGui6PushIDEPKv";
    PushID :: (int_id: s32) -> void #foreign libimgui "_ZN5ImGui6PushIDEi";
    PopID :: () -> void #foreign libimgui "_ZN5ImGui5PopIDEv";
    GetID :: (str_id: *u8) -> ImGuiID #foreign libimgui "_ZN5ImGui5GetIDEPKc";
    GetID :: (str_id_begin: *u8, str_id_end: *u8) -> ImGuiID #foreign libimgui "_ZN5ImGui5GetIDEPKcS1_";
    GetID :: (ptr_id: *void) -> ImGuiID #foreign libimgui "_ZN5ImGui5GetIDEPKv";
    GetID :: (int_id: s32) -> ImGuiID #foreign libimgui "_ZN5ImGui5GetIDEi";

    // Widgets: Text
    // - Note that all functions taking format strings in the API may be passed ("%s", text) or ("%.*s", text_len, text): which will automatically bypass the formatter.
    TextUnformatted :: (text: *u8, text_end: *u8 = null) -> void #foreign libimgui "_ZN5ImGui15TextUnformattedEPKcS1_";
    Text_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui4TextEPKcz";
    Text :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        Text_CFormat("%s", formatted_text.data);
    } @PrintLike

    TextColored_CFormat :: (col: *ImVec4, fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui11TextColoredERK6ImVec4PKcz";
    TextColored :: (col: ImVec4, fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        TextColored_CFormat(*col, "%s", formatted_text.data);
    } @PrintLike

    TextDisabled_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui12TextDisabledEPKcz";
    TextDisabled :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        TextDisabled_CFormat("%s", formatted_text.data);
    } @PrintLike

    TextWrapped_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui11TextWrappedEPKcz";
    TextWrapped :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        TextWrapped_CFormat("%s", formatted_text.data);
    } @PrintLike

    LabelText_CFormat :: (label: *u8, fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui9LabelTextEPKcS1_z";
    LabelText :: (label: *u8, fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        LabelText_CFormat(label, "%s", formatted_text.data);
    } @PrintLike

    BulletText_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui10BulletTextEPKcz";
    BulletText :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        BulletText_CFormat("%s", formatted_text.data);
    } @PrintLike

    SeparatorText :: (label: *u8) -> void #foreign libimgui "_ZN5ImGui13SeparatorTextEPKc";

    // Widgets: Main
    // - Most widgets return true when the value has been changed or when pressed/selected
    // - You may also use one of the many IsItemXXX functions (e.g. IsItemActive, IsItemHovered, etc.) to query widget state.
    Button :: (label: *u8, size: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui6ButtonEPKcRK6ImVec2";
    Button :: (label: *u8, size: ImVec2 = ImVec2.{0, 0}) -> bool #no_context {
        return Button(label, *size);
    }
    SmallButton :: (label: *u8) -> bool #foreign libimgui "_ZN5ImGui11SmallButtonEPKc";
    InvisibleButton :: (str_id: *u8, size: *ImVec2, flags: ImGuiButtonFlags = 0) -> bool #foreign libimgui "_ZN5ImGui15InvisibleButtonEPKcRK6ImVec2i";
    InvisibleButton :: (str_id: *u8, size: ImVec2, flags: ImGuiButtonFlags = 0) -> bool #no_context {
        return InvisibleButton(str_id, *size, flags);
    }
    ArrowButton :: (str_id: *u8, dir: ImGuiDir) -> bool #foreign libimgui "_ZN5ImGui11ArrowButtonEPKc8ImGuiDir";
    Checkbox :: (label: *u8, v: *bool) -> bool #foreign libimgui "_ZN5ImGui8CheckboxEPKcPb";
    CheckboxFlags :: (label: *u8, flags: *s32, flags_value: s32) -> bool #foreign libimgui "_ZN5ImGui13CheckboxFlagsEPKcPii";
    CheckboxFlags :: (label: *u8, flags: *u32, flags_value: u32) -> bool #foreign libimgui "_ZN5ImGui13CheckboxFlagsEPKcPjj";
    RadioButton :: (label: *u8, active: bool) -> bool #foreign libimgui "_ZN5ImGui11RadioButtonEPKcb";
    RadioButton :: (label: *u8, v: *s32, v_button: s32) -> bool #foreign libimgui "_ZN5ImGui11RadioButtonEPKcPii";
    ProgressBar :: (fraction: float, size_arg: *ImVec2, overlay: *u8 = null) -> void #foreign libimgui "_ZN5ImGui11ProgressBarEfRK6ImVec2PKc";
    ProgressBar :: (fraction: float, size_arg: ImVec2 = ImVec2.{-FLOAT32_MIN, 0}, overlay: *u8 = null) #no_context {
        ProgressBar(fraction, *size_arg, overlay);
    }
    Bullet :: () -> void #foreign libimgui "_ZN5ImGui6BulletEv";
    TextLink :: (label: *u8) -> bool #foreign libimgui "_ZN5ImGui8TextLinkEPKc";
    TextLinkOpenURL :: (label: *u8, url: *u8 = null) -> bool #foreign libimgui "_ZN5ImGui15TextLinkOpenURLEPKcS1_";

    // Widgets: Images
    // - Read about ImTextureID/ImTextureRef  here: https://github.com/ocornut/imgui/wiki/Image-Loading-and-Displaying-Examples
    // - 'uv0' and 'uv1' are texture coordinates. Read about them from the same link above.
    // - Image() adds style.ImageBorderSize on each side, ImageButton() adds style.FramePadding on each side.
    // - ImageButton() draws a background based on regular Button() color + optionally an inner background if specified.
    // - An obsolete version of Image(), before 1.91.9 (March 2025), had a 'tint_col' parameter which is now supported by the ImageWithBg() function.
    Image :: (tex_ref: ImTextureRef, image_size: *ImVec2, uv0: *ImVec2, uv1: *ImVec2) -> void #foreign libimgui "_ZN5ImGui5ImageE12ImTextureRefRK6ImVec2S3_S3_";
    Image :: (tex_ref: ImTextureRef, image_size: ImVec2, uv0: ImVec2 = ImVec2.{0, 0}, uv1: ImVec2 = ImVec2.{1, 1}) #no_context {
        Image(tex_ref, *image_size, *uv0, *uv1);
    }
    ImageWithBg :: (tex_ref: ImTextureRef, image_size: *ImVec2, uv0: *ImVec2, uv1: *ImVec2, bg_col: *ImVec4, tint_col: *ImVec4) -> void #foreign libimgui "_ZN5ImGui11ImageWithBgE12ImTextureRefRK6ImVec2S3_S3_RK6ImVec4S6_";
    ImageWithBg :: (tex_ref: ImTextureRef, image_size: ImVec2, uv0: ImVec2 = ImVec2.{0, 0}, uv1: ImVec2 = ImVec2.{1, 1}, bg_col: ImVec4 = ImVec4.{0, 0, 0, 0}, tint_col: ImVec4 = ImVec4.{1, 1, 1, 1}) #no_context {
        ImageWithBg(tex_ref, *image_size, *uv0, *uv1, *bg_col, *tint_col);
    }
    ImageButton :: (str_id: *u8, tex_ref: ImTextureRef, image_size: *ImVec2, uv0: *ImVec2, uv1: *ImVec2, bg_col: *ImVec4, tint_col: *ImVec4) -> bool #foreign libimgui "_ZN5ImGui11ImageButtonEPKc12ImTextureRefRK6ImVec2S5_S5_RK6ImVec4S8_";
    ImageButton :: (str_id: *u8, tex_ref: ImTextureRef, image_size: ImVec2, uv0: ImVec2 = ImVec2.{0, 0}, uv1: ImVec2 = ImVec2.{1, 1}, bg_col: ImVec4 = ImVec4.{0, 0, 0, 0}, tint_col: ImVec4 = ImVec4.{1, 1, 1, 1}) -> bool #no_context {
        return ImageButton(str_id, tex_ref, *image_size, *uv0, *uv1, *bg_col, *tint_col);
    }

    // Widgets: Combo Box (Dropdown)
    // - The BeginCombo()/EndCombo() api allows you to manage your contents and selection state however you want it, by creating e.g. Selectable() items.
    // - The old Combo() api are helpers over BeginCombo()/EndCombo() which are kept available for convenience purpose. This is analogous to how ListBox are created.
    BeginCombo :: (label: *u8, preview_value: *u8, flags: ImGuiComboFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10BeginComboEPKcS1_i";
    EndCombo :: () -> void #foreign libimgui "_ZN5ImGui8EndComboEv";
    Combo :: (label: *u8, current_item: *s32, items: **u8, items_count: s32, popup_max_height_in_items: s32 = -1) -> bool #foreign libimgui "_ZN5ImGui5ComboEPKcPiPKS1_ii";
    Combo :: (label: *u8, current_item: *s32, items_separated_by_zeros: *u8, popup_max_height_in_items: s32 = -1) -> bool #foreign libimgui "_ZN5ImGui5ComboEPKcPiS1_i";
    Combo :: (label: *u8, current_item: *s32, getter: #type (user_data: *void, idx: s32) -> *u8 #c_call, user_data: *void, items_count: s32, popup_max_height_in_items: s32 = -1) -> bool #foreign libimgui "_ZN5ImGui5ComboEPKcPiPFS1_PviES3_ii";

    // Widgets: Drag Sliders
    // - Ctrl+Click on any drag box to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    // - For all the Float2/Float3/Float4/Int2/Int3/Int4 versions of every function, note that a 'float v[X]' function argument is the same as 'float* v',
    //   the array syntax is just a way to document the number of elements that are expected to be accessible. You can pass address of your first element out of a contiguous set, e.g. &myvector.x
    // - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    // - Format string may also be set to NULL or use the default format ("%f" or "%d").
    // - Speed are per-pixel of mouse movement (v_speed=0.2f: mouse needs to move by 5 pixels to increase value by 1). For keyboard/gamepad navigation, minimum speed is Max(v_speed, minimum_step_at_given_precision).
    // - Use v_min < v_max to clamp edits to given limits. Note that Ctrl+Click manual input can override those limits if ImGuiSliderFlags_AlwaysClamp is not used.
    // - Use v_max = FLT_MAX / INT_MAX etc to avoid clamping to a maximum, same with v_min = -FLT_MAX / INT_MIN to avoid clamping to a minimum.
    // - We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
    // - Legacy: Pre-1.78 there are DragXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    //   If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    DragFloat :: (label: *u8, v: *float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9DragFloatEPKcPffffS1_i";
    DragFloat2 :: (label: *u8, v: *[2] float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10DragFloat2EPKcPffffS1_i";
    DragFloat3 :: (label: *u8, v: *[3] float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10DragFloat3EPKcPffffS1_i";
    DragFloat4 :: (label: *u8, v: *[4] float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10DragFloat4EPKcPffffS1_i";
    DragFloatRange2 :: (label: *u8, v_current_min: *float, v_current_max: *float, v_speed: float = 1.0, v_min: float = 0.0, v_max: float = 0.0, format: *u8 = "%.3f", format_max: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui15DragFloatRange2EPKcPfS2_fffS1_S1_i";
    DragInt :: (label: *u8, v: *s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui7DragIntEPKcPifiiS1_i";
    DragInt2 :: (label: *u8, v: *[2] s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui8DragInt2EPKcPifiiS1_i";
    DragInt3 :: (label: *u8, v: *[3] s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui8DragInt3EPKcPifiiS1_i";
    DragInt4 :: (label: *u8, v: *[4] s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui8DragInt4EPKcPifiiS1_i";
    DragIntRange2 :: (label: *u8, v_current_min: *s32, v_current_max: *s32, v_speed: float = 1.0, v_min: s32 = 0, v_max: s32 = 0, format: *u8 = "%d", format_max: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui13DragIntRange2EPKcPiS2_fiiS1_S1_i";
    DragScalar :: (label: *u8, data_type: ImGuiDataType, p_data: *void, v_speed: float = 1.0, p_min: *void = null, p_max: *void = null, format: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10DragScalarEPKciPvfPKvS4_S1_i";
    DragScalarN :: (label: *u8, data_type: ImGuiDataType, p_data: *void, components: s32, v_speed: float = 1.0, p_min: *void = null, p_max: *void = null, format: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11DragScalarNEPKciPvifPKvS4_S1_i";

    // Widgets: Regular Sliders
    // - Ctrl+Click on any slider to turn them into an input box. Manually input values aren't clamped by default and can go off-bounds. Use ImGuiSliderFlags_AlwaysClamp to always clamp.
    // - Adjust format string to decorate the value with a prefix, a suffix, or adapt the editing and display precision e.g. "%.3f" -> 1.234; "%5.2f secs" -> 01.23 secs; "Biscuit: %.0f" -> Biscuit: 1; etc.
    // - Format string may also be set to NULL or use the default format ("%f" or "%d").
    // - Legacy: Pre-1.78 there are SliderXXX() function signatures that take a final `float power=1.0f' argument instead of the `ImGuiSliderFlags flags=0' argument.
    //   If you get a warning converting a float to ImGuiSliderFlags, read https://github.com/ocornut/imgui/issues/3361
    SliderFloat :: (label: *u8, v: *float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11SliderFloatEPKcPfffS1_i";
    SliderFloat2 :: (label: *u8, v: *[2] float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12SliderFloat2EPKcPfffS1_i";
    SliderFloat3 :: (label: *u8, v: *[3] float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12SliderFloat3EPKcPfffS1_i";
    SliderFloat4 :: (label: *u8, v: *[4] float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12SliderFloat4EPKcPfffS1_i";
    SliderAngle :: (label: *u8, v_rad: *float, v_degrees_min: float = -360.0, v_degrees_max: float = +360.0, format: *u8 = "%.0f deg", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11SliderAngleEPKcPfffS1_i";
    SliderInt :: (label: *u8, v: *s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9SliderIntEPKcPiiiS1_i";
    SliderInt2 :: (label: *u8, v: *[2] s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10SliderInt2EPKcPiiiS1_i";
    SliderInt3 :: (label: *u8, v: *[3] s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10SliderInt3EPKcPiiiS1_i";
    SliderInt4 :: (label: *u8, v: *[4] s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10SliderInt4EPKcPiiiS1_i";
    SliderScalar :: (label: *u8, data_type: ImGuiDataType, p_data: *void, p_min: *void, p_max: *void, format: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12SliderScalarEPKciPvPKvS4_S1_i";
    SliderScalarN :: (label: *u8, data_type: ImGuiDataType, p_data: *void, components: s32, p_min: *void, p_max: *void, format: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui13SliderScalarNEPKciPviPKvS4_S1_i";
    VSliderFloat :: (label: *u8, size: *ImVec2, v: *float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12VSliderFloatEPKcRK6ImVec2PfffS1_i";
    VSliderFloat :: (label: *u8, size: ImVec2, v: *float, v_min: float, v_max: float, format: *u8 = "%.3f", flags: ImGuiSliderFlags = 0) -> bool #no_context {
        return VSliderFloat(label, *size, v, v_min, v_max, format, flags);
    }
    VSliderInt :: (label: *u8, size: *ImVec2, v: *s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10VSliderIntEPKcRK6ImVec2PiiiS1_i";
    VSliderInt :: (label: *u8, size: ImVec2, v: *s32, v_min: s32, v_max: s32, format: *u8 = "%d", flags: ImGuiSliderFlags = 0) -> bool #no_context {
        return VSliderInt(label, *size, v, v_min, v_max, format, flags);
    }
    VSliderScalar :: (label: *u8, size: *ImVec2, data_type: ImGuiDataType, p_data: *void, p_min: *void, p_max: *void, format: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #foreign libimgui "_ZN5ImGui13VSliderScalarEPKcRK6ImVec2iPvPKvS7_S1_i";
    VSliderScalar :: (label: *u8, size: ImVec2, data_type: ImGuiDataType, p_data: *void, p_min: *void, p_max: *void, format: *u8 = null, flags: ImGuiSliderFlags = 0) -> bool #no_context {
        return VSliderScalar(label, *size, data_type, p_data, p_min, p_max, format, flags);
    }

    // Widgets: Input with Keyboard
    // - If you want to use InputText() with std::string or any custom dynamic string type, use the wrapper in misc/cpp/imgui_stdlib.h/.cpp!
    // - Most of the ImGuiInputTextFlags flags are only useful for InputText() and not for InputFloatX, InputIntX, InputDouble etc.
    InputText :: (label: *u8, buf: *u8, buf_size: u64, flags: ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallback = null, user_data: *void = null) -> bool #foreign libimgui "_ZN5ImGui9InputTextEPKcPcmiPFiP26ImGuiInputTextCallbackDataEPv";
    InputTextMultiline :: (label: *u8, buf: *u8, buf_size: u64, size: *ImVec2, flags: ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallback = null, user_data: *void = null) -> bool #foreign libimgui "_ZN5ImGui18InputTextMultilineEPKcPcmRK6ImVec2iPFiP26ImGuiInputTextCallbackDataEPv";
    InputTextMultiline :: (label: *u8, buf: *u8, buf_size: u64, size: ImVec2 = ImVec2.{0, 0}, flags: ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallback = null, user_data: *void = null) -> bool #no_context {
        return InputTextMultiline(label, buf, buf_size, *size, flags, callback, user_data);
    }
    InputTextWithHint :: (label: *u8, hint: *u8, buf: *u8, buf_size: u64, flags: ImGuiInputTextFlags = 0, callback: ImGuiInputTextCallback = null, user_data: *void = null) -> bool #foreign libimgui "_ZN5ImGui17InputTextWithHintEPKcS1_PcmiPFiP26ImGuiInputTextCallbackDataEPv";
    InputFloat :: (label: *u8, v: *float, step: float = 0.0, step_fast: float = 0.0, format: *u8 = "%.3f", flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10InputFloatEPKcPfffS1_i";
    InputFloat2 :: (label: *u8, v: *[2] float, format: *u8 = "%.3f", flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11InputFloat2EPKcPfS1_i";
    InputFloat3 :: (label: *u8, v: *[3] float, format: *u8 = "%.3f", flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11InputFloat3EPKcPfS1_i";
    InputFloat4 :: (label: *u8, v: *[4] float, format: *u8 = "%.3f", flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11InputFloat4EPKcPfS1_i";
    InputInt :: (label: *u8, v: *s32, step: s32 = 1, step_fast: s32 = 100, flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui8InputIntEPKcPiiii";
    InputInt2 :: (label: *u8, v: *[2] s32, flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9InputInt2EPKcPii";
    InputInt3 :: (label: *u8, v: *[3] s32, flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9InputInt3EPKcPii";
    InputInt4 :: (label: *u8, v: *[4] s32, flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9InputInt4EPKcPii";
    InputDouble :: (label: *u8, v: *float64, step: float64 = 0.0, step_fast: float64 = 0.0, format: *u8 = "%.6f", flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11InputDoubleEPKcPdddS1_i";
    InputScalar :: (label: *u8, data_type: ImGuiDataType, p_data: *void, p_step: *void = null, p_step_fast: *void = null, format: *u8 = null, flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11InputScalarEPKciPvPKvS4_S1_i";
    InputScalarN :: (label: *u8, data_type: ImGuiDataType, p_data: *void, components: s32, p_step: *void = null, p_step_fast: *void = null, format: *u8 = null, flags: ImGuiInputTextFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12InputScalarNEPKciPviPKvS4_S1_i";

    // Widgets: Color Editor/Picker (tip: the ColorEdit* functions have a little color square that can be left-clicked to open a picker, and right-clicked to open an option menu.)
    // - Note that in C++ a 'float v[X]' function argument is the _same_ as 'float* v', the array syntax is just a way to document the number of elements that are expected to be accessible.
    // - You can pass the address of a first float element out of a contiguous structure, e.g. &myvector.x
    ColorEdit3 :: (label: *u8, col: *[3] float, flags: ImGuiColorEditFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10ColorEdit3EPKcPfi";
    ColorEdit4 :: (label: *u8, col: *[4] float, flags: ImGuiColorEditFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10ColorEdit4EPKcPfi";
    ColorPicker3 :: (label: *u8, col: *[3] float, flags: ImGuiColorEditFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12ColorPicker3EPKcPfi";
    ColorPicker4 :: (label: *u8, col: *[4] float, flags: ImGuiColorEditFlags = 0, ref_col: *float = null) -> bool #foreign libimgui "_ZN5ImGui12ColorPicker4EPKcPfiPKf";
    ColorButton :: (desc_id: *u8, col: *ImVec4, flags: ImGuiColorEditFlags = 0, size: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui11ColorButtonEPKcRK6ImVec4iRK6ImVec2";
    ColorButton :: (desc_id: *u8, col: ImVec4, flags: ImGuiColorEditFlags = 0, size: ImVec2 = ImVec2.{0, 0}) -> bool #no_context {
        return ColorButton(desc_id, *col, flags, *size);
    }

    // Widgets: Trees
    // - TreeNode functions return true when the node is open, in which case you need to also call TreePop() when you are finished displaying the tree node contents.
    TreeNode :: (label: *u8) -> bool #foreign libimgui "_ZN5ImGui8TreeNodeEPKc";
    TreeNode_CFormat :: (str_id: *u8, fmt: *u8, __args: ..Any) -> bool #foreign libimgui "_ZN5ImGui8TreeNodeEPKcS1_z";
    TreeNode :: (str_id: *u8, fmt: string, __args: ..Any) -> bool {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        return TreeNode_CFormat(str_id, "%s", formatted_text.data);
    } @PrintLike
    TreeNode_CFormat :: (ptr_id: *void, fmt: *u8, __args: ..Any) -> bool #foreign libimgui "_ZN5ImGui8TreeNodeEPKvPKcz";
    TreeNode :: (ptr_id: *void, fmt: string, __args: ..Any) -> bool {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        return TreeNode_CFormat(ptr_id, "%s", formatted_text.data);
    } @PrintLike

    TreeNodeEx :: (label: *u8, flags: ImGuiTreeNodeFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10TreeNodeExEPKci";
    TreeNodeEx_CFormat :: (str_id: *u8, flags: ImGuiTreeNodeFlags, fmt: *u8, __args: ..Any) -> bool #foreign libimgui "_ZN5ImGui10TreeNodeExEPKciS1_z";
    TreeNodeEx :: (str_id: *u8, flags: ImGuiTreeNodeFlags, fmt: string, __args: ..Any) -> bool {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        return TreeNodeEx_CFormat(str_id, flags, "%s", formatted_text.data);
    } @PrintLike
    TreeNodeEx_CFormat :: (ptr_id: *void, flags: ImGuiTreeNodeFlags, fmt: *u8, __args: ..Any) -> bool #foreign libimgui "_ZN5ImGui10TreeNodeExEPKviPKcz";
    TreeNodeEx :: (ptr_id: *void, flags: ImGuiTreeNodeFlags, fmt: string, __args: ..Any) -> bool {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        return TreeNodeEx_CFormat(ptr_id, flags, "%s", formatted_text.data);
    } @PrintLike

    TreePush :: (str_id: *u8) -> void #foreign libimgui "_ZN5ImGui8TreePushEPKc";
    TreePush :: (ptr_id: *void) -> void #foreign libimgui "_ZN5ImGui8TreePushEPKv";
    TreePop :: () -> void #foreign libimgui "_ZN5ImGui7TreePopEv";
    GetTreeNodeToLabelSpacing :: () -> float #foreign libimgui "_ZN5ImGui25GetTreeNodeToLabelSpacingEv";
    CollapsingHeader :: (label: *u8, flags: ImGuiTreeNodeFlags = 0) -> bool #foreign libimgui "_ZN5ImGui16CollapsingHeaderEPKci";
    CollapsingHeader :: (label: *u8, p_visible: *bool, flags: ImGuiTreeNodeFlags = 0) -> bool #foreign libimgui "_ZN5ImGui16CollapsingHeaderEPKcPbi";
    SetNextItemOpen :: (is_open: bool, cond: ImGuiCond = 0) -> void #foreign libimgui "_ZN5ImGui15SetNextItemOpenEbi";
    SetNextItemStorageID :: (storage_id: ImGuiID) -> void #foreign libimgui "_ZN5ImGui20SetNextItemStorageIDEj";
    TreeNodeGetOpen :: (storage_id: ImGuiID, flags: ImGuiTreeNodeFlags = 0) -> bool #foreign libimgui "_ZN5ImGui15TreeNodeGetOpenEji";

    // Widgets: Selectables
    // - A selectable highlights when hovered, and can display another color when selected.
    // - Neighbors selectable extend their highlight bounds in order to leave no gap between them. This is so a series of selected Selectable appear contiguous.
    Selectable :: (label: *u8, selected := false, flags: ImGuiSelectableFlags = 0, size: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui10SelectableEPKcbiRK6ImVec2";
    Selectable :: (label: *u8, selected := false, flags: ImGuiSelectableFlags = 0, size: ImVec2 = ImVec2.{0, 0}) -> bool #no_context {
        return Selectable(label, selected, flags, *size);
    }
    Selectable :: (label: *u8, p_selected: *bool, flags: ImGuiSelectableFlags = 0, size: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui10SelectableEPKcPbiRK6ImVec2";
    Selectable :: (label: *u8, p_selected: *bool, flags: ImGuiSelectableFlags = 0, size: ImVec2 = ImVec2.{0, 0}) -> bool #no_context {
        return Selectable(label, p_selected, flags, *size);
    }

    // Multi-selection system for Selectable(), Checkbox(), TreeNode() functions [BETA]
    // - This enables standard multi-selection/range-selection idioms (Ctrl+Mouse/Keyboard, Shift+Mouse/Keyboard, etc.) in a way that also allow a clipper to be used.
    // - ImGuiSelectionUserData is often used to store your item index within the current view (but may store something else).
    // - Read comments near ImGuiMultiSelectIO for instructions/details and see 'Demo->Widgets->Selection State & Multi-Select' for demo.
    // - TreeNode() is technically supported but... using this correctly is more complicated. You need some sort of linear/random access to your tree,
    //   which is suited to advanced trees setups already implementing filters and clipper. We will work simplifying the current demo.
    // - 'selection_size' and 'items_count' parameters are optional and used by a few features. If they are costly for you to compute, you may avoid them.
    BeginMultiSelect :: (flags: ImGuiMultiSelectFlags, selection_size: s32 = -1, items_count: s32 = -1) -> *ImGuiMultiSelectIO #foreign libimgui "_ZN5ImGui16BeginMultiSelectEiii";
    EndMultiSelect :: () -> *ImGuiMultiSelectIO #foreign libimgui "_ZN5ImGui14EndMultiSelectEv";
    SetNextItemSelectionUserData :: (selection_user_data: ImGuiSelectionUserData) -> void #foreign libimgui "_ZN5ImGui28SetNextItemSelectionUserDataEx";
    IsItemToggledSelection :: () -> bool #foreign libimgui "_ZN5ImGui22IsItemToggledSelectionEv";

    // Widgets: List Boxes
    // - This is essentially a thin wrapper to using BeginChild/EndChild with the ImGuiChildFlags_FrameStyle flag for stylistic changes + displaying a label.
    // - If you don't need a label you can probably simply use BeginChild() with the ImGuiChildFlags_FrameStyle flag for the same result.
    // - You can submit contents and manage your selection state however you want it, by creating e.g. Selectable() or any other items.
    // - The simplified/old ListBox() api are helpers over BeginListBox()/EndListBox() which are kept available for convenience purpose. This is analogous to how Combos are created.
    // - Choose frame width:   size.x > 0.0f: custom  /  size.x < 0.0f or -FLT_MIN: right-align   /  size.x = 0.0f (default): use current ItemWidth
    // - Choose frame height:  size.y > 0.0f: custom  /  size.y < 0.0f or -FLT_MIN: bottom-align  /  size.y = 0.0f (default): arbitrary default height which can fit ~7 items
    BeginListBox :: (label: *u8, size: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui12BeginListBoxEPKcRK6ImVec2";
    BeginListBox :: (label: *u8, size: ImVec2 = ImVec2.{0, 0}) -> bool #no_context {
        return BeginListBox(label, *size);
    }
    EndListBox :: () -> void #foreign libimgui "_ZN5ImGui10EndListBoxEv";
    ListBox :: (label: *u8, current_item: *s32, items: **u8, items_count: s32, height_in_items: s32 = -1) -> bool #foreign libimgui "_ZN5ImGui7ListBoxEPKcPiPKS1_ii";
    ListBox :: (label: *u8, current_item: *s32, getter: #type (user_data: *void, idx: s32) -> *u8 #c_call, user_data: *void, items_count: s32, height_in_items: s32 = -1) -> bool #foreign libimgui "_ZN5ImGui7ListBoxEPKcPiPFS1_PviES3_ii";

    // Widgets: Data Plotting
    // - Consider using ImPlot (https://github.com/epezent/implot) which is much better!
    PlotLines :: (label: *u8, values: *float, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: ImVec2 = .{0, 0}, stride: s32 = 4) -> void #foreign libimgui "_ZN5ImGui9PlotLinesEPKcPKfiiS1_ff6ImVec2i";
    PlotLines :: (label: *u8, values_getter: #type (data: *void, idx: s32) -> float #c_call, data: *void, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: ImVec2 = .{0, 0}) -> void #foreign libimgui "_ZN5ImGui9PlotLinesEPKcPFfPviES2_iiS1_ff6ImVec2";
    PlotHistogram :: (label: *u8, values: *float, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: ImVec2 = .{0, 0}, stride: s32 = 4) -> void #foreign libimgui "_ZN5ImGui13PlotHistogramEPKcPKfiiS1_ff6ImVec2i";
    PlotHistogram :: (label: *u8, values_getter: #type (data: *void, idx: s32) -> float #c_call, data: *void, values_count: s32, values_offset: s32 = 0, overlay_text: *u8 = null, scale_min: float = FLOAT32_MAX, scale_max: float = FLOAT32_MAX, graph_size: ImVec2 = .{0, 0}) -> void #foreign libimgui "_ZN5ImGui13PlotHistogramEPKcPFfPviES2_iiS1_ff6ImVec2";

    // Widgets: Value() Helpers.
    // - Those are merely shortcut to calling Text() with a format string. Output single value in "name: value" format (tip: freely declare more in your code to handle your types. you can add functions to the ImGui namespace)
    Value :: (prefix: *u8, b: bool) -> void #foreign libimgui "_ZN5ImGui5ValueEPKcb";
    Value :: (prefix: *u8, v: s32) -> void #foreign libimgui "_ZN5ImGui5ValueEPKci";
    Value :: (prefix: *u8, v: u32) -> void #foreign libimgui "_ZN5ImGui5ValueEPKcj";
    Value :: (prefix: *u8, v: float, float_format: *u8 = null) -> void #foreign libimgui "_ZN5ImGui5ValueEPKcfS1_";

    // Widgets: Menus
    // - Use BeginMenuBar() on a window ImGuiWindowFlags_MenuBar to append to its menu bar.
    // - Use BeginMainMenuBar() to create a menu bar at the top of the screen and append to it.
    // - Use BeginMenu() to create a menu. You can call BeginMenu() multiple time with the same identifier to append more items to it.
    // - Note that MenuItem() keyboard shortcuts are displayed as a convenience but _not processed_ by Dear ImGui at the moment.
    BeginMenuBar :: () -> bool #foreign libimgui "_ZN5ImGui12BeginMenuBarEv";
    EndMenuBar :: () -> void #foreign libimgui "_ZN5ImGui10EndMenuBarEv";
    BeginMainMenuBar :: () -> bool #foreign libimgui "_ZN5ImGui16BeginMainMenuBarEv";
    EndMainMenuBar :: () -> void #foreign libimgui "_ZN5ImGui14EndMainMenuBarEv";
    BeginMenu :: (label: *u8, enabled := true) -> bool #foreign libimgui "_ZN5ImGui9BeginMenuEPKcb";
    EndMenu :: () -> void #foreign libimgui "_ZN5ImGui7EndMenuEv";
    MenuItem :: (label: *u8, shortcut: *u8 = null, selected := false, enabled := true) -> bool #foreign libimgui "_ZN5ImGui8MenuItemEPKcS1_bb";
    MenuItem :: (label: *u8, shortcut: *u8, p_selected: *bool, enabled := true) -> bool #foreign libimgui "_ZN5ImGui8MenuItemEPKcS1_Pbb";

    // Tooltips
    // - Tooltips are windows following the mouse. They do not take focus away.
    // - A tooltip window can contain items of any types.
    // - SetTooltip() is more or less a shortcut for the 'if (BeginTooltip()) { Text(...); EndTooltip(); }' idiom (with a subtlety that it discard any previously submitted tooltip)
    BeginTooltip :: () -> bool #foreign libimgui "_ZN5ImGui12BeginTooltipEv";
    EndTooltip :: () -> void #foreign libimgui "_ZN5ImGui10EndTooltipEv";
    SetTooltip_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui10SetTooltipEPKcz";
    SetTooltip :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        SetTooltip_CFormat("%s", formatted_text.data);
    } @PrintLike

    // Tooltips: helpers for showing a tooltip when hovering an item
    // - BeginItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip) && BeginTooltip())' idiom.
    // - SetItemTooltip() is a shortcut for the 'if (IsItemHovered(ImGuiHoveredFlags_ForTooltip)) { SetTooltip(...); }' idiom.
    // - Where 'ImGuiHoveredFlags_ForTooltip' itself is a shortcut to use 'style.HoverFlagsForTooltipMouse' or 'style.HoverFlagsForTooltipNav' depending on active input type. For mouse it defaults to 'ImGuiHoveredFlags_Stationary | ImGuiHoveredFlags_DelayShort'.
    BeginItemTooltip :: () -> bool #foreign libimgui "_ZN5ImGui16BeginItemTooltipEv";
    SetItemTooltip_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui14SetItemTooltipEPKcz";
    SetItemTooltip :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        SetItemTooltip_CFormat("%s", formatted_text.data);
    } @PrintLike

    // Popups, Modals
    //  - They block normal mouse hovering detection (and therefore most mouse interactions) behind them.
    //  - If not modal: they can be closed by clicking anywhere outside them, or by pressing Escape (call 'Shortcut(ImGuiKey_Escape)' to claim a higher-priority shortcut).
    //  - Their visibility state (~bool) is held internally instead of being held by the programmer as we are used to with regular Begin*() calls.
    //  - The 3 properties above are related: we need to retain popup visibility state in the library because popups may be closed as any time.
    //  - You can bypass the hovering restriction by using ImGuiHoveredFlags_AllowWhenBlockedByPopup when calling IsItemHovered() or IsWindowHovered().
    //  - IMPORTANT: Popup identifiers are relative to the current ID stack, so OpenPopup and BeginPopup generally needs to be at the same level of the stack.
    //    This is sometimes leading to confusing mistakes. May rework this in the future.
    //  - BeginPopup(): query popup state, if open start appending into the window. Call EndPopup() afterwards if returned true. ImGuiWindowFlags are forwarded to the window.
    //  - BeginPopupModal(): block every interaction behind the window, cannot be closed by user, add a dimming background, has a title bar.
    BeginPopup :: (str_id: *u8, flags: ImGuiWindowFlags = 0) -> bool #foreign libimgui "_ZN5ImGui10BeginPopupEPKci";
    BeginPopupModal :: (name: *u8, p_open: *bool = null, flags: ImGuiWindowFlags = 0) -> bool #foreign libimgui "_ZN5ImGui15BeginPopupModalEPKcPbi";
    EndPopup :: () -> void #foreign libimgui "_ZN5ImGui8EndPopupEv";

    // Popups: open/close functions
    //  - OpenPopup(): set popup state to open (unless one of the specified ImGuiPopupFlags prevent opening).
    //  - OpenPopupXXX() functions return true when the popup is toggled open, which allows you to capture local state if needed.
    //    You may also call IsWindowAppearing() inside the later BeginPopup() scope if you need to prepare/compute data for the popup.
    //  - If not modal: they can be closed by clicking anywhere outside them, or by pressing ESCAPE.
    //  - CloseCurrentPopup(): use inside the BeginPopup()/EndPopup() scope to close manually.
    //  - CloseCurrentPopup() is called by default by Selectable()/MenuItem() when activated (FIXME: need some options).
    //  - Use ImGuiPopupFlags_NoOpenOverExistingPopup to avoid opening a popup if there's already one at the same level. This is equivalent to e.g. testing for !IsAnyPopupOpen() prior to OpenPopup().
    //  - Use IsWindowAppearing() after BeginPopup() to tell if a window just opened.
    OpenPopup :: (str_id: *u8, popup_flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9OpenPopupEPKci";
    OpenPopup :: (id: ImGuiID, popup_flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui9OpenPopupEji";
    OpenPopupOnItemClick :: (str_id: *u8 = null, popup_flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui20OpenPopupOnItemClickEPKci";
    CloseCurrentPopup :: () -> void #foreign libimgui "_ZN5ImGui17CloseCurrentPopupEv";

    // Popups: Open+Begin popup combined functions helpers to create context menus.
    //  - Helpers to do OpenPopup+BeginPopup where the Open action is triggered by e.g. hovering an item and right-clicking.
    //  - IMPORTANT: Notice that BeginPopupContextXXX takes ImGuiPopupFlags just like OpenPopup() and unlike BeginPopup(). For full consistency, we may add ImGuiWindowFlags to the BeginPopupContextXXX functions in the future.
    //  - IMPORTANT: If you ever used the left mouse button with BeginPopupContextXXX() helpers before 1.92.6:
    //    - Before this version, OpenPopupOnItemClick(), BeginPopupContextItem(), BeginPopupContextWindow(), BeginPopupContextVoid() had 'a ImGuiPopupFlags popup_flags = 1' default value in their function signature.
    //    - Before: Explicitly passing a literal 0 meant ImGuiPopupFlags_MouseButtonLeft. The default = 1 meant ImGuiPopupFlags_MouseButtonRight.
    //    - After: The default = 0 means ImGuiPopupFlags_MouseButtonRight. Explicitly passing a literal 1 also means ImGuiPopupFlags_MouseButtonRight (if legacy behavior are enabled) or will assert (if legacy behavior are disabled).
    //    - TL;DR: if you don't want to use right mouse button for popups, always specify it explicitly using a named ImGuiPopupFlags_MouseButtonXXXX value.
    //    - Read "API BREAKING CHANGES" 2026/01/07 (1.92.6) entry in imgui.cpp or GitHub topic #9157 for all details.
    BeginPopupContextItem :: (str_id: *u8 = null, popup_flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui21BeginPopupContextItemEPKci";
    BeginPopupContextWindow :: (str_id: *u8 = null, popup_flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui23BeginPopupContextWindowEPKci";
    BeginPopupContextVoid :: (str_id: *u8 = null, popup_flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui21BeginPopupContextVoidEPKci";

    // Popups: query functions
    //  - IsPopupOpen(): return true if the popup is open at the current BeginPopup() level of the popup stack.
    //  - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId: return true if any popup is open at the current BeginPopup() level of the popup stack.
    //  - IsPopupOpen() with ImGuiPopupFlags_AnyPopupId + ImGuiPopupFlags_AnyPopupLevel: return true if any popup is open.
    IsPopupOpen :: (str_id: *u8, flags: ImGuiPopupFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11IsPopupOpenEPKci";

    // Tables
    // - Full-featured replacement for old Columns API.
    // - See Demo->Tables for demo code. See top of imgui_tables.cpp for general commentary.
    // - See ImGuiTableFlags_ and ImGuiTableColumnFlags_ enums for a description of available flags.
    // The typical call flow is:
    // - 1. Call BeginTable(), early out if returning false.
    // - 2. Optionally call TableSetupColumn() to submit column name/flags/defaults.
    // - 3. Optionally call TableSetupScrollFreeze() to request scroll freezing of columns/rows.
    // - 4. Optionally call TableHeadersRow() to submit a header row. Names are pulled from TableSetupColumn() data.
    // - 5. Populate contents:
    //    - In most situations you can use TableNextRow() + TableSetColumnIndex(N) to start appending into a column.
    //    - If you are using tables as a sort of grid, where every column is holding the same type of contents,
    //      you may prefer using TableNextColumn() instead of TableNextRow() + TableSetColumnIndex().
    //      TableNextColumn() will automatically wrap-around into the next row if needed.
    //    - IMPORTANT: Comparatively to the old Columns() API, we need to call TableNextColumn() for the first column!
    //    - Summary of possible call flow:
    //        - TableNextRow() -> TableSetColumnIndex(0) -> Text("Hello 0") -> TableSetColumnIndex(1) -> Text("Hello 1")  // OK
    //        - TableNextRow() -> TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK
    //        -                   TableNextColumn()      -> Text("Hello 0") -> TableNextColumn()      -> Text("Hello 1")  // OK: TableNextColumn() automatically gets to next row!
    //        - TableNextRow()                           -> Text("Hello 0")                                               // Not OK! Missing TableSetColumnIndex() or TableNextColumn()! Text will not appear!
    // - 5. Call EndTable()
    BeginTable :: (str_id: *u8, columns: s32, flags: ImGuiTableFlags = 0, outer_size: *ImVec2, inner_width: float = 0.0) -> bool #foreign libimgui "_ZN5ImGui10BeginTableEPKciiRK6ImVec2f";
    BeginTable :: (str_id: *u8, columns: s32, flags: ImGuiTableFlags = 0, outer_size: ImVec2 = ImVec2.{0.0, 0.0}, inner_width: float = 0.0) -> bool #no_context {
        return BeginTable(str_id, columns, flags, *outer_size, inner_width);
    }
    EndTable :: () -> void #foreign libimgui "_ZN5ImGui8EndTableEv";
    TableNextRow :: (row_flags: ImGuiTableRowFlags = 0, min_row_height: float = 0.0) -> void #foreign libimgui "_ZN5ImGui12TableNextRowEif";
    TableNextColumn :: () -> bool #foreign libimgui "_ZN5ImGui15TableNextColumnEv";
    TableSetColumnIndex :: (column_n: s32) -> bool #foreign libimgui "_ZN5ImGui19TableSetColumnIndexEi";

    // Tables: Headers & Columns declaration
    // - Use TableSetupColumn() to specify label, resizing policy, default width/weight, various other flags etc.
    //   (the trailing 'ImGuiID user_data', which used to be referred to as 'ImGuiID user_id', is merely user data that is blindly copied in ImGuiTableColumnSortSpecs).
    // - Use TableHeadersRow() to create a header row and automatically submit a TableHeader() for each column.
    //   Headers are required to perform: reordering, sorting, and opening the context menu.
    //   The context menu can also be made available in columns body using ImGuiTableFlags_ContextMenuInBody.
    // - You may manually submit headers using TableNextRow() + TableHeader() calls, but this is only useful in
    //   some advanced use cases (e.g. adding custom widgets in header row).
    // - Use TableSetupScrollFreeze() to lock columns/rows so they stay visible when scrolled. When freezing columns you would usually also use ImGuiTableColumnFlags_NoHide on them.
    TableSetupColumn :: (label: *u8, flags: ImGuiTableColumnFlags = 0, init_width_or_weight: float = 0.0, user_data: ImGuiID = 0) -> void #foreign libimgui "_ZN5ImGui16TableSetupColumnEPKcifj";
    TableSetupScrollFreeze :: (cols: s32, rows: s32) -> void #foreign libimgui "_ZN5ImGui22TableSetupScrollFreezeEii";
    TableHeader :: (label: *u8) -> void #foreign libimgui "_ZN5ImGui11TableHeaderEPKc";
    TableHeadersRow :: () -> void #foreign libimgui "_ZN5ImGui15TableHeadersRowEv";
    TableAngledHeadersRow :: () -> void #foreign libimgui "_ZN5ImGui21TableAngledHeadersRowEv";

    // Tables: Sorting & Miscellaneous functions
    // - Sorting: call TableGetSortSpecs() to retrieve latest sort specs for the table. NULL when not sorting.
    //   When 'sort_specs->SpecsDirty == true' you should sort your data. It will be true when sorting specs have
    //   changed since last call, or the first time. Make sure to set 'SpecsDirty = false' after sorting,
    //   else you may wastefully sort your data every frame!
    // - Functions args 'int column_n' treat the default value of -1 as the same as passing the current column index.
    TableGetSortSpecs :: () -> *ImGuiTableSortSpecs #foreign libimgui "_ZN5ImGui17TableGetSortSpecsEv";
    TableGetColumnCount :: () -> s32 #foreign libimgui "_ZN5ImGui19TableGetColumnCountEv";
    TableGetColumnIndex :: () -> s32 #foreign libimgui "_ZN5ImGui19TableGetColumnIndexEv";
    TableGetRowIndex :: () -> s32 #foreign libimgui "_ZN5ImGui16TableGetRowIndexEv";
    TableGetColumnName :: (column_n: s32 = -1) -> *u8 #foreign libimgui "_ZN5ImGui18TableGetColumnNameEi";
    TableGetColumnFlags :: (column_n: s32 = -1) -> ImGuiTableColumnFlags #foreign libimgui "_ZN5ImGui19TableGetColumnFlagsEi";
    TableSetColumnEnabled :: (column_n: s32, v: bool) -> void #foreign libimgui "_ZN5ImGui21TableSetColumnEnabledEib";
    TableGetHoveredColumn :: () -> s32 #foreign libimgui "_ZN5ImGui21TableGetHoveredColumnEv";
    TableSetBgColor :: (target: ImGuiTableBgTarget, color: ImU32, column_n: s32 = -1) -> void #foreign libimgui "_ZN5ImGui15TableSetBgColorEiji";

    // Legacy Columns API (prefer using Tables!)
    // - You can also use SameLine(pos_x) to mimic simplified columns.
    Columns :: (count: s32 = 1, id: *u8 = null, borders := true) -> void #foreign libimgui "_ZN5ImGui7ColumnsEiPKcb";
    NextColumn :: () -> void #foreign libimgui "_ZN5ImGui10NextColumnEv";
    GetColumnIndex :: () -> s32 #foreign libimgui "_ZN5ImGui14GetColumnIndexEv";
    GetColumnWidth :: (column_index: s32 = -1) -> float #foreign libimgui "_ZN5ImGui14GetColumnWidthEi";
    SetColumnWidth :: (column_index: s32, width: float) -> void #foreign libimgui "_ZN5ImGui14SetColumnWidthEif";
    GetColumnOffset :: (column_index: s32 = -1) -> float #foreign libimgui "_ZN5ImGui15GetColumnOffsetEi";
    SetColumnOffset :: (column_index: s32, offset_x: float) -> void #foreign libimgui "_ZN5ImGui15SetColumnOffsetEif";
    GetColumnsCount :: () -> s32 #foreign libimgui "_ZN5ImGui15GetColumnsCountEv";

    // Tab Bars, Tabs
    // - Note: Tabs are automatically created by the docking system (when in 'docking' branch). Use this to create tab bars/tabs yourself.
    BeginTabBar :: (str_id: *u8, flags: ImGuiTabBarFlags = 0) -> bool #foreign libimgui "_ZN5ImGui11BeginTabBarEPKci";
    EndTabBar :: () -> void #foreign libimgui "_ZN5ImGui9EndTabBarEv";
    BeginTabItem :: (label: *u8, p_open: *bool = null, flags: ImGuiTabItemFlags = 0) -> bool #foreign libimgui "_ZN5ImGui12BeginTabItemEPKcPbi";
    EndTabItem :: () -> void #foreign libimgui "_ZN5ImGui10EndTabItemEv";
    TabItemButton :: (label: *u8, flags: ImGuiTabItemFlags = 0) -> bool #foreign libimgui "_ZN5ImGui13TabItemButtonEPKci";
    SetTabItemClosed :: (tab_or_docked_window_label: *u8) -> void #foreign libimgui "_ZN5ImGui16SetTabItemClosedEPKc";

    // Logging/Capture
    // - All text output from the interface can be captured into tty/file/clipboard. By default, tree nodes are automatically opened during logging.
    LogToTTY :: (auto_open_depth: s32 = -1) -> void #foreign libimgui "_ZN5ImGui8LogToTTYEi";
    LogToFile :: (auto_open_depth: s32 = -1, filename: *u8 = null) -> void #foreign libimgui "_ZN5ImGui9LogToFileEiPKc";
    LogToClipboard :: (auto_open_depth: s32 = -1) -> void #foreign libimgui "_ZN5ImGui14LogToClipboardEi";
    LogFinish :: () -> void #foreign libimgui "_ZN5ImGui9LogFinishEv";
    LogButtons :: () -> void #foreign libimgui "_ZN5ImGui10LogButtonsEv";
    LogText_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui7LogTextEPKcz";
    LogText :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        LogText_CFormat("%s", formatted_text.data);
    } @PrintLike

    // Drag and Drop
    // - On source items, call BeginDragDropSource(), if it returns true also call SetDragDropPayload() + EndDragDropSource().
    // - On target candidates, call BeginDragDropTarget(), if it returns true also call AcceptDragDropPayload() + EndDragDropTarget().
    // - If you stop calling BeginDragDropSource() the payload is preserved however it won't have a preview tooltip (we currently display a fallback "..." tooltip, see #1725)
    // - An item can be both drag source and drop target.
    BeginDragDropSource :: (flags: ImGuiDragDropFlags = 0) -> bool #foreign libimgui "_ZN5ImGui19BeginDragDropSourceEi";
    SetDragDropPayload :: (type: *u8, data: *void, sz: u64, cond: ImGuiCond = 0) -> bool #foreign libimgui "_ZN5ImGui18SetDragDropPayloadEPKcPKvmi";
    EndDragDropSource :: () -> void #foreign libimgui "_ZN5ImGui17EndDragDropSourceEv";
    BeginDragDropTarget :: () -> bool #foreign libimgui "_ZN5ImGui19BeginDragDropTargetEv";
    AcceptDragDropPayload :: (type: *u8, flags: ImGuiDragDropFlags = 0) -> *ImGuiPayload #foreign libimgui "_ZN5ImGui21AcceptDragDropPayloadEPKci";
    EndDragDropTarget :: () -> void #foreign libimgui "_ZN5ImGui17EndDragDropTargetEv";
    GetDragDropPayload :: () -> *ImGuiPayload #foreign libimgui "_ZN5ImGui18GetDragDropPayloadEv";

    // Disabling
    // - Disable all user interactions and dim items visuals (applying style.DisabledAlpha over current colors)
    // - Those can be nested but it cannot be used to enable an already disabled section (a single BeginDisabled(true) in the stack is enough to keep everything disabled)
    // - Tooltips windows are automatically opted out of disabling. Note that IsItemHovered() by default returns false on disabled items, unless using ImGuiHoveredFlags_AllowWhenDisabled.
    // - BeginDisabled(false)/EndDisabled() essentially does nothing but is provided to facilitate use of boolean expressions (as a micro-optimization: if you have tens of thousands of BeginDisabled(false)/EndDisabled() pairs, you might want to reformulate your code to avoid making those calls)
    BeginDisabled :: (disabled := true) -> void #foreign libimgui "_ZN5ImGui13BeginDisabledEb";
    EndDisabled :: () -> void #foreign libimgui "_ZN5ImGui11EndDisabledEv";

    // Clipping
    // - Mouse hovering is affected by ImGui::PushClipRect() calls, unlike direct calls to ImDrawList::PushClipRect() which are render only.
    PushClipRect :: (clip_rect_min: *ImVec2, clip_rect_max: *ImVec2, intersect_with_current_clip_rect: bool) -> void #foreign libimgui "_ZN5ImGui12PushClipRectERK6ImVec2S2_b";
    PushClipRect :: (clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect: bool) #no_context {
        PushClipRect(*clip_rect_min, *clip_rect_max, intersect_with_current_clip_rect);
    }
    PopClipRect :: () -> void #foreign libimgui "_ZN5ImGui11PopClipRectEv";

    // Focus, Activation
    SetItemDefaultFocus :: () -> void #foreign libimgui "_ZN5ImGui19SetItemDefaultFocusEv";
    SetKeyboardFocusHere :: (offset: s32 = 0) -> void #foreign libimgui "_ZN5ImGui20SetKeyboardFocusHereEi";

    // Keyboard/Gamepad Navigation
    SetNavCursorVisible :: (visible: bool) -> void #foreign libimgui "_ZN5ImGui19SetNavCursorVisibleEb";

    // Overlapping mode
    SetNextItemAllowOverlap :: () -> void #foreign libimgui "_ZN5ImGui23SetNextItemAllowOverlapEv";

    // Item/Widgets Utilities and Query Functions
    // - Most of the functions are referring to the previous Item that has been submitted.
    // - See Demo Window under "Widgets->Querying Status" for an interactive visualization of most of those functions.
    IsItemHovered :: (flags: ImGuiHoveredFlags = 0) -> bool #foreign libimgui "_ZN5ImGui13IsItemHoveredEi";
    IsItemActive :: () -> bool #foreign libimgui "_ZN5ImGui12IsItemActiveEv";
    IsItemFocused :: () -> bool #foreign libimgui "_ZN5ImGui13IsItemFocusedEv";
    IsItemClicked :: (mouse_button: ImGuiMouseButton = 0) -> bool #foreign libimgui "_ZN5ImGui13IsItemClickedEi";
    IsItemVisible :: () -> bool #foreign libimgui "_ZN5ImGui13IsItemVisibleEv";
    IsItemEdited :: () -> bool #foreign libimgui "_ZN5ImGui12IsItemEditedEv";
    IsItemActivated :: () -> bool #foreign libimgui "_ZN5ImGui15IsItemActivatedEv";
    IsItemDeactivated :: () -> bool #foreign libimgui "_ZN5ImGui17IsItemDeactivatedEv";
    IsItemDeactivatedAfterEdit :: () -> bool #foreign libimgui "_ZN5ImGui26IsItemDeactivatedAfterEditEv";
    IsItemToggledOpen :: () -> bool #foreign libimgui "_ZN5ImGui17IsItemToggledOpenEv";
    IsAnyItemHovered :: () -> bool #foreign libimgui "_ZN5ImGui16IsAnyItemHoveredEv";
    IsAnyItemActive :: () -> bool #foreign libimgui "_ZN5ImGui15IsAnyItemActiveEv";
    IsAnyItemFocused :: () -> bool #foreign libimgui "_ZN5ImGui16IsAnyItemFocusedEv";
    GetItemID :: () -> ImGuiID #foreign libimgui "_ZN5ImGui9GetItemIDEv";
    GetItemRectMin :: () -> ImVec2 #foreign libimgui "_ZN5ImGui14GetItemRectMinEv";
    GetItemRectMax :: () -> ImVec2 #foreign libimgui "_ZN5ImGui14GetItemRectMaxEv";
    GetItemRectSize :: () -> ImVec2 #foreign libimgui "_ZN5ImGui15GetItemRectSizeEv";
    GetItemFlags :: () -> ImGuiItemFlags #foreign libimgui "_ZN5ImGui12GetItemFlagsEv";
    GetItemClickedCountWithSingleClickDelay :: (mouse_button: ImGuiMouseButton = 0, delay: float = -1.0) -> s32 #foreign libimgui "_ZN5ImGui39GetItemClickedCountWithSingleClickDelayEif";

    // Viewports
    // - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
    // - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
    // - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
    GetMainViewport :: () -> *ImGuiViewport #foreign libimgui "_ZN5ImGui15GetMainViewportEv";

    // Background/Foreground Draw Lists
    GetBackgroundDrawList :: () -> *ImDrawList #foreign libimgui "_ZN5ImGui21GetBackgroundDrawListEv";
    GetForegroundDrawList :: () -> *ImDrawList #foreign libimgui "_ZN5ImGui21GetForegroundDrawListEv";

    // Miscellaneous Utilities
    IsRectVisible :: (size: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui13IsRectVisibleERK6ImVec2";
    IsRectVisible :: (size: ImVec2) -> bool #no_context {
        return IsRectVisible(*size);
    }
    IsRectVisible :: (rect_min: *ImVec2, rect_max: *ImVec2) -> bool #foreign libimgui "_ZN5ImGui13IsRectVisibleERK6ImVec2S2_";
    IsRectVisible :: (rect_min: ImVec2, rect_max: ImVec2) -> bool #no_context {
        return IsRectVisible(*rect_min, *rect_max);
    }
    GetTime :: () -> float64 #foreign libimgui "_ZN5ImGui7GetTimeEv";
    GetFrameCount :: () -> s32 #foreign libimgui "_ZN5ImGui13GetFrameCountEv";
    GetDrawListSharedData :: () -> *ImDrawListSharedData #foreign libimgui "_ZN5ImGui21GetDrawListSharedDataEv";
    GetStyleColorName :: (idx: ImGuiCol) -> *u8 #foreign libimgui "_ZN5ImGui17GetStyleColorNameEi";
    SetStateStorage :: (storage: *ImGuiStorage) -> void #foreign libimgui "_ZN5ImGui15SetStateStorageEP12ImGuiStorage";
    GetStateStorage :: () -> *ImGuiStorage #foreign libimgui "_ZN5ImGui15GetStateStorageEv";

    // Text Utilities
    CalcTextSize :: (text: *u8, text_end: *u8 = null, hide_text_after_double_hash := false, wrap_width: float = -1.0) -> ImVec2 #foreign libimgui "_ZN5ImGui12CalcTextSizeEPKcS1_bf";

    // Color Utilities
    ColorConvertU32ToFloat4 :: (in: ImU32) -> ImVec4 #foreign libimgui "_ZN5ImGui23ColorConvertU32ToFloat4Ej";
    ColorConvertFloat4ToU32 :: (in: *ImVec4) -> ImU32 #foreign libimgui "_ZN5ImGui23ColorConvertFloat4ToU32ERK6ImVec4";
    ColorConvertFloat4ToU32 :: (in: ImVec4) -> ImU32 #no_context {
        return ColorConvertFloat4ToU32(*in);
    }
    ColorConvertRGBtoHSV :: (r: float, g: float, b: float, out_h: *float, out_s: *float, out_v: *float) -> void #foreign libimgui "_ZN5ImGui20ColorConvertRGBtoHSVEfffRfS0_S0_";
    ColorConvertHSVtoRGB :: (h: float, s: float, v: float, out_r: *float, out_g: *float, out_b: *float) -> void #foreign libimgui "_ZN5ImGui20ColorConvertHSVtoRGBEfffRfS0_S0_";

    // Inputs Utilities: Raw Keyboard/Mouse/Gamepad Access
    // - Consider using the Shortcut() function instead of IsKeyPressed()/IsKeyChordPressed()! Shortcut() is easier to use and better featured (can do focus routing check).
    // - the ImGuiKey enum contains all possible keyboard, mouse and gamepad inputs (e.g. ImGuiKey_A, ImGuiKey_MouseLeft, ImGuiKey_GamepadDpadUp...).
    // - (legacy: before v1.87 (2022-02), we used ImGuiKey < 512 values to carry native/user indices as defined by each backends. This was obsoleted in 1.87 (2022-02) and completely removed in 1.91.5 (2024-11). See https://github.com/ocornut/imgui/issues/4921)
    IsKeyDown :: (key: ImGuiKey) -> bool #foreign libimgui "_ZN5ImGui9IsKeyDownE8ImGuiKey";
    IsKeyPressed :: (key: ImGuiKey, repeat := true) -> bool #foreign libimgui "_ZN5ImGui12IsKeyPressedE8ImGuiKeyb";
    IsKeyReleased :: (key: ImGuiKey) -> bool #foreign libimgui "_ZN5ImGui13IsKeyReleasedE8ImGuiKey";
    IsKeyChordPressed :: (key_chord: ImGuiKeyChord) -> bool #foreign libimgui "_ZN5ImGui17IsKeyChordPressedEi";
    GetKeyPressedAmount :: (key: ImGuiKey, repeat_delay: float, rate: float) -> s32 #foreign libimgui "_ZN5ImGui19GetKeyPressedAmountE8ImGuiKeyff";
    GetKeyName :: (key: ImGuiKey) -> *u8 #foreign libimgui "_ZN5ImGui10GetKeyNameE8ImGuiKey";
    SetNextFrameWantCaptureKeyboard :: (want_capture_keyboard: bool) -> void #foreign libimgui "_ZN5ImGui31SetNextFrameWantCaptureKeyboardEb";

    // Inputs Utilities: Shortcut Testing & Routing
    // - Typical use is e.g.: 'if (ImGui::Shortcut(ImGuiMod_Ctrl | ImGuiKey_S)) { ... }'.
    // - Flags: Default route use ImGuiInputFlags_RouteFocused, but see ImGuiInputFlags_RouteGlobal and other options in ImGuiInputFlags_!
    // - Flags: Use ImGuiInputFlags_Repeat to support repeat.
    // - ImGuiKeyChord = a ImGuiKey + optional ImGuiMod_Alt/ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Super.
    //       ImGuiKey_C                          // Accepted by functions taking ImGuiKey or ImGuiKeyChord arguments
    //       ImGuiMod_Ctrl | ImGuiKey_C          // Accepted by functions taking ImGuiKeyChord arguments
    //   only ImGuiMod_XXX values are legal to combine with an ImGuiKey. You CANNOT combine two ImGuiKey values.
    // - The general idea is that several callers may register interest in a shortcut, and only one owner gets it.
    //      Parent   -> call Shortcut(Ctrl+S)    // When Parent is focused, Parent gets the shortcut.
    //        Child1 -> call Shortcut(Ctrl+S)    // When Child1 is focused, Child1 gets the shortcut (Child1 overrides Parent shortcuts)
    //        Child2 -> no call                  // When Child2 is focused, Parent gets the shortcut.
    //   The whole system is order independent, so if Child1 makes its calls before Parent, results will be identical.
    //   This is an important property as it facilitate working with foreign code or larger codebase.
    // - To understand the difference:
    //   - IsKeyChordPressed() compares mods and call IsKeyPressed()
    //     -> the function has no side-effect.
    //   - Shortcut() submits a route, routes are resolved, if it currently can be routed it calls IsKeyChordPressed()
    //     -> the function has (desirable) side-effects as it can prevents another call from getting the route.
    // - Visualize registered routes in 'Metrics/Debugger->Inputs'.
    Shortcut :: (key_chord: ImGuiKeyChord, flags: ImGuiInputFlags = 0) -> bool #foreign libimgui "_ZN5ImGui8ShortcutEii";
    SetNextItemShortcut :: (key_chord: ImGuiKeyChord, flags: ImGuiInputFlags = 0) -> void #foreign libimgui "_ZN5ImGui19SetNextItemShortcutEii";

    // Inputs Utilities: Key/Input Ownership [BETA]
    // - One common use case would be to allow your items to disable standard inputs behaviors such
    //   as Tab or Alt key handling, Mouse Wheel scrolling, etc.
    //   e.g. `Button(...); if (SetItemKeyOwner(ImGuiKey_MouseWheelY)) { ... }` to make hovering/activating a button disable wheel for scrolling.
    // - Reminder ImGuiKey enum include access to mouse buttons and gamepad, so key ownership can apply to them.
    // - The return value of SetItemKeyOwner() says if ownership has been requested for the item, which is a shortcut to calling yet non-public TestKeyOwner() function.
    // - Many related features are still in imgui_internal.h. For instance, most IsKeyXXX()/IsMouseXXX() functions have an owner-id-aware version.
    SetItemKeyOwner :: (key: ImGuiKey) -> bool #foreign libimgui "_ZN5ImGui15SetItemKeyOwnerE8ImGuiKey";

    // Inputs Utilities: Mouse
    // - To refer to a mouse button, you may use named enums in your code e.g. ImGuiMouseButton_Left, ImGuiMouseButton_Right.
    // - You can also use regular integer: it is forever guaranteed that 0=Left, 1=Right, 2=Middle.
    // - Dragging operations are only reported after mouse has moved a certain distance away from the initial clicking position (see 'lock_threshold' and 'io.MouseDraggingThreshold')
    IsMouseDown :: (button: ImGuiMouseButton) -> bool #foreign libimgui "_ZN5ImGui11IsMouseDownEi";
    IsMouseClicked :: (button: ImGuiMouseButton, repeat := false) -> bool #foreign libimgui "_ZN5ImGui14IsMouseClickedEib";
    IsMouseReleased :: (button: ImGuiMouseButton) -> bool #foreign libimgui "_ZN5ImGui15IsMouseReleasedEi";
    IsMouseDoubleClicked :: (button: ImGuiMouseButton) -> bool #foreign libimgui "_ZN5ImGui20IsMouseDoubleClickedEi";
    IsMouseReleasedWithDelay :: (button: ImGuiMouseButton, delay: float = -1.0) -> bool #foreign libimgui "_ZN5ImGui24IsMouseReleasedWithDelayEif";
    GetMouseClickedCount :: (button: ImGuiMouseButton) -> s32 #foreign libimgui "_ZN5ImGui20GetMouseClickedCountEi";
    IsMouseHoveringRect :: (r_min: *ImVec2, r_max: *ImVec2, clip := true) -> bool #foreign libimgui "_ZN5ImGui19IsMouseHoveringRectERK6ImVec2S2_b";
    IsMouseHoveringRect :: (r_min: ImVec2, r_max: ImVec2, clip := true) -> bool #no_context {
        return IsMouseHoveringRect(*r_min, *r_max, clip);
    }
    IsMousePosValid :: (mouse_pos: *ImVec2 = null) -> bool #foreign libimgui "_ZN5ImGui15IsMousePosValidEPK6ImVec2";
    IsAnyMouseDown :: () -> bool #foreign libimgui "_ZN5ImGui14IsAnyMouseDownEv";
    GetMousePos :: () -> ImVec2 #foreign libimgui "_ZN5ImGui11GetMousePosEv";
    GetMousePosOnOpeningCurrentPopup :: () -> ImVec2 #foreign libimgui "_ZN5ImGui32GetMousePosOnOpeningCurrentPopupEv";
    IsMouseDragging :: (button: ImGuiMouseButton, lock_threshold: float = -1.0) -> bool #foreign libimgui "_ZN5ImGui15IsMouseDraggingEif";
    GetMouseDragDelta :: (button: ImGuiMouseButton = 0, lock_threshold: float = -1.0) -> ImVec2 #foreign libimgui "_ZN5ImGui17GetMouseDragDeltaEif";
    ResetMouseDragDelta :: (button: ImGuiMouseButton = 0) -> void #foreign libimgui "_ZN5ImGui19ResetMouseDragDeltaEi";
    GetMouseCursor :: () -> ImGuiMouseCursor #foreign libimgui "_ZN5ImGui14GetMouseCursorEv";
    SetMouseCursor :: (cursor_type: ImGuiMouseCursor) -> void #foreign libimgui "_ZN5ImGui14SetMouseCursorEi";
    SetNextFrameWantCaptureMouse :: (want_capture_mouse: bool) -> void #foreign libimgui "_ZN5ImGui28SetNextFrameWantCaptureMouseEb";

    // Clipboard Utilities
    // - Also see the LogToClipboard() function to capture GUI into clipboard, or easily output text data to the clipboard.
    GetClipboardText :: () -> *u8 #foreign libimgui "_ZN5ImGui16GetClipboardTextEv";
    SetClipboardText :: (text: *u8) -> void #foreign libimgui "_ZN5ImGui16SetClipboardTextEPKc";

    // Settings/.Ini Utilities
    // - The disk functions are automatically called if io.IniFilename != NULL (default is "imgui.ini").
    // - Set io.IniFilename to NULL to load/save manually. Read io.WantSaveIniSettings description about handling .ini saving manually.
    // - Important: default value "imgui.ini" is relative to current working dir! Most apps will want to lock this to an absolute path (e.g. same path as executables).
    LoadIniSettingsFromDisk :: (ini_filename: *u8) -> void #foreign libimgui "_ZN5ImGui23LoadIniSettingsFromDiskEPKc";
    LoadIniSettingsFromMemory :: (ini_data: *u8, ini_size: u64 = 0) -> void #foreign libimgui "_ZN5ImGui25LoadIniSettingsFromMemoryEPKcm";
    SaveIniSettingsToDisk :: (ini_filename: *u8) -> void #foreign libimgui "_ZN5ImGui21SaveIniSettingsToDiskEPKc";
    SaveIniSettingsToMemory :: (out_ini_size: *u64 = null) -> *u8 #foreign libimgui "_ZN5ImGui23SaveIniSettingsToMemoryEPm";

    // Debug Utilities
    // - Your main debugging friend is the ShowMetricsWindow() function.
    // - Interactive tools are all accessible from the 'Dear ImGui Demo->Tools' menu.
    // - Read https://github.com/ocornut/imgui/wiki/Debug-Tools for a description of all available debug tools.
    DebugTextEncoding :: (text: *u8) -> void #foreign libimgui "_ZN5ImGui17DebugTextEncodingEPKc";
    DebugFlashStyleColor :: (idx: ImGuiCol) -> void #foreign libimgui "_ZN5ImGui20DebugFlashStyleColorEi";
    DebugStartItemPicker :: () -> void #foreign libimgui "_ZN5ImGui20DebugStartItemPickerEv";
    DebugCheckVersionAndDataLayout :: (version_str: *u8, sz_io: u64, sz_style: u64, sz_vec2: u64, sz_vec4: u64, sz_drawvert: u64, sz_drawidx: u64) -> bool #foreign libimgui "_ZN5ImGui30DebugCheckVersionAndDataLayoutEPKcmmmmmm";

    DebugLog_CFormat :: (fmt: *u8, __args: ..Any) -> void #foreign libimgui "_ZN5ImGui8DebugLogEPKcz";
    DebugLog :: (fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        DebugLog_CFormat("%s", formatted_text.data);
    } @PrintLike

    // Memory Allocators
    // - Those functions are not reliant on the current context.
    // - DLL users: heaps and globals are not shared across DLL boundaries! You will need to call SetCurrentContext() + SetAllocatorFunctions()
    //   for each static/DLL boundary you are calling from. Read "Context and Memory Allocators" section of imgui.cpp for more details.
    SetAllocatorFunctions :: (alloc_func: ImGuiMemAllocFunc, free_func: ImGuiMemFreeFunc, user_data: *void = null) -> void #foreign libimgui "_ZN5ImGui21SetAllocatorFunctionsEPFPvmS0_EPFvS0_S0_ES0_";
    GetAllocatorFunctions :: (p_alloc_func: *ImGuiMemAllocFunc, p_free_func: *ImGuiMemFreeFunc, p_user_data: **void) -> void #foreign libimgui "_ZN5ImGui21GetAllocatorFunctionsEPPFPvmS0_EPPFvS0_S0_EPS0_";
    MemAlloc :: (size: u64) -> *void #foreign libimgui "_ZN5ImGui8MemAllocEm";
    MemFree :: (ptr: *void) -> void #foreign libimgui "_ZN5ImGui7MemFreeEPv";

    // OBSOLETED in 1.92.9 (from July 2026)
    SetColorEditOptions :: (flags: ImGuiColorEditFlags) -> void #foreign libimgui "_ZN5ImGui19SetColorEditOptionsEi";

    SetWindowFontScale :: (scale: float) -> void #foreign libimgui "_ZN5ImGui18SetWindowFontScaleEf";

    // OBSOLETED in 1.91.9 (from February 2025)
    Image :: (tex_ref: ImTextureRef, image_size: *ImVec2, uv0: *ImVec2, uv1: *ImVec2, tint_col: *ImVec4, border_col: *ImVec4) -> void #foreign libimgui "_ZN5ImGui5ImageE12ImTextureRefRK6ImVec2S3_S3_RK6ImVec4S6_";
    Image :: (tex_ref: ImTextureRef, image_size: ImVec2, uv0: ImVec2, uv1: ImVec2, tint_col: ImVec4, border_col: ImVec4) #no_context {
        Image(tex_ref, *image_size, *uv0, *uv1, *tint_col, *border_col);
    }

    // OBSOLETED in 1.91.0 (from July 2024)
    // You do not need those functions! See #7838 on GitHub for more info.
    GetContentRegionMax :: () -> ImVec2 #foreign libimgui "_ZN5ImGui19GetContentRegionMaxEv";
    GetWindowContentRegionMin :: () -> ImVec2 #foreign libimgui "_ZN5ImGui25GetWindowContentRegionMinEv";
    GetWindowContentRegionMax :: () -> ImVec2 #foreign libimgui "_ZN5ImGui25GetWindowContentRegionMaxEv";
}

// Flags for ImGui::Begin()
// (Those are per-window flags. There are shared flags in ImGuiIO: io.ConfigWindowsResizeFromEdges and io.ConfigWindowsMoveFromTitleBarOnly)
ImGuiWindowFlags_ :: enum u32 {
    None                      :: 0;
    NoTitleBar                :: 1;
    NoResize                  :: 2;
    NoMove                    :: 4;
    NoScrollbar               :: 8;
    NoScrollWithMouse         :: 16;
    NoCollapse                :: 32;
    AlwaysAutoResize          :: 64;
    NoBackground              :: 128;
    NoSavedSettings           :: 256;
    NoMouseInputs             :: 512;
    MenuBar                   :: 1024;
    HorizontalScrollbar       :: 2048;
    NoFocusOnAppearing        :: 4096;
    NoBringToFrontOnFocus     :: 8192;
    AlwaysVerticalScrollbar   :: 16384;
    AlwaysHorizontalScrollbar :: 32768;
    NoNavInputs               :: 65536;
    NoNavFocus                :: 131072;
    UnsavedDocument           :: 262144;
    NoNav                     :: 196608;
    NoDecoration              :: 43;
    NoInputs                  :: 197120;

    ChildWindow               :: 16777216;
    Tooltip                   :: 33554432;
    Popup                     :: 67108864;
    Modal                     :: 134217728;
    ChildMenu                 :: 268435456;

    ImGuiWindowFlags_None                      :: None;
    ImGuiWindowFlags_NoTitleBar                :: NoTitleBar;
    ImGuiWindowFlags_NoResize                  :: NoResize;
    ImGuiWindowFlags_NoMove                    :: NoMove;
    ImGuiWindowFlags_NoScrollbar               :: NoScrollbar;
    ImGuiWindowFlags_NoScrollWithMouse         :: NoScrollWithMouse;
    ImGuiWindowFlags_NoCollapse                :: NoCollapse;
    ImGuiWindowFlags_AlwaysAutoResize          :: AlwaysAutoResize;
    ImGuiWindowFlags_NoBackground              :: NoBackground;
    ImGuiWindowFlags_NoSavedSettings           :: NoSavedSettings;
    ImGuiWindowFlags_NoMouseInputs             :: NoMouseInputs;
    ImGuiWindowFlags_MenuBar                   :: MenuBar;
    ImGuiWindowFlags_HorizontalScrollbar       :: HorizontalScrollbar;
    ImGuiWindowFlags_NoFocusOnAppearing        :: NoFocusOnAppearing;
    ImGuiWindowFlags_NoBringToFrontOnFocus     :: NoBringToFrontOnFocus;
    ImGuiWindowFlags_AlwaysVerticalScrollbar   :: AlwaysVerticalScrollbar;
    ImGuiWindowFlags_AlwaysHorizontalScrollbar :: AlwaysHorizontalScrollbar;
    ImGuiWindowFlags_NoNavInputs               :: NoNavInputs;
    ImGuiWindowFlags_NoNavFocus                :: NoNavFocus;
    ImGuiWindowFlags_UnsavedDocument           :: UnsavedDocument;
    ImGuiWindowFlags_NoNav                     :: NoNav;
    ImGuiWindowFlags_NoDecoration              :: NoDecoration;
    ImGuiWindowFlags_NoInputs                  :: NoInputs;

    ImGuiWindowFlags_ChildWindow               :: ChildWindow;
    ImGuiWindowFlags_Tooltip                   :: Tooltip;
    ImGuiWindowFlags_Popup                     :: Popup;
    ImGuiWindowFlags_Modal                     :: Modal;
    ImGuiWindowFlags_ChildMenu                 :: ChildMenu;
}

// Flags for ImGui::BeginChild()
// (Legacy: bit 0 must always correspond to ImGuiChildFlags_Borders to be backward compatible with old API using 'bool border = false'.)
// About using AutoResizeX/AutoResizeY flags:
// - May be combined with SetNextWindowSizeConstraints() to set a min/max size for each axis (see "Demo->Child->Auto-resize with Constraints").
// - Size measurement for a given axis is only performed when the child window is within visible boundaries, or is just appearing.
//   - This allows BeginChild() to return false when not within boundaries (e.g. when scrolling), which is more optimal. BUT it won't update its auto-size while clipped.
//     While not perfect, it is a better default behavior as the always-on performance gain is more valuable than the occasional "resizing after becoming visible again" glitch.
//   - You may also use ImGuiChildFlags_AlwaysAutoResize to force an update even when child window is not in view.
//     HOWEVER PLEASE UNDERSTAND THAT DOING SO WILL PREVENT BeginChild() FROM EVER RETURNING FALSE, disabling benefits of coarse clipping.
ImGuiChildFlags_ :: enum u32 {
    None                   :: 0;
    Borders                :: 1;
    AlwaysUseWindowPadding :: 2;
    ResizeX                :: 4;
    ResizeY                :: 8;
    AutoResizeX            :: 16;
    AutoResizeY            :: 32;
    AlwaysAutoResize       :: 64;
    FrameStyle             :: 128;
    NavFlattened           :: 256;

    ImGuiChildFlags_None                   :: None;
    ImGuiChildFlags_Borders                :: Borders;
    ImGuiChildFlags_AlwaysUseWindowPadding :: AlwaysUseWindowPadding;
    ImGuiChildFlags_ResizeX                :: ResizeX;
    ImGuiChildFlags_ResizeY                :: ResizeY;
    ImGuiChildFlags_AutoResizeX            :: AutoResizeX;
    ImGuiChildFlags_AutoResizeY            :: AutoResizeY;
    ImGuiChildFlags_AlwaysAutoResize       :: AlwaysAutoResize;
    ImGuiChildFlags_FrameStyle             :: FrameStyle;
    ImGuiChildFlags_NavFlattened           :: NavFlattened;
}

// Flags for ImGui::PushItemFlag()
// (Those are shared by all submitted items)
ImGuiItemFlags_ :: enum u32 {
    None                  :: 0;
    NoTabStop             :: 1;
    NoNav                 :: 2;
    NoNavDefaultFocus     :: 4;
    ButtonRepeat          :: 8;
    AutoClosePopups       :: 16;
    AllowDuplicateId      :: 32;
    Disabled              :: 64;

    LiveEditOnInputText   :: 128;
    LiveEditOnInputScalar :: 256;
    LiveEditOnInput       :: 384;

    MixedValue            :: 512;

    ImGuiItemFlags_None                  :: None;
    ImGuiItemFlags_NoTabStop             :: NoTabStop;
    ImGuiItemFlags_NoNav                 :: NoNav;
    ImGuiItemFlags_NoNavDefaultFocus     :: NoNavDefaultFocus;
    ImGuiItemFlags_ButtonRepeat          :: ButtonRepeat;
    ImGuiItemFlags_AutoClosePopups       :: AutoClosePopups;
    ImGuiItemFlags_AllowDuplicateId      :: AllowDuplicateId;
    ImGuiItemFlags_Disabled              :: Disabled;

    ImGuiItemFlags_LiveEditOnInputText   :: LiveEditOnInputText;
    ImGuiItemFlags_LiveEditOnInputScalar :: LiveEditOnInputScalar;
    ImGuiItemFlags_LiveEditOnInput       :: LiveEditOnInput;

    ImGuiItemFlags_MixedValue            :: MixedValue;
}

// Flags for ImGui::InputText()
// (Those are per-item flags. There are shared flags in ImGuiIO: io.ConfigInputTextCursorBlink and io.ConfigInputTextEnterKeepActive)
ImGuiInputTextFlags_ :: enum u32 {
    None                :: 0;
    CharsDecimal        :: 1;
    CharsHexadecimal    :: 2;
    CharsScientific     :: 4;
    CharsUppercase      :: 8;
    CharsNoBlank        :: 16;

    AllowTabInput       :: 32;
    EnterReturnsTrue    :: 64;
    EscapeClearsAll     :: 128;
    CtrlEnterForNewLine :: 256;

    ReadOnly            :: 512;
    Password            :: 1024;
    AlwaysOverwrite     :: 2048;
    AutoSelectAll       :: 4096;
    ParseEmptyRefVal    :: 8192;
    DisplayEmptyRefVal  :: 16384;
    NoHorizontalScroll  :: 32768;
    NoUndoRedo          :: 65536;

    ElideLeft           :: 131072;

    CallbackCompletion  :: 262144;
    CallbackHistory     :: 524288;
    CallbackAlways      :: 1048576;
    CallbackCharFilter  :: 2097152;
    CallbackResize      :: 4194304;
    CallbackEdit        :: 8388608;

    WordWrap            :: 16777216;

    ImGuiInputTextFlags_None                :: None;
    ImGuiInputTextFlags_CharsDecimal        :: CharsDecimal;
    ImGuiInputTextFlags_CharsHexadecimal    :: CharsHexadecimal;
    ImGuiInputTextFlags_CharsScientific     :: CharsScientific;
    ImGuiInputTextFlags_CharsUppercase      :: CharsUppercase;
    ImGuiInputTextFlags_CharsNoBlank        :: CharsNoBlank;

    ImGuiInputTextFlags_AllowTabInput       :: AllowTabInput;
    ImGuiInputTextFlags_EnterReturnsTrue    :: EnterReturnsTrue;
    ImGuiInputTextFlags_EscapeClearsAll     :: EscapeClearsAll;
    ImGuiInputTextFlags_CtrlEnterForNewLine :: CtrlEnterForNewLine;

    ImGuiInputTextFlags_ReadOnly            :: ReadOnly;
    ImGuiInputTextFlags_Password            :: Password;
    ImGuiInputTextFlags_AlwaysOverwrite     :: AlwaysOverwrite;
    ImGuiInputTextFlags_AutoSelectAll       :: AutoSelectAll;
    ImGuiInputTextFlags_ParseEmptyRefVal    :: ParseEmptyRefVal;
    ImGuiInputTextFlags_DisplayEmptyRefVal  :: DisplayEmptyRefVal;
    ImGuiInputTextFlags_NoHorizontalScroll  :: NoHorizontalScroll;
    ImGuiInputTextFlags_NoUndoRedo          :: NoUndoRedo;

    ImGuiInputTextFlags_ElideLeft           :: ElideLeft;

    ImGuiInputTextFlags_CallbackCompletion  :: CallbackCompletion;
    ImGuiInputTextFlags_CallbackHistory     :: CallbackHistory;
    ImGuiInputTextFlags_CallbackAlways      :: CallbackAlways;
    ImGuiInputTextFlags_CallbackCharFilter  :: CallbackCharFilter;
    ImGuiInputTextFlags_CallbackResize      :: CallbackResize;
    ImGuiInputTextFlags_CallbackEdit        :: CallbackEdit;

    ImGuiInputTextFlags_WordWrap            :: WordWrap;
}

// Flags for ImGui::TreeNodeEx(), ImGui::CollapsingHeader*()
ImGuiTreeNodeFlags_ :: enum u32 {
    None                 :: 0;
    Selected             :: 1;
    Framed               :: 2;
    AllowOverlap         :: 4;
    NoTreePushOnOpen     :: 8;
    NoAutoOpenOnLog      :: 16;
    DefaultOpen          :: 32;
    OpenOnDoubleClick    :: 64;
    OpenOnArrow          :: 128;
    Leaf                 :: 256;
    Bullet               :: 512;
    FramePadding         :: 1024;
    SpanAvailWidth       :: 2048;
    SpanFullWidth        :: 4096;
    SpanLabelWidth       :: 8192;
    SpanAllColumns       :: 16384;
    LabelSpanAllColumns  :: 32768;

    NavLeftJumpsToParent :: 131072;
    CollapsingHeader     :: 26;

    DrawLinesNone        :: 262144;
    DrawLinesFull        :: 524288;
    DrawLinesToNodes     :: 1048576;

    NavLeftJumpsBackHere :: 131072;

    ImGuiTreeNodeFlags_None                 :: None;
    ImGuiTreeNodeFlags_Selected             :: Selected;
    ImGuiTreeNodeFlags_Framed               :: Framed;
    ImGuiTreeNodeFlags_AllowOverlap         :: AllowOverlap;
    ImGuiTreeNodeFlags_NoTreePushOnOpen     :: NoTreePushOnOpen;
    ImGuiTreeNodeFlags_NoAutoOpenOnLog      :: NoAutoOpenOnLog;
    ImGuiTreeNodeFlags_DefaultOpen          :: DefaultOpen;
    ImGuiTreeNodeFlags_OpenOnDoubleClick    :: OpenOnDoubleClick;
    ImGuiTreeNodeFlags_OpenOnArrow          :: OpenOnArrow;
    ImGuiTreeNodeFlags_Leaf                 :: Leaf;
    ImGuiTreeNodeFlags_Bullet               :: Bullet;
    ImGuiTreeNodeFlags_FramePadding         :: FramePadding;
    ImGuiTreeNodeFlags_SpanAvailWidth       :: SpanAvailWidth;
    ImGuiTreeNodeFlags_SpanFullWidth        :: SpanFullWidth;
    ImGuiTreeNodeFlags_SpanLabelWidth       :: SpanLabelWidth;
    ImGuiTreeNodeFlags_SpanAllColumns       :: SpanAllColumns;
    ImGuiTreeNodeFlags_LabelSpanAllColumns  :: LabelSpanAllColumns;

    ImGuiTreeNodeFlags_NavLeftJumpsToParent :: NavLeftJumpsToParent;
    ImGuiTreeNodeFlags_CollapsingHeader     :: CollapsingHeader;

    ImGuiTreeNodeFlags_DrawLinesNone        :: DrawLinesNone;
    ImGuiTreeNodeFlags_DrawLinesFull        :: DrawLinesFull;
    ImGuiTreeNodeFlags_DrawLinesToNodes     :: DrawLinesToNodes;

    ImGuiTreeNodeFlags_NavLeftJumpsBackHere :: NavLeftJumpsBackHere;
}

// Flags for OpenPopup*(), BeginPopupContext*(), IsPopupOpen() functions.
// - IMPORTANT: If you ever used the left mouse button with BeginPopupContextXXX() helpers before 1.92.6: Read "API BREAKING CHANGES" 2026/01/07 (1.92.6) entry in imgui.cpp or GitHub topic #9157.
// - Multiple buttons currently cannot be combined/or-ed in those functions (we could allow it later).
ImGuiPopupFlags_ :: enum u32 {
    None                    :: 0;
    MouseButtonLeft         :: 4;
    MouseButtonRight        :: 8;
    MouseButtonMiddle       :: 12;
    NoReopen                :: 32;

    NoOpenOverExistingPopup :: 128;
    NoOpenOverItems         :: 256;
    AnyPopupId              :: 1024;
    AnyPopupLevel           :: 2048;
    AnyPopup                :: 3072;
    MouseButtonShift_       :: 2;
    MouseButtonMask_        :: 12;
    InvalidMask_            :: 3;

    ImGuiPopupFlags_None                    :: None;
    ImGuiPopupFlags_MouseButtonLeft         :: MouseButtonLeft;
    ImGuiPopupFlags_MouseButtonRight        :: MouseButtonRight;
    ImGuiPopupFlags_MouseButtonMiddle       :: MouseButtonMiddle;
    ImGuiPopupFlags_NoReopen                :: NoReopen;

    ImGuiPopupFlags_NoOpenOverExistingPopup :: NoOpenOverExistingPopup;
    ImGuiPopupFlags_NoOpenOverItems         :: NoOpenOverItems;
    ImGuiPopupFlags_AnyPopupId              :: AnyPopupId;
    ImGuiPopupFlags_AnyPopupLevel           :: AnyPopupLevel;
    ImGuiPopupFlags_AnyPopup                :: AnyPopup;
    ImGuiPopupFlags_MouseButtonShift_       :: MouseButtonShift_;
    ImGuiPopupFlags_MouseButtonMask_        :: MouseButtonMask_;
    ImGuiPopupFlags_InvalidMask_            :: InvalidMask_;
}

// Flags for ImGui::Selectable()
ImGuiSelectableFlags_ :: enum u32 {
    None              :: 0;
    NoAutoClosePopups :: 1;
    SpanAllColumns    :: 2;
    AllowDoubleClick  :: 4;
    Disabled          :: 8;
    AllowOverlap      :: 16;
    Highlight         :: 32;
    SelectOnNav       :: 64;

    ImGuiSelectableFlags_None              :: None;
    ImGuiSelectableFlags_NoAutoClosePopups :: NoAutoClosePopups;
    ImGuiSelectableFlags_SpanAllColumns    :: SpanAllColumns;
    ImGuiSelectableFlags_AllowDoubleClick  :: AllowDoubleClick;
    ImGuiSelectableFlags_Disabled          :: Disabled;
    ImGuiSelectableFlags_AllowOverlap      :: AllowOverlap;
    ImGuiSelectableFlags_Highlight         :: Highlight;
    ImGuiSelectableFlags_SelectOnNav       :: SelectOnNav;
}

// Flags for ImGui::BeginCombo()
ImGuiComboFlags_ :: enum u32 {
    None            :: 0;
    PopupAlignLeft  :: 1;
    HeightSmall     :: 2;
    HeightRegular   :: 4;
    HeightLarge     :: 8;
    HeightLargest   :: 16;
    NoArrowButton   :: 32;
    NoPreview       :: 64;
    WidthFitPreview :: 128;
    HeightMask_     :: 30;

    ImGuiComboFlags_None            :: None;
    ImGuiComboFlags_PopupAlignLeft  :: PopupAlignLeft;
    ImGuiComboFlags_HeightSmall     :: HeightSmall;
    ImGuiComboFlags_HeightRegular   :: HeightRegular;
    ImGuiComboFlags_HeightLarge     :: HeightLarge;
    ImGuiComboFlags_HeightLargest   :: HeightLargest;
    ImGuiComboFlags_NoArrowButton   :: NoArrowButton;
    ImGuiComboFlags_NoPreview       :: NoPreview;
    ImGuiComboFlags_WidthFitPreview :: WidthFitPreview;
    ImGuiComboFlags_HeightMask_     :: HeightMask_;
}

// Flags for ImGui::BeginTabBar()
ImGuiTabBarFlags_ :: enum u32 {
    None                         :: 0;
    Reorderable                  :: 1;
    AutoSelectNewTabs            :: 2;
    TabListPopupButton           :: 4;
    NoCloseWithMiddleMouseButton :: 8;
    NoTabListScrollingButtons    :: 16;
    NoTooltip                    :: 32;
    DrawSelectedOverline         :: 64;

    FittingPolicyMixed           :: 128;
    FittingPolicyShrink          :: 256;
    FittingPolicyScroll          :: 512;
    FittingPolicyMask_           :: 896;
    FittingPolicyDefault_        :: 128;

    FittingPolicyResizeDown      :: 256;

    ImGuiTabBarFlags_None                         :: None;
    ImGuiTabBarFlags_Reorderable                  :: Reorderable;
    ImGuiTabBarFlags_AutoSelectNewTabs            :: AutoSelectNewTabs;
    ImGuiTabBarFlags_TabListPopupButton           :: TabListPopupButton;
    ImGuiTabBarFlags_NoCloseWithMiddleMouseButton :: NoCloseWithMiddleMouseButton;
    ImGuiTabBarFlags_NoTabListScrollingButtons    :: NoTabListScrollingButtons;
    ImGuiTabBarFlags_NoTooltip                    :: NoTooltip;
    ImGuiTabBarFlags_DrawSelectedOverline         :: DrawSelectedOverline;

    ImGuiTabBarFlags_FittingPolicyMixed           :: FittingPolicyMixed;
    ImGuiTabBarFlags_FittingPolicyShrink          :: FittingPolicyShrink;
    ImGuiTabBarFlags_FittingPolicyScroll          :: FittingPolicyScroll;
    ImGuiTabBarFlags_FittingPolicyMask_           :: FittingPolicyMask_;
    ImGuiTabBarFlags_FittingPolicyDefault_        :: FittingPolicyDefault_;

    ImGuiTabBarFlags_FittingPolicyResizeDown      :: FittingPolicyResizeDown;
}

// Flags for ImGui::BeginTabItem()
ImGuiTabItemFlags_ :: enum u32 {
    None                         :: 0;
    UnsavedDocument              :: 1;
    SetSelected                  :: 2;
    NoCloseWithMiddleMouseButton :: 4;
    NoPushId                     :: 8;
    NoTooltip                    :: 16;
    NoReorder                    :: 32;
    Leading                      :: 64;
    Trailing                     :: 128;
    NoAssumedClosure             :: 256;

    ImGuiTabItemFlags_None                         :: None;
    ImGuiTabItemFlags_UnsavedDocument              :: UnsavedDocument;
    ImGuiTabItemFlags_SetSelected                  :: SetSelected;
    ImGuiTabItemFlags_NoCloseWithMiddleMouseButton :: NoCloseWithMiddleMouseButton;
    ImGuiTabItemFlags_NoPushId                     :: NoPushId;
    ImGuiTabItemFlags_NoTooltip                    :: NoTooltip;
    ImGuiTabItemFlags_NoReorder                    :: NoReorder;
    ImGuiTabItemFlags_Leading                      :: Leading;
    ImGuiTabItemFlags_Trailing                     :: Trailing;
    ImGuiTabItemFlags_NoAssumedClosure             :: NoAssumedClosure;
}

// Flags for ImGui::IsWindowFocused()
ImGuiFocusedFlags_ :: enum u32 {
    None                :: 0;
    ChildWindows        :: 1;
    RootWindow          :: 2;
    AnyWindow           :: 4;
    NoPopupHierarchy    :: 8;

    RootAndChildWindows :: 3;

    ImGuiFocusedFlags_None                :: None;
    ImGuiFocusedFlags_ChildWindows        :: ChildWindows;
    ImGuiFocusedFlags_RootWindow          :: RootWindow;
    ImGuiFocusedFlags_AnyWindow           :: AnyWindow;
    ImGuiFocusedFlags_NoPopupHierarchy    :: NoPopupHierarchy;

    ImGuiFocusedFlags_RootAndChildWindows :: RootAndChildWindows;
}

// Flags for ImGui::IsItemHovered(), ImGui::IsWindowHovered()
// Note: if you are trying to check whether your mouse should be dispatched to Dear ImGui or to your app, you should use 'io.WantCaptureMouse' instead! Please read the FAQ!
// Note: windows with the ImGuiWindowFlags_NoInputs flag are ignored by IsWindowHovered() calls.
ImGuiHoveredFlags_ :: enum u32 {
    None                         :: 0;
    ChildWindows                 :: 1;
    RootWindow                   :: 2;
    AnyWindow                    :: 4;
    NoPopupHierarchy             :: 8;

    AllowWhenBlockedByPopup      :: 32;

    AllowWhenBlockedByActiveItem :: 128;
    AllowWhenOverlappedByItem    :: 256;
    AllowWhenOverlappedByWindow  :: 512;
    AllowWhenDisabled            :: 1024;
    NoNavOverride                :: 2048;
    AllowWhenOverlapped          :: 768;
    RectOnly                     :: 928;
    RootAndChildWindows          :: 3;

    ForTooltip                   :: 4096;

    Stationary                   :: 8192;
    DelayNone                    :: 16384;
    DelayShort                   :: 32768;
    DelayNormal                  :: 65536;
    NoSharedDelay                :: 131072;

    ImGuiHoveredFlags_None                         :: None;
    ImGuiHoveredFlags_ChildWindows                 :: ChildWindows;
    ImGuiHoveredFlags_RootWindow                   :: RootWindow;
    ImGuiHoveredFlags_AnyWindow                    :: AnyWindow;
    ImGuiHoveredFlags_NoPopupHierarchy             :: NoPopupHierarchy;

    ImGuiHoveredFlags_AllowWhenBlockedByPopup      :: AllowWhenBlockedByPopup;

    ImGuiHoveredFlags_AllowWhenBlockedByActiveItem :: AllowWhenBlockedByActiveItem;
    ImGuiHoveredFlags_AllowWhenOverlappedByItem    :: AllowWhenOverlappedByItem;
    ImGuiHoveredFlags_AllowWhenOverlappedByWindow  :: AllowWhenOverlappedByWindow;
    ImGuiHoveredFlags_AllowWhenDisabled            :: AllowWhenDisabled;
    ImGuiHoveredFlags_NoNavOverride                :: NoNavOverride;
    ImGuiHoveredFlags_AllowWhenOverlapped          :: AllowWhenOverlapped;
    ImGuiHoveredFlags_RectOnly                     :: RectOnly;
    ImGuiHoveredFlags_RootAndChildWindows          :: RootAndChildWindows;

    ImGuiHoveredFlags_ForTooltip                   :: ForTooltip;

    ImGuiHoveredFlags_Stationary                   :: Stationary;
    ImGuiHoveredFlags_DelayNone                    :: DelayNone;
    ImGuiHoveredFlags_DelayShort                   :: DelayShort;
    ImGuiHoveredFlags_DelayNormal                  :: DelayNormal;
    ImGuiHoveredFlags_NoSharedDelay                :: NoSharedDelay;
}

// Flags for ImGui::BeginDragDropSource(), ImGui::AcceptDragDropPayload()
ImGuiDragDropFlags_ :: enum u32 {
    None                     :: 0;

    SourceNoPreviewTooltip   :: 1;
    SourceNoDisableHover     :: 2;
    SourceNoHoldToOpenOthers :: 4;
    SourceAllowNullID        :: 8;
    SourceExtern             :: 16;
    PayloadAutoExpire        :: 32;
    PayloadNoCrossContext    :: 64;
    PayloadNoCrossProcess    :: 128;

    AcceptBeforeDelivery     :: 1024;
    AcceptNoDrawDefaultRect  :: 2048;
    AcceptNoPreviewTooltip   :: 4096;
    AcceptDrawAsHovered      :: 8192;
    AcceptPeekOnly           :: 3072;

    ImGuiDragDropFlags_None                     :: None;

    ImGuiDragDropFlags_SourceNoPreviewTooltip   :: SourceNoPreviewTooltip;
    ImGuiDragDropFlags_SourceNoDisableHover     :: SourceNoDisableHover;
    ImGuiDragDropFlags_SourceNoHoldToOpenOthers :: SourceNoHoldToOpenOthers;
    ImGuiDragDropFlags_SourceAllowNullID        :: SourceAllowNullID;
    ImGuiDragDropFlags_SourceExtern             :: SourceExtern;
    ImGuiDragDropFlags_PayloadAutoExpire        :: PayloadAutoExpire;
    ImGuiDragDropFlags_PayloadNoCrossContext    :: PayloadNoCrossContext;
    ImGuiDragDropFlags_PayloadNoCrossProcess    :: PayloadNoCrossProcess;

    ImGuiDragDropFlags_AcceptBeforeDelivery     :: AcceptBeforeDelivery;
    ImGuiDragDropFlags_AcceptNoDrawDefaultRect  :: AcceptNoDrawDefaultRect;
    ImGuiDragDropFlags_AcceptNoPreviewTooltip   :: AcceptNoPreviewTooltip;
    ImGuiDragDropFlags_AcceptDrawAsHovered      :: AcceptDrawAsHovered;
    ImGuiDragDropFlags_AcceptPeekOnly           :: AcceptPeekOnly;
}

// A primary data type
ImGuiDataType_ :: enum u32 {
    S8     :: 0;
    U8     :: 1;
    S16    :: 2;
    U16    :: 3;
    S32    :: 4;
    U32    :: 5;
    S64    :: 6;
    U64    :: 7;
    Float  :: 8;
    Double :: 9;
    Bool   :: 10;
    String :: 11;
    COUNT  :: 12;

    ImGuiDataType_S8     :: S8;
    ImGuiDataType_U8     :: U8;
    ImGuiDataType_S16    :: S16;
    ImGuiDataType_U16    :: U16;
    ImGuiDataType_S32    :: S32;
    ImGuiDataType_U32    :: U32;
    ImGuiDataType_S64    :: S64;
    ImGuiDataType_U64    :: U64;
    ImGuiDataType_Float  :: Float;
    ImGuiDataType_Double :: Double;
    ImGuiDataType_Bool   :: Bool;
    ImGuiDataType_String :: String;
    ImGuiDataType_COUNT  :: COUNT;
}

// Flags for Shortcut(), SetNextItemShortcut(),
// (and for upcoming extended versions of IsKeyPressed(), IsMouseClicked(), Shortcut(), SetKeyOwner(), SetItemKeyOwner() that are still in imgui_internal.h)
// Don't mistake with ImGuiInputTextFlags! (which is for ImGui::InputText() function)
ImGuiInputFlags_ :: enum u32 {
    None                 :: 0;
    Repeat               :: 1;

    RouteActive          :: 1024;
    RouteFocused         :: 2048;
    RouteGlobal          :: 4096;
    RouteAlways          :: 8192;

    RouteOverFocused     :: 16384;
    RouteOverActive      :: 32768;
    RouteUnlessBgFocused :: 65536;
    RouteFromRootWindow  :: 131072;

    Tooltip              :: 262144;

    ImGuiInputFlags_None                 :: None;
    ImGuiInputFlags_Repeat               :: Repeat;

    ImGuiInputFlags_RouteActive          :: RouteActive;
    ImGuiInputFlags_RouteFocused         :: RouteFocused;
    ImGuiInputFlags_RouteGlobal          :: RouteGlobal;
    ImGuiInputFlags_RouteAlways          :: RouteAlways;

    ImGuiInputFlags_RouteOverFocused     :: RouteOverFocused;
    ImGuiInputFlags_RouteOverActive      :: RouteOverActive;
    ImGuiInputFlags_RouteUnlessBgFocused :: RouteUnlessBgFocused;
    ImGuiInputFlags_RouteFromRootWindow  :: RouteFromRootWindow;

    ImGuiInputFlags_Tooltip              :: Tooltip;
}

// Configuration flags stored in io.ConfigFlags. Set by user/application.
// Note that nowadays most of our configuration options are in other ImGuiIO fields, e.g. io.ConfigWindowsMoveFromTitleBarOnly.
ImGuiConfigFlags_ :: enum u32 {
    None                 :: 0;
    NavEnableKeyboard    :: 1;
    NavEnableGamepad     :: 2;
    NoMouse              :: 16;
    NoMouseCursorChange  :: 32;
    NoKeyboard           :: 64;

    IsSRGB               :: 1048576;
    IsTouchScreen        :: 2097152;

    NavEnableSetMousePos :: 4;
    NavNoCaptureKeyboard :: 8;

    ImGuiConfigFlags_None                 :: None;
    ImGuiConfigFlags_NavEnableKeyboard    :: NavEnableKeyboard;
    ImGuiConfigFlags_NavEnableGamepad     :: NavEnableGamepad;
    ImGuiConfigFlags_NoMouse              :: NoMouse;
    ImGuiConfigFlags_NoMouseCursorChange  :: NoMouseCursorChange;
    ImGuiConfigFlags_NoKeyboard           :: NoKeyboard;

    ImGuiConfigFlags_IsSRGB               :: IsSRGB;
    ImGuiConfigFlags_IsTouchScreen        :: IsTouchScreen;

    ImGuiConfigFlags_NavEnableSetMousePos :: NavEnableSetMousePos;
    ImGuiConfigFlags_NavNoCaptureKeyboard :: NavNoCaptureKeyboard;
}

// Backend capabilities flags stored in io.BackendFlags. Set by imgui_impl_xxx or custom backend.
ImGuiBackendFlags_ :: enum u32 {
    None                 :: 0;
    HasGamepad           :: 1;
    HasMouseCursors      :: 2;
    HasSetMousePos       :: 4;
    RendererHasVtxOffset :: 8;
    RendererHasTextures  :: 16;

    ImGuiBackendFlags_None                 :: None;
    ImGuiBackendFlags_HasGamepad           :: HasGamepad;
    ImGuiBackendFlags_HasMouseCursors      :: HasMouseCursors;
    ImGuiBackendFlags_HasSetMousePos       :: HasSetMousePos;
    ImGuiBackendFlags_RendererHasVtxOffset :: RendererHasVtxOffset;
    ImGuiBackendFlags_RendererHasTextures  :: RendererHasTextures;
}

// Enumeration for PushStyleColor() / PopStyleColor()
ImGuiCol_ :: enum u32 {
    Text                      :: 0;
    TextDisabled              :: 1;
    WindowBg                  :: 2;
    ChildBg                   :: 3;
    PopupBg                   :: 4;
    Border                    :: 5;
    BorderShadow              :: 6;
    FrameBg                   :: 7;
    FrameBgHovered            :: 8;
    FrameBgActive             :: 9;
    TitleBg                   :: 10;
    TitleBgActive             :: 11;
    TitleBgCollapsed          :: 12;
    MenuBarBg                 :: 13;
    ScrollbarBg               :: 14;
    ScrollbarGrab             :: 15;
    ScrollbarGrabHovered      :: 16;
    ScrollbarGrabActive       :: 17;
    CheckMark                 :: 18;
    CheckboxSelectedBg        :: 19;
    SliderGrab                :: 20;
    SliderGrabActive          :: 21;
    Button                    :: 22;
    ButtonHovered             :: 23;
    ButtonActive              :: 24;
    Header                    :: 25;
    HeaderHovered             :: 26;
    HeaderActive              :: 27;
    Separator                 :: 28;
    SeparatorHovered          :: 29;
    SeparatorActive           :: 30;
    ResizeGrip                :: 31;
    ResizeGripHovered         :: 32;
    ResizeGripActive          :: 33;
    InputTextCursor           :: 34;
    TabHovered                :: 35;
    Tab                       :: 36;
    TabSelected               :: 37;
    TabSelectedOverline       :: 38;
    TabDimmed                 :: 39;
    TabDimmedSelected         :: 40;
    TabDimmedSelectedOverline :: 41;
    PlotLines                 :: 42;
    PlotLinesHovered          :: 43;
    PlotHistogram             :: 44;
    PlotHistogramHovered      :: 45;
    TableHeaderBg             :: 46;
    TableBorderStrong         :: 47;
    TableBorderLight          :: 48;
    TableRowBg                :: 49;
    TableRowBgAlt             :: 50;
    TextLink                  :: 51;
    TextSelectedBg            :: 52;
    TreeLines                 :: 53;
    DragDropTarget            :: 54;
    DragDropTargetBg          :: 55;
    UnsavedMarker             :: 56;
    NavCursor                 :: 57;
    NavWindowingHighlight     :: 58;
    NavWindowingDimBg         :: 59;
    ModalWindowDimBg          :: 60;
    COUNT                     :: 61;

    NavHighlight              :: 57;

    ImGuiCol_Text                      :: Text;
    ImGuiCol_TextDisabled              :: TextDisabled;
    ImGuiCol_WindowBg                  :: WindowBg;
    ImGuiCol_ChildBg                   :: ChildBg;
    ImGuiCol_PopupBg                   :: PopupBg;
    ImGuiCol_Border                    :: Border;
    ImGuiCol_BorderShadow              :: BorderShadow;
    ImGuiCol_FrameBg                   :: FrameBg;
    ImGuiCol_FrameBgHovered            :: FrameBgHovered;
    ImGuiCol_FrameBgActive             :: FrameBgActive;
    ImGuiCol_TitleBg                   :: TitleBg;
    ImGuiCol_TitleBgActive             :: TitleBgActive;
    ImGuiCol_TitleBgCollapsed          :: TitleBgCollapsed;
    ImGuiCol_MenuBarBg                 :: MenuBarBg;
    ImGuiCol_ScrollbarBg               :: ScrollbarBg;
    ImGuiCol_ScrollbarGrab             :: ScrollbarGrab;
    ImGuiCol_ScrollbarGrabHovered      :: ScrollbarGrabHovered;
    ImGuiCol_ScrollbarGrabActive       :: ScrollbarGrabActive;
    ImGuiCol_CheckMark                 :: CheckMark;
    ImGuiCol_CheckboxSelectedBg        :: CheckboxSelectedBg;
    ImGuiCol_SliderGrab                :: SliderGrab;
    ImGuiCol_SliderGrabActive          :: SliderGrabActive;
    ImGuiCol_Button                    :: Button;
    ImGuiCol_ButtonHovered             :: ButtonHovered;
    ImGuiCol_ButtonActive              :: ButtonActive;
    ImGuiCol_Header                    :: Header;
    ImGuiCol_HeaderHovered             :: HeaderHovered;
    ImGuiCol_HeaderActive              :: HeaderActive;
    ImGuiCol_Separator                 :: Separator;
    ImGuiCol_SeparatorHovered          :: SeparatorHovered;
    ImGuiCol_SeparatorActive           :: SeparatorActive;
    ImGuiCol_ResizeGrip                :: ResizeGrip;
    ImGuiCol_ResizeGripHovered         :: ResizeGripHovered;
    ImGuiCol_ResizeGripActive          :: ResizeGripActive;
    ImGuiCol_InputTextCursor           :: InputTextCursor;
    ImGuiCol_TabHovered                :: TabHovered;
    ImGuiCol_Tab                       :: Tab;
    ImGuiCol_TabSelected               :: TabSelected;
    ImGuiCol_TabSelectedOverline       :: TabSelectedOverline;
    ImGuiCol_TabDimmed                 :: TabDimmed;
    ImGuiCol_TabDimmedSelected         :: TabDimmedSelected;
    ImGuiCol_TabDimmedSelectedOverline :: TabDimmedSelectedOverline;
    ImGuiCol_PlotLines                 :: PlotLines;
    ImGuiCol_PlotLinesHovered          :: PlotLinesHovered;
    ImGuiCol_PlotHistogram             :: PlotHistogram;
    ImGuiCol_PlotHistogramHovered      :: PlotHistogramHovered;
    ImGuiCol_TableHeaderBg             :: TableHeaderBg;
    ImGuiCol_TableBorderStrong         :: TableBorderStrong;
    ImGuiCol_TableBorderLight          :: TableBorderLight;
    ImGuiCol_TableRowBg                :: TableRowBg;
    ImGuiCol_TableRowBgAlt             :: TableRowBgAlt;
    ImGuiCol_TextLink                  :: TextLink;
    ImGuiCol_TextSelectedBg            :: TextSelectedBg;
    ImGuiCol_TreeLines                 :: TreeLines;
    ImGuiCol_DragDropTarget            :: DragDropTarget;
    ImGuiCol_DragDropTargetBg          :: DragDropTargetBg;
    ImGuiCol_UnsavedMarker             :: UnsavedMarker;
    ImGuiCol_NavCursor                 :: NavCursor;
    ImGuiCol_NavWindowingHighlight     :: NavWindowingHighlight;
    ImGuiCol_NavWindowingDimBg         :: NavWindowingDimBg;
    ImGuiCol_ModalWindowDimBg          :: ModalWindowDimBg;
    ImGuiCol_COUNT                     :: COUNT;

    ImGuiCol_NavHighlight              :: NavHighlight;
}

// Enumeration for PushStyleVar() / PopStyleVar() to temporarily modify the ImGuiStyle structure.
// - The enum only refers to fields of ImGuiStyle which makes sense to be pushed/popped inside UI code.
//   During initialization or between frames, feel free to just poke into ImGuiStyle directly.
// - Tip: Use your programming IDE navigation facilities on the names in the _second column_ below to find the actual members and their description.
//   - In Visual Studio: Ctrl+Comma ("Edit.GoToAll") can follow symbols inside comments, whereas Ctrl+F12 ("Edit.GoToImplementation") cannot.
//   - In Visual Studio w/ Visual Assist installed: Alt+G ("VAssistX.GoToImplementation") can also follow symbols inside comments.
//   - In VS Code, CLion, etc.: Ctrl+Click can follow symbols inside comments.
// - When changing this enum, you need to update the associated internal table GStyleVarInfo[] accordingly. This is where we link enum values to members offset/type.
ImGuiStyleVar_ :: enum u32 {
    Alpha                       :: 0;
    DisabledAlpha               :: 1;
    WindowPadding               :: 2;
    WindowRounding              :: 3;
    WindowBorderSize            :: 4;
    WindowMinSize               :: 5;
    WindowTitleAlign            :: 6;
    ChildRounding               :: 7;
    ChildBorderSize             :: 8;
    PopupRounding               :: 9;
    PopupBorderSize             :: 10;
    FramePadding                :: 11;
    FrameRounding               :: 12;
    FrameBorderSize             :: 13;
    ItemSpacing                 :: 14;
    ItemInnerSpacing            :: 15;
    IndentSpacing               :: 16;
    CellPadding                 :: 17;
    ScrollbarSize               :: 18;
    ScrollbarRounding           :: 19;
    ScrollbarPadding            :: 20;
    GrabMinSize                 :: 21;
    GrabRounding                :: 22;
    ImageRounding               :: 23;
    ImageBorderSize             :: 24;
    TabRounding                 :: 25;
    TabBorderSize               :: 26;
    TabMinWidthBase             :: 27;
    TabMinWidthShrink           :: 28;
    TabBarBorderSize            :: 29;
    TabBarOverlineSize          :: 30;
    TableAngledHeadersAngle     :: 31;
    TableAngledHeadersTextAlign :: 32;
    TreeLinesSize               :: 33;
    TreeLinesRounding           :: 34;
    MenuItemRounding            :: 35;
    SelectableRounding          :: 36;
    DragDropTargetRounding      :: 37;
    ButtonTextAlign             :: 38;
    SelectableTextAlign         :: 39;
    SeparatorSize               :: 40;
    SeparatorTextBorderSize     :: 41;
    SeparatorTextAlign          :: 42;
    SeparatorTextPadding        :: 43;
    COUNT                       :: 44;

    ImGuiStyleVar_Alpha                       :: Alpha;
    ImGuiStyleVar_DisabledAlpha               :: DisabledAlpha;
    ImGuiStyleVar_WindowPadding               :: WindowPadding;
    ImGuiStyleVar_WindowRounding              :: WindowRounding;
    ImGuiStyleVar_WindowBorderSize            :: WindowBorderSize;
    ImGuiStyleVar_WindowMinSize               :: WindowMinSize;
    ImGuiStyleVar_WindowTitleAlign            :: WindowTitleAlign;
    ImGuiStyleVar_ChildRounding               :: ChildRounding;
    ImGuiStyleVar_ChildBorderSize             :: ChildBorderSize;
    ImGuiStyleVar_PopupRounding               :: PopupRounding;
    ImGuiStyleVar_PopupBorderSize             :: PopupBorderSize;
    ImGuiStyleVar_FramePadding                :: FramePadding;
    ImGuiStyleVar_FrameRounding               :: FrameRounding;
    ImGuiStyleVar_FrameBorderSize             :: FrameBorderSize;
    ImGuiStyleVar_ItemSpacing                 :: ItemSpacing;
    ImGuiStyleVar_ItemInnerSpacing            :: ItemInnerSpacing;
    ImGuiStyleVar_IndentSpacing               :: IndentSpacing;
    ImGuiStyleVar_CellPadding                 :: CellPadding;
    ImGuiStyleVar_ScrollbarSize               :: ScrollbarSize;
    ImGuiStyleVar_ScrollbarRounding           :: ScrollbarRounding;
    ImGuiStyleVar_ScrollbarPadding            :: ScrollbarPadding;
    ImGuiStyleVar_GrabMinSize                 :: GrabMinSize;
    ImGuiStyleVar_GrabRounding                :: GrabRounding;
    ImGuiStyleVar_ImageRounding               :: ImageRounding;
    ImGuiStyleVar_ImageBorderSize             :: ImageBorderSize;
    ImGuiStyleVar_TabRounding                 :: TabRounding;
    ImGuiStyleVar_TabBorderSize               :: TabBorderSize;
    ImGuiStyleVar_TabMinWidthBase             :: TabMinWidthBase;
    ImGuiStyleVar_TabMinWidthShrink           :: TabMinWidthShrink;
    ImGuiStyleVar_TabBarBorderSize            :: TabBarBorderSize;
    ImGuiStyleVar_TabBarOverlineSize          :: TabBarOverlineSize;
    ImGuiStyleVar_TableAngledHeadersAngle     :: TableAngledHeadersAngle;
    ImGuiStyleVar_TableAngledHeadersTextAlign :: TableAngledHeadersTextAlign;
    ImGuiStyleVar_TreeLinesSize               :: TreeLinesSize;
    ImGuiStyleVar_TreeLinesRounding           :: TreeLinesRounding;
    ImGuiStyleVar_MenuItemRounding            :: MenuItemRounding;
    ImGuiStyleVar_SelectableRounding          :: SelectableRounding;
    ImGuiStyleVar_DragDropTargetRounding      :: DragDropTargetRounding;
    ImGuiStyleVar_ButtonTextAlign             :: ButtonTextAlign;
    ImGuiStyleVar_SelectableTextAlign         :: SelectableTextAlign;
    ImGuiStyleVar_SeparatorSize               :: SeparatorSize;
    ImGuiStyleVar_SeparatorTextBorderSize     :: SeparatorTextBorderSize;
    ImGuiStyleVar_SeparatorTextAlign          :: SeparatorTextAlign;
    ImGuiStyleVar_SeparatorTextPadding        :: SeparatorTextPadding;
    ImGuiStyleVar_COUNT                       :: COUNT;
}

// Flags for InvisibleButton() [extended in imgui_internal.h]
ImGuiButtonFlags_ :: enum u32 {
    None              :: 0;
    MouseButtonLeft   :: 1;
    MouseButtonRight  :: 2;
    MouseButtonMiddle :: 4;
    MouseButtonMask_  :: 7;
    EnableNav         :: 8;
    AllowOverlap      :: 4096;

    ImGuiButtonFlags_None              :: None;
    ImGuiButtonFlags_MouseButtonLeft   :: MouseButtonLeft;
    ImGuiButtonFlags_MouseButtonRight  :: MouseButtonRight;
    ImGuiButtonFlags_MouseButtonMiddle :: MouseButtonMiddle;
    ImGuiButtonFlags_MouseButtonMask_  :: MouseButtonMask_;
    ImGuiButtonFlags_EnableNav         :: EnableNav;
    ImGuiButtonFlags_AllowOverlap      :: AllowOverlap;
}

// Flags for ColorEdit3() / ColorEdit4() / ColorPicker3() / ColorPicker4() / ColorButton()
ImGuiColorEditFlags_ :: enum u32 {
    None             :: 0;
    NoAlpha          :: 2;
    NoPicker         :: 4;
    NoOptions        :: 8;
    NoSmallPreview   :: 16;
    NoInputs         :: 32;
    NoTooltip        :: 64;
    NoLabel          :: 128;
    NoSidePreview    :: 256;
    NoDragDrop       :: 512;
    NoBorder         :: 1024;
    NoColorMarkers   :: 2048;

    AlphaOpaque      :: 4096;
    AlphaNoBg        :: 8192;
    AlphaPreviewHalf :: 16384;

    AlphaBar         :: 262144;
    HDR              :: 524288;
    DisplayRGB       :: 1048576;
    DisplayHSV       :: 2097152;
    DisplayHex       :: 4194304;
    Uint8            :: 8388608;
    Float            :: 16777216;
    PickerHueBar     :: 33554432;
    PickerHueWheel   :: 67108864;
    PickerNoRotate   :: 134217728;
    InputRGB         :: 268435456;
    InputHSV         :: 536870912;

    DefaultOptions_  :: 311427072;

    AlphaMask_       :: 28674;
    DisplayMask_     :: 7340032;
    DataTypeMask_    :: 25165824;
    PickerMask_      :: 100663296;
    InputMask_       :: 805306368;

    AlphaPreview     :: 0;

    ImGuiColorEditFlags_None             :: None;
    ImGuiColorEditFlags_NoAlpha          :: NoAlpha;
    ImGuiColorEditFlags_NoPicker         :: NoPicker;
    ImGuiColorEditFlags_NoOptions        :: NoOptions;
    ImGuiColorEditFlags_NoSmallPreview   :: NoSmallPreview;
    ImGuiColorEditFlags_NoInputs         :: NoInputs;
    ImGuiColorEditFlags_NoTooltip        :: NoTooltip;
    ImGuiColorEditFlags_NoLabel          :: NoLabel;
    ImGuiColorEditFlags_NoSidePreview    :: NoSidePreview;
    ImGuiColorEditFlags_NoDragDrop       :: NoDragDrop;
    ImGuiColorEditFlags_NoBorder         :: NoBorder;
    ImGuiColorEditFlags_NoColorMarkers   :: NoColorMarkers;

    ImGuiColorEditFlags_AlphaOpaque      :: AlphaOpaque;
    ImGuiColorEditFlags_AlphaNoBg        :: AlphaNoBg;
    ImGuiColorEditFlags_AlphaPreviewHalf :: AlphaPreviewHalf;

    ImGuiColorEditFlags_AlphaBar         :: AlphaBar;
    ImGuiColorEditFlags_HDR              :: HDR;
    ImGuiColorEditFlags_DisplayRGB       :: DisplayRGB;
    ImGuiColorEditFlags_DisplayHSV       :: DisplayHSV;
    ImGuiColorEditFlags_DisplayHex       :: DisplayHex;
    ImGuiColorEditFlags_Uint8            :: Uint8;
    ImGuiColorEditFlags_Float            :: Float;
    ImGuiColorEditFlags_PickerHueBar     :: PickerHueBar;
    ImGuiColorEditFlags_PickerHueWheel   :: PickerHueWheel;
    ImGuiColorEditFlags_PickerNoRotate   :: PickerNoRotate;
    ImGuiColorEditFlags_InputRGB         :: InputRGB;
    ImGuiColorEditFlags_InputHSV         :: InputHSV;

    ImGuiColorEditFlags_DefaultOptions_  :: DefaultOptions_;

    ImGuiColorEditFlags_AlphaMask_       :: AlphaMask_;
    ImGuiColorEditFlags_DisplayMask_     :: DisplayMask_;
    ImGuiColorEditFlags_DataTypeMask_    :: DataTypeMask_;
    ImGuiColorEditFlags_PickerMask_      :: PickerMask_;
    ImGuiColorEditFlags_InputMask_       :: InputMask_;

    ImGuiColorEditFlags_AlphaPreview     :: AlphaPreview;
}

// Flags for DragFloat(), DragInt(), SliderFloat(), SliderInt() etc.
// We use the same sets of flags for DragXXX() and SliderXXX() functions as the features are the same and it makes it easier to swap them.
// (Those are per-item flags. There is shared behavior flag too: ImGuiIO: io.ConfigDragClickToInputText)
ImGuiSliderFlags_ :: enum u32 {
    None            :: 0;
    Logarithmic     :: 32;
    NoRoundToFormat :: 64;
    NoInput         :: 128;
    WrapAround      :: 256;
    ClampOnInput    :: 512;
    ClampZeroRange  :: 1024;
    NoSpeedTweaks   :: 2048;
    ColorMarkers    :: 4096;
    AlwaysClamp     :: 1536;

    InvalidMask_    :: 1879048207;

    ImGuiSliderFlags_None            :: None;
    ImGuiSliderFlags_Logarithmic     :: Logarithmic;
    ImGuiSliderFlags_NoRoundToFormat :: NoRoundToFormat;
    ImGuiSliderFlags_NoInput         :: NoInput;
    ImGuiSliderFlags_WrapAround      :: WrapAround;
    ImGuiSliderFlags_ClampOnInput    :: ClampOnInput;
    ImGuiSliderFlags_ClampZeroRange  :: ClampZeroRange;
    ImGuiSliderFlags_NoSpeedTweaks   :: NoSpeedTweaks;
    ImGuiSliderFlags_ColorMarkers    :: ColorMarkers;
    ImGuiSliderFlags_AlwaysClamp     :: AlwaysClamp;

    ImGuiSliderFlags_InvalidMask_    :: InvalidMask_;
}

// Identify a mouse button.
// Those values are guaranteed to be stable and we frequently use 0/1 directly. Named enums provided for convenience.
ImGuiMouseButton_ :: enum u32 {
    Left   :: 0;
    Right  :: 1;
    Middle :: 2;
    COUNT  :: 5;

    ImGuiMouseButton_Left   :: Left;
    ImGuiMouseButton_Right  :: Right;
    ImGuiMouseButton_Middle :: Middle;
    ImGuiMouseButton_COUNT  :: COUNT;
}

// Enumeration for GetMouseCursor()
// User code may request backend to display given cursor by calling SetMouseCursor(), which is why we have some cursors that are marked unused here
ImGuiMouseCursor_ :: enum s32 {
    None       :: -1;
    Arrow      :: 0;
    TextInput  :: 1;
    ResizeAll  :: 2;
    ResizeNS   :: 3;
    ResizeEW   :: 4;
    ResizeNESW :: 5;
    ResizeNWSE :: 6;
    Hand       :: 7;
    Wait       :: 8;
    Progress   :: 9;
    NotAllowed :: 10;
    COUNT      :: 11;

    ImGuiMouseCursor_None       :: None;
    ImGuiMouseCursor_Arrow      :: Arrow;
    ImGuiMouseCursor_TextInput  :: TextInput;
    ImGuiMouseCursor_ResizeAll  :: ResizeAll;
    ImGuiMouseCursor_ResizeNS   :: ResizeNS;
    ImGuiMouseCursor_ResizeEW   :: ResizeEW;
    ImGuiMouseCursor_ResizeNESW :: ResizeNESW;
    ImGuiMouseCursor_ResizeNWSE :: ResizeNWSE;
    ImGuiMouseCursor_Hand       :: Hand;
    ImGuiMouseCursor_Wait       :: Wait;
    ImGuiMouseCursor_Progress   :: Progress;
    ImGuiMouseCursor_NotAllowed :: NotAllowed;
    ImGuiMouseCursor_COUNT      :: COUNT;
}

// Enumeration for ImGui::SetNextWindow***(), SetWindow***(), SetNextItem***() functions
// Represent a condition.
// Important: Treat as a regular enum! Do NOT combine multiple values using binary operators! All the functions above treat 0 as a shortcut to ImGuiCond_Always.
ImGuiCond_ :: enum u32 {
    None         :: 0;
    Always       :: 1;
    Once         :: 2;
    FirstUseEver :: 4;
    Appearing    :: 8;

    ImGuiCond_None         :: None;
    ImGuiCond_Always       :: Always;
    ImGuiCond_Once         :: Once;
    ImGuiCond_FirstUseEver :: FirstUseEver;
    ImGuiCond_Appearing    :: Appearing;
}

// Flags for ImGui::BeginTable()
// - Important! Sizing policies have complex and subtle side effects, much more so than you would expect.
//   Read comments/demos carefully + experiment with live demos to get acquainted with them.
// - The DEFAULT sizing policies are:
//    - Default to ImGuiTableFlags_SizingFixedFit    if ScrollX is on, or if host window has ImGuiWindowFlags_AlwaysAutoResize.
//    - Default to ImGuiTableFlags_SizingStretchSame if ScrollX is off.
// - When ScrollX is off:
//    - Table defaults to ImGuiTableFlags_SizingStretchSame -> all Columns defaults to ImGuiTableColumnFlags_WidthStretch with same weight.
//    - Columns sizing policy allowed: Stretch (default), Fixed/Auto.
//    - Fixed Columns (if any) will generally obtain their requested width (unless the table cannot fit them all).
//    - Stretch Columns will share the remaining width according to their respective weight.
//    - Mixed Fixed/Stretch columns is possible but has various side-effects on resizing behaviors.
//      The typical use of mixing sizing policies is: any number of LEADING Fixed columns, followed by one or two TRAILING Stretch columns.
//      (this is because the visible order of columns have subtle but necessary effects on how they react to manual resizing).
// - When ScrollX is on:
//    - Table defaults to ImGuiTableFlags_SizingFixedFit -> all Columns defaults to ImGuiTableColumnFlags_WidthFixed
//    - Columns sizing policy allowed: Fixed/Auto mostly.
//    - Fixed Columns can be enlarged as needed. Table will show a horizontal scrollbar if needed.
//    - When using auto-resizing (non-resizable) fixed columns, querying the content width to use item right-alignment e.g. SetNextItemWidth(-FLT_MIN) doesn't make sense, would create a feedback loop.
//    - Using Stretch columns OFTEN DOES NOT MAKE SENSE if ScrollX is on, UNLESS you have specified a value for 'inner_width' in BeginTable().
//      If you specify a value for 'inner_width' then effectively the scrolling space is known and Stretch or mixed Fixed/Stretch columns become meaningful again.
// - Read on documentation at the top of imgui_tables.cpp for details.
ImGuiTableFlags_ :: enum u32 {
    None                       :: 0;
    Resizable                  :: 1;
    Reorderable                :: 2;
    Hideable                   :: 4;
    Sortable                   :: 8;
    NoSavedSettings            :: 16;
    ContextMenuInBody          :: 32;

    RowBg                      :: 64;
    BordersInnerH              :: 128;
    BordersOuterH              :: 256;
    BordersInnerV              :: 512;
    BordersOuterV              :: 1024;
    BordersH                   :: 384;
    BordersV                   :: 1536;
    BordersInner               :: 640;
    BordersOuter               :: 1280;
    Borders                    :: 1920;
    NoBordersInBody            :: 2048;
    NoBordersInBodyUntilResize :: 4096;

    SizingFixedFit             :: 8192;
    SizingFixedSame            :: 16384;
    SizingStretchProp          :: 24576;
    SizingStretchSame          :: 32768;

    NoHostExtendX              :: 65536;
    NoHostExtendY              :: 131072;
    NoKeepColumnsVisible       :: 262144;
    PreciseWidths              :: 524288;

    NoClip                     :: 1048576;

    PadOuterX                  :: 2097152;
    NoPadOuterX                :: 4194304;
    NoPadInnerX                :: 8388608;

    ScrollX                    :: 16777216;
    ScrollY                    :: 33554432;

    SortMulti                  :: 67108864;
    SortTristate               :: 134217728;

    HighlightHoveredColumn     :: 268435456;

    SizingMask_                :: 57344;

    ImGuiTableFlags_None                       :: None;
    ImGuiTableFlags_Resizable                  :: Resizable;
    ImGuiTableFlags_Reorderable                :: Reorderable;
    ImGuiTableFlags_Hideable                   :: Hideable;
    ImGuiTableFlags_Sortable                   :: Sortable;
    ImGuiTableFlags_NoSavedSettings            :: NoSavedSettings;
    ImGuiTableFlags_ContextMenuInBody          :: ContextMenuInBody;

    ImGuiTableFlags_RowBg                      :: RowBg;
    ImGuiTableFlags_BordersInnerH              :: BordersInnerH;
    ImGuiTableFlags_BordersOuterH              :: BordersOuterH;
    ImGuiTableFlags_BordersInnerV              :: BordersInnerV;
    ImGuiTableFlags_BordersOuterV              :: BordersOuterV;
    ImGuiTableFlags_BordersH                   :: BordersH;
    ImGuiTableFlags_BordersV                   :: BordersV;
    ImGuiTableFlags_BordersInner               :: BordersInner;
    ImGuiTableFlags_BordersOuter               :: BordersOuter;
    ImGuiTableFlags_Borders                    :: Borders;
    ImGuiTableFlags_NoBordersInBody            :: NoBordersInBody;
    ImGuiTableFlags_NoBordersInBodyUntilResize :: NoBordersInBodyUntilResize;

    ImGuiTableFlags_SizingFixedFit             :: SizingFixedFit;
    ImGuiTableFlags_SizingFixedSame            :: SizingFixedSame;
    ImGuiTableFlags_SizingStretchProp          :: SizingStretchProp;
    ImGuiTableFlags_SizingStretchSame          :: SizingStretchSame;

    ImGuiTableFlags_NoHostExtendX              :: NoHostExtendX;
    ImGuiTableFlags_NoHostExtendY              :: NoHostExtendY;
    ImGuiTableFlags_NoKeepColumnsVisible       :: NoKeepColumnsVisible;
    ImGuiTableFlags_PreciseWidths              :: PreciseWidths;

    ImGuiTableFlags_NoClip                     :: NoClip;

    ImGuiTableFlags_PadOuterX                  :: PadOuterX;
    ImGuiTableFlags_NoPadOuterX                :: NoPadOuterX;
    ImGuiTableFlags_NoPadInnerX                :: NoPadInnerX;

    ImGuiTableFlags_ScrollX                    :: ScrollX;
    ImGuiTableFlags_ScrollY                    :: ScrollY;

    ImGuiTableFlags_SortMulti                  :: SortMulti;
    ImGuiTableFlags_SortTristate               :: SortTristate;

    ImGuiTableFlags_HighlightHoveredColumn     :: HighlightHoveredColumn;

    ImGuiTableFlags_SizingMask_                :: SizingMask_;
}

// Flags for ImGui::TableSetupColumn()
ImGuiTableColumnFlags_ :: enum u32 {
    None                 :: 0;
    Disabled             :: 1;
    DefaultHide          :: 2;
    DefaultSort          :: 4;
    WidthStretch         :: 8;
    WidthFixed           :: 16;
    NoResize             :: 32;
    NoReorder            :: 64;
    NoHide               :: 128;
    NoClip               :: 256;
    NoSort               :: 512;
    NoSortAscending      :: 1024;
    NoSortDescending     :: 2048;
    NoHeaderLabel        :: 4096;
    NoHeaderWidth        :: 8192;
    PreferSortAscending  :: 16384;
    PreferSortDescending :: 32768;
    IndentEnable         :: 65536;
    IndentDisable        :: 131072;
    AngledHeader         :: 262144;

    IsEnabled            :: 16777216;
    IsVisible            :: 33554432;
    IsSorted             :: 67108864;
    IsHovered            :: 134217728;

    WidthMask_           :: 24;
    IndentMask_          :: 196608;
    StatusMask_          :: 251658240;
    NoDirectResize_      :: 1073741824;

    ImGuiTableColumnFlags_None                 :: None;
    ImGuiTableColumnFlags_Disabled             :: Disabled;
    ImGuiTableColumnFlags_DefaultHide          :: DefaultHide;
    ImGuiTableColumnFlags_DefaultSort          :: DefaultSort;
    ImGuiTableColumnFlags_WidthStretch         :: WidthStretch;
    ImGuiTableColumnFlags_WidthFixed           :: WidthFixed;
    ImGuiTableColumnFlags_NoResize             :: NoResize;
    ImGuiTableColumnFlags_NoReorder            :: NoReorder;
    ImGuiTableColumnFlags_NoHide               :: NoHide;
    ImGuiTableColumnFlags_NoClip               :: NoClip;
    ImGuiTableColumnFlags_NoSort               :: NoSort;
    ImGuiTableColumnFlags_NoSortAscending      :: NoSortAscending;
    ImGuiTableColumnFlags_NoSortDescending     :: NoSortDescending;
    ImGuiTableColumnFlags_NoHeaderLabel        :: NoHeaderLabel;
    ImGuiTableColumnFlags_NoHeaderWidth        :: NoHeaderWidth;
    ImGuiTableColumnFlags_PreferSortAscending  :: PreferSortAscending;
    ImGuiTableColumnFlags_PreferSortDescending :: PreferSortDescending;
    ImGuiTableColumnFlags_IndentEnable         :: IndentEnable;
    ImGuiTableColumnFlags_IndentDisable        :: IndentDisable;
    ImGuiTableColumnFlags_AngledHeader         :: AngledHeader;

    ImGuiTableColumnFlags_IsEnabled            :: IsEnabled;
    ImGuiTableColumnFlags_IsVisible            :: IsVisible;
    ImGuiTableColumnFlags_IsSorted             :: IsSorted;
    ImGuiTableColumnFlags_IsHovered            :: IsHovered;

    ImGuiTableColumnFlags_WidthMask_           :: WidthMask_;
    ImGuiTableColumnFlags_IndentMask_          :: IndentMask_;
    ImGuiTableColumnFlags_StatusMask_          :: StatusMask_;
    ImGuiTableColumnFlags_NoDirectResize_      :: NoDirectResize_;
}

// Flags for ImGui::TableNextRow()
ImGuiTableRowFlags_ :: enum u32 {
    None    :: 0;
    Headers :: 1;

    ImGuiTableRowFlags_None    :: None;
    ImGuiTableRowFlags_Headers :: Headers;
}

// Enum for ImGui::TableSetBgColor()
// Background colors are rendering in 3 layers:
//  - Layer 0: draw with RowBg0 color if set, otherwise draw with ColumnBg0 if set.
//  - Layer 1: draw with RowBg1 color if set, otherwise draw with ColumnBg1 if set.
//  - Layer 2: draw with CellBg color if set.
// The purpose of the two row/columns layers is to let you decide if a background color change should override or blend with the existing color.
// When using ImGuiTableFlags_RowBg on the table, each row has the RowBg0 color automatically set for odd/even rows.
// If you set the color of RowBg0 target, your color will override the existing RowBg0 color.
// If you set the color of RowBg1 or ColumnBg1 target, your color will blend over the RowBg0 color.
ImGuiTableBgTarget_ :: enum u32 {
    None   :: 0;
    RowBg0 :: 1;
    RowBg1 :: 2;
    CellBg :: 3;

    ImGuiTableBgTarget_None   :: None;
    ImGuiTableBgTarget_RowBg0 :: RowBg0;
    ImGuiTableBgTarget_RowBg1 :: RowBg1;
    ImGuiTableBgTarget_CellBg :: CellBg;
}

// Sorting specifications for a table (often handling sort specs for a single column, occasionally more)
// Obtained by calling TableGetSortSpecs().
// When 'SpecsDirty == true' you can sort your data. It will be true with sorting specs have changed since last call, or the first time.
// Make sure to set 'SpecsDirty = false' after sorting, else you may wastefully sort your data every frame!
ImGuiTableSortSpecs :: struct {
    Specs:      *ImGuiTableColumnSortSpecs; // Pointer to sort spec array.
    SpecsCount: s32; // Sort spec count. Most often 1. May be > 1 when ImGuiTableFlags_SortMulti is enabled. May be == 0 when ImGuiTableFlags_SortTristate is enabled.
    SpecsDirty: bool; // Set to true when specs have changed since last time! Use this to sort again, then clear the flag.
}

// Sorting specification for one column of a table (sizeof == 12 bytes)
ImGuiTableColumnSortSpecs :: struct {
    ColumnUserID:  ImGuiID; // User data for the column (if specified by a TableSetupColumn() call in the 'ImGuiID user_data' field). FIXME: Should be called 'UserData'..
    ColumnIndex:   ImS16; // Index of the column
    SortOrder:     ImS16; // Index within parent ImGuiTableSortSpecs (always stored in order starting from 0, tables sorted on a single criteria will always have a 0 here)
    SortDirection: ImGuiSortDirection; // ImGuiSortDirection_Ascending or ImGuiSortDirection_Descending
}

//-----------------------------------------------------------------------------
// IM_MALLOC(), IM_FREE(), IM_NEW(), IM_PLACEMENT_NEW(), IM_DELETE()
// We call C++ constructor on own allocated memory via the placement "new(ptr) Type()" syntax.
// Defining a custom placement new() with a custom parameter allows us to bypass including <new> which on some platforms complains when user has disabled exceptions.
//-----------------------------------------------------------------------------
ImNewWrapper :: struct {
    __empty_struct_padding: u8; // C++ makes empty structs have length 1
}

//-----------------------------------------------------------------------------
// ImVector<>
// Lightweight std::vector<>-like class to avoid dragging dependencies (also, some implementations of STL with debug enabled are absurdly slow, we bypass it so our code runs fast in debug).
//-----------------------------------------------------------------------------
// - You generally do NOT need to care or use this ever. But we need to make it available in imgui.h because some of our public structures are relying on it.
// - We use std-like naming convention here, which is a little unusual for this codebase.
// - Important: clear() frees memory, resize(0) keep the allocated buffer. We use resize(0) a lot to intentionally recycle allocated buffers across frames and amortize our costs.
// - Important: our implementation does NOT call C++ constructors/destructors, we treat everything as raw data! This is intentional but be extra mindful of that,
//   Do NOT use this class as a std::vector replacement in your own code! Many of the structures used by dear imgui can be safely initialized by a zero-memset.
//-----------------------------------------------------------------------------
ImVector :: struct(T: Type) {
    Size:           s32;
    Capacity:       s32;
    Data:           *T;

    // Provide standard typedefs but we don't use them ourselves.
    value_type :: T;
    iterator :: *value_type;
    const_iterator :: *value_type;
}

//-----------------------------------------------------------------------------
// [SECTION] ImGuiStyle
//-----------------------------------------------------------------------------
// You may modify the ImGui::GetStyle() main instance during initialization and before NewFrame().
// During the frame, use ImGui::PushStyleVar(ImGuiStyleVar_XXXX)/PopStyleVar() to alter the main style values,
// and ImGui::PushStyleColor(ImGuiCol_XXX)/PopStyleColor() for colors.
//-----------------------------------------------------------------------------
ImGuiStyle :: struct {
    FontSizeBase:                     float; // Current base font size before external global factors are applied. Use PushFont(NULL, size) to modify. Use ImGui::GetFontSize() to obtain scaled value.
    FontScaleMain:                    float; // Main global scale factor. May be set by application once, or exposed to end-user.
    FontScaleDpi:                     float; // Additional global scale factor from viewport/monitor contents scale. In docking branch: when io.ConfigDpiScaleFonts is enabled, this is automatically overwritten when changing monitor DPI.

    Alpha:                            float; // Global alpha applies to everything in Dear ImGui.
    DisabledAlpha:                    float; // Additional alpha multiplier applied by BeginDisabled(). Multiply over current value of Alpha.
    WindowPadding:                    ImVec2; // Padding within a window.
    WindowRounding:                   float; // Radius of window corners rounding. Set to 0.0f to have rectangular windows. Large values tend to lead to variety of artifacts and are not recommended.
    WindowBorderSize:                 float; // Thickness of border around windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    WindowBorderHoverPadding:         float; // Hit-testing extent outside/inside resizing border. Also extend determination of hovered window. Generally meaningfully larger than WindowBorderSize to make it easy to reach borders.
    WindowMinSize:                    ImVec2; // Minimum window size. This is a global setting. If you want to constrain individual windows, use SetNextWindowSizeConstraints().
    WindowTitleAlign:                 ImVec2; // Alignment for title bar text. Defaults to (0.0f,0.5f) for left-aligned,vertically centered.
    WindowMenuButtonPosition:         ImGuiDir; // Side of the collapsing/docking button in the title bar (None/Left/Right). Defaults to ImGuiDir_Left.
    ChildRounding:                    float; // Radius of child window corners rounding. Set to 0.0f to have rectangular windows.
    ChildBorderSize:                  float; // Thickness of border around child windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    PopupRounding:                    float; // Radius of popup window corners rounding. (Note that tooltip windows use WindowRounding)
    PopupBorderSize:                  float; // Thickness of border around popup/tooltip windows. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    FramePadding:                     ImVec2; // Padding within a framed rectangle (used by most widgets).
    FrameRounding:                    float; // Radius of frame corners rounding. Set to 0.0f to have rectangular frame (used by most widgets).
    FrameBorderSize:                  float; // Thickness of border around frames. Generally set to 0.0f or 1.0f. (Other values are not well tested and more CPU/GPU costly).
    ItemSpacing:                      ImVec2; // Horizontal and vertical spacing between widgets/lines.
    ItemInnerSpacing:                 ImVec2; // Horizontal and vertical spacing between within elements of a composed widget (e.g. a slider and its label).
    CellPadding:                      ImVec2; // Padding within a table cell. Cellpadding.x is locked for entire table. CellPadding.y may be altered between different rows.
    TouchExtraPadding:                ImVec2; // Expand reactive bounding box for touch-based system where touch position is not accurate enough. Unfortunately we don't sort widgets so priority on overlap will always be given to the first widget. So don't grow this too much!
    IndentSpacing:                    float; // Horizontal indentation when e.g. entering a tree node. Generally == (FontSize + FramePadding.x*2).
    ColumnsMinSpacing:                float; // Minimum horizontal spacing between two columns. Preferably > (FramePadding.x + 1).
    ScrollbarSize:                    float; // Width of the vertical scrollbar, Height of the horizontal scrollbar.
    ScrollbarRounding:                float; // Radius of grab corners for scrollbar.
    ScrollbarPadding:                 float; // Padding of scrollbar grab within its frame (same for both axes).
    GrabMinSize:                      float; // Minimum width/height of a grab box for slider/scrollbar.
    GrabRounding:                     float; // Radius of grabs corners rounding. Set to 0.0f to have rectangular slider grabs.
    LogSliderDeadzone:                float; // The size in pixels of the dead-zone around zero on logarithmic sliders that cross zero.
    ImageRounding:                    float; // Rounding of Image() calls.
    ImageBorderSize:                  float; // Thickness of border around Image() calls.
    TabRounding:                      float; // Radius of upper corners of a tab. Set to 0.0f to have rectangular tabs.
    TabBorderSize:                    float; // Thickness of border around tabs.
    TabMinWidthBase:                  float; // Minimum tab width, to make tabs larger than their contents. TabBar buttons are not affected.
    TabMinWidthShrink:                float; // Minimum tab width after shrinking, when using ImGuiTabBarFlags_FittingPolicyMixed policy.
    TabCloseButtonMinWidthSelected:   float; // -1: always visible. 0.0f: visible when hovered. >0.0f: visible when hovered if minimum width. FLT_MAX: never shrink, will behave like ImGuiTabBarFlags_FittingPolicyScroll.
    TabCloseButtonMinWidthUnselected: float; // -1: always visible. 0.0f: visible when hovered. >0.0f: visible when hovered if minimum width. FLT_MAX: never show close button when unselected.
    TabBarBorderSize:                 float; // Thickness of tab-bar separator, which takes on the tab active color to denote focus.
    TabBarOverlineSize:               float; // Thickness of tab-bar overline, which highlights the selected tab-bar.
    TableAngledHeadersAngle:          float; // Angle of angled headers (supported values range from -50.0f degrees to +50.0f degrees).
    TableAngledHeadersTextAlign:      ImVec2; // Alignment of angled headers within the cell
    TreeLinesFlags:                   ImGuiTreeNodeFlags; // Default way to draw lines connecting TreeNode hierarchy. ImGuiTreeNodeFlags_DrawLinesNone or ImGuiTreeNodeFlags_DrawLinesFull or ImGuiTreeNodeFlags_DrawLinesToNodes.
    TreeLinesSize:                    float; // Thickness of outlines when using ImGuiTreeNodeFlags_DrawLines.
    TreeLinesRounding:                float; // Radius of lines connecting child nodes to the vertical line.
    MenuItemRounding:                 float; // Radius of MenuItem, BeginMenu rounding.
    SelectableRounding:               float; // Radius of Selectable rounding. MODIFYING THIS IS DISCOURAGED. CONTIGUOUS SELECTIONS WILL NOT LOOK RIGHT. (#7589)
    DragDropTargetRounding:           float; // Radius of the drag and drop target frame. When <0.0f: use FrameRounding.
    DragDropTargetBorderSize:         float; // Thickness of the drag and drop target border.
    DragDropTargetPadding:            float; // Size to expand the drag and drop target from actual target item size.
    ColorMarkerSize:                  float; // Size of R/G/B/A color markers for ColorEdit4() and for Drags/Sliders when using ImGuiSliderFlags_ColorMarkers.
    ColorButtonPosition:              ImGuiDir; // Side of the color button in the ColorEdit4 widget (left/right). Defaults to ImGuiDir_Right.
    ButtonTextAlign:                  ImVec2; // Alignment of button text when button is larger than text. Defaults to (0.5f, 0.5f) (centered).
    SelectableTextAlign:              ImVec2; // Alignment of selectable text. Defaults to (0.0f, 0.0f) (top-left aligned). It's generally important to keep this left-aligned if you want to lay multiple items on a same line.
    InputTextCursorSize:              float; // Thickness of cursor/caret in InputText().
    SeparatorSize:                    float; // Thickness of border in Separator(). Must be >= 1.0f.
    SeparatorTextBorderSize:          float; // Thickness of border in SeparatorText()
    SeparatorTextAlign:               ImVec2; // Alignment of text within the separator. Defaults to (0.0f, 0.5f) (left aligned, center).
    SeparatorTextPadding:             ImVec2; // Horizontal offset of text from each edge of the separator + spacing on other axis. Generally small values. .y is recommended to be == FramePadding.y.
    DisplayWindowPadding:             ImVec2; // Apply to regular windows: amount which we enforce to keep visible when moving near edges of your screen.
    DisplaySafeAreaPadding:           ImVec2; // Apply to every windows, menus, popups, tooltips: amount where we avoid displaying contents. Adjust if you cannot see the edges of your screen (e.g. on a TV where scaling has not been configured).
    MouseCursorScale:                 float; // Scale software rendered mouse cursor (when io.MouseDrawCursor is enabled). We apply per-monitor DPI scaling over this scale. May be removed later.

    SymbolArrowSizeFactor:            ImVec2; // Width/height factor of arrows (0.0f..1.0f).
    SymbolArrowThicknessFactor:       float; // Thickness factor of arrows (0.0f..0.5f). 0.0f=Fill. >0.0f=Stroke.

    AntiAliasedLines:                 bool; // Enable anti-aliased lines/borders. Used at the beginning of the frame to set ImDrawFlags_AALines in all draw-lists.
    AntiAliasedLineEnds:              bool; // Enable anti-aliased lines/borders ends. Nicer for thick lines but more expensive. Used at the beginning of the frame to set ImDrawFlags_AALineEnds in all draw-lists.
    AntiAliasedFill:                  bool; // Enable anti-aliased edges around filled shapes (rounded rectangles, circles, etc.). Used at the beginning of the frame to set ImDrawFlags_AAFill in all draw-lists.
    CurveTessellationMaxError:        float; // Maximum error (in pixels) when using PathBezierCurveTo() without a specific number of segments. Decrease for highly tessellated curves (higher quality, more polygons), increase to reduce quality.
    CircleTessellationMaxError:       float; // Maximum error (in pixels) allowed when using AddCircle()/AddCircleFilled() or drawing rounded corner rectangles with no explicit segment count specified. Decrease for higher quality but more geometry.

    // Colors
    Colors:                           [61] ImVec4;

    HoverStationaryDelay:             float; // Delay for IsItemHovered(ImGuiHoveredFlags_Stationary). Time required to consider mouse stationary.
    HoverDelayShort:                  float; // Delay for IsItemHovered(ImGuiHoveredFlags_DelayShort). Usually used along with HoverStationaryDelay.
    HoverDelayNormal:                 float; // Delay for IsItemHovered(ImGuiHoveredFlags_DelayNormal). "
    HoverFlagsForTooltipMouse:        ImGuiHoveredFlags; // Default flags when using IsItemHovered(ImGuiHoveredFlags_ForTooltip) or BeginItemTooltip()/SetItemTooltip() while using mouse.
    HoverFlagsForTooltipNav:          ImGuiHoveredFlags; // Default flags when using IsItemHovered(ImGuiHoveredFlags_ForTooltip) or BeginItemTooltip()/SetItemTooltip() while using keyboard/gamepad.

    _MainScale:                       float; // FIXME-WIP: Reference scale, as applied by ScaleAllSizes(). PLEASE DO NOT USE THIS FOR NOW.
    _NextFrameFontSizeBase:           float; // FIXME: Temporary hack until we finish remaining work.

    // Functions
    Constructor :: (this: *ImGuiStyle) -> void #cpp_method #foreign libimgui "_ZN10ImGuiStyleC1Ev";
    ScaleAllSizes :: (this: *ImGuiStyle, scale_factor: float) -> void #cpp_method #foreign libimgui "_ZN10ImGuiStyle13ScaleAllSizesEf";

    AntiAliasedLinesUseTex:           bool; // [OBSOLETE] Enable anti-aliased lines/borders using textures for legacy strokes. Require backend to render with bilinear filtering (NOT point/nearest filtering). Latched at the beginning of the frame (copied to ImDrawList).
    CurveTessellationTol:             float; // [OBSOLETE] Old CurveTessellationTol = New CurveTessellationMaxError*CurveTessellationMaxError. // Changed in 1.93.0
}

// [Internal] Storage used by IsKeyDown(), IsKeyPressed() etc functions.
// If prior to 1.87 you used io.KeysDownDuration[] (which was marked as internal), you should use GetKeyData(key)->DownDuration and *NOT* io.KeysData[key]->DownDuration.
ImGuiKeyData :: struct {
    Down:             bool; // True for if key is down
    DownDuration:     float; // Duration the key has been down (<0.0f: not pressed, 0.0f: just pressed, >0.0f: time held)
    DownDurationPrev: float; // Last frame duration the key has been down
    AnalogValue:      float; // 0.0f..1.0f for gamepad values
}

ImGuiIO :: struct {
    ConfigFlags:                                   ImGuiConfigFlags; // = 0              // See ImGuiConfigFlags_ enum. Set by user/application. Keyboard/Gamepad navigation options, etc.
    BackendFlags:                                  ImGuiBackendFlags; // = 0              // See ImGuiBackendFlags_ enum. Set by backend (imgui_impl_xxx files or custom backend) to communicate features supported by the backend.
    DisplaySize:                                   ImVec2; // <unset>          // Main display size, in pixels (== GetMainViewport()->Size). May change every frame.
    DisplayFramebufferScale:                       ImVec2; // = (1, 1)         // Main display density. For retina display where window coordinates are different from framebuffer coordinates. This will affect font density + will end up in ImDrawData::FramebufferScale.
    DeltaTime:                                     float; // = 1.0f/60.0f     // Time elapsed since last frame, in seconds. May change every frame.
    IniSavingRate:                                 float; // = 5.0f           // Minimum time between saving positions/sizes to .ini file, in seconds.
    IniFilename:                                   *u8; // = "imgui.ini"    // Path to .ini file (important: default "imgui.ini" is relative to current working dir!). Set NULL to disable automatic .ini loading/saving or if you want to manually call LoadIniSettingsXXX() / SaveIniSettingsXXX() functions.
    LogFilename:                                   *u8; // = "imgui_log.txt"// Path to .log file (default parameter to ImGui::LogToFile when no file is specified).
    UserData:                                      *void; // = NULL           // Store your own data.

    Fonts:                                         *ImFontAtlas; // <auto>           // Font atlas: load, rasterize and pack one or more fonts into a single texture.
    FontDefault:                                   *ImFont; // = NULL           // Font to use on NewFrame(). Use NULL to uses Fonts->Fonts[0].
    FontAllowUserScaling:                          bool; // = false          // Allow user scaling text of individual window with Ctrl+Wheel.

    ConfigNavSwapGamepadButtons:                   bool; // = false          // Swap Activate<>Cancel (A<>B) buttons, matching typical "Nintendo/Japanese style" gamepad layout.
    ConfigNavMoveSetMousePos:                      bool; // = false          // Directional/tabbing navigation teleports the mouse cursor. May be useful on TV/console systems where moving a virtual mouse is difficult. Will update io.MousePos and set io.WantSetMousePos=true.
    ConfigNavCaptureKeyboard:                      bool; // = true           // Sets io.WantCaptureKeyboard when io.NavActive is set.
    ConfigNavEscapeClearFocusItem:                 bool; // = true           // Pressing Escape can clear focused item + navigation id/highlight. Set to false if you want to always keep highlight on.
    ConfigNavEscapeClearFocusWindow:               bool; // = false          // Pressing Escape can clear focused window as well (super set of io.ConfigNavEscapeClearFocusItem).
    ConfigNavCursorVisibleAuto:                    bool; // = true           // Using directional navigation key makes the cursor visible. Mouse click hides the cursor.
    ConfigNavCursorVisibleAlways:                  bool; // = false          // Navigation cursor is always visible.

    ConfigMacOSXBehaviors:                         bool; // = defined(__APPLE__) // Swap Cmd<>Ctrl keys + OS X style text editing cursor movement using Alt instead of Ctrl, Shortcuts using Cmd/Super instead of Ctrl, Line/Text Start and End using Cmd+Arrows instead of Home/End, Double click selects by word instead of selecting whole text, Multi-selection in lists uses Cmd/Super instead of Ctrl.
    ConfigInputTrickleEventQueue:                  bool; // = true           // Enable input queue trickling: some types of events submitted during the same frame (e.g. button down + up) will be spread over multiple frames, improving interactions with low framerates.
    ConfigInputTextCursorBlink:                    bool; // = true           // Enable blinking cursor (optional as some users consider it to be distracting).
    ConfigInputTextEnterKeepActive:                bool; // = false          // [BETA] Pressing Enter will reactivate item and select all text (single-line only). Ctrl+Enter or Shift+Enter will deactivate normally.
    ConfigColorEditFlags:                          ImGuiColorEditFlags; // = <defaults>     // Current settings for ColorEdit/ColorPicker widgets. Must have one bit of ImGuiColorEditFlags_DisplayMask_, one bit of ImGuiColorEditFlags_DataTypeMask_, one bit of ImGuiColorEditFlags_PickerMask_, one bit of ImGuiColorEditFlags_InputMask_. Defaults to ImGuiColorEditFlags_DefaultOptions_. May be further edited by users, unless you also set ImGuiColorEditFlags_NoOptions.
    ConfigDragClickToInputText:                    bool; // = false          // [BETA] Enable turning DragXXX widgets into text input with a simple mouse click-release (without moving). Not desirable on devices without a keyboard.
    ConfigWindowsResizeFromEdges:                  bool; // = true           // Enable resizing of windows from their edges and from the lower-left corner. This requires ImGuiBackendFlags_HasMouseCursors for better mouse cursor feedback. (This used to be a per-window ImGuiWindowFlags_ResizeFromAnySide flag)
    ConfigWindowsMoveFromTitleBarOnly:             bool; // = false      // Enable allowing to move windows only when clicking on their title bar. Does not apply to windows without a title bar.
    ConfigWindowsCopyContentsWithCtrlC:            bool; // = false      // [EXPERIMENTAL] Ctrl+C copy the contents of focused window into the clipboard. Experimental because: (1) has known issues with nested Begin/End pairs (2) text output quality varies (3) text output is in submission order rather than spatial order.
    ConfigScrollbarScrollByPage:                   bool; // = true           // Enable scrolling page by page when clicking outside the scrollbar grab. When disabled, always scroll to clicked location. When enabled, Shift+Click scrolls to clicked location.

    ConfigIniSettingsSaveLastUsedDate:             bool; // = true         // Enable loading/saving last used day (YYYYMMDD) in some .ini struct, making things easier to audit and allowing custom tools to cleanup old data.
    ConfigIniSettingsAutoDiscardMonths:            s32; // = 0          // [BETA] Set number of months after which unused .ini entries are discarded on load. Require platform_io.Platform_SessionDate to be set. For systems supporting the feature, .ini entries without a LastUsed field will always be discarded! Please report if you are using this.
    ConfigDebugIniSettings:                        bool; // = false          // Save .ini data with extra comments (particularly helpful for Docking, but makes saving slower)

    MouseDrawCursor:                               bool; // = false          // Request ImGui to draw a mouse cursor for you (if you are on a platform without a mouse cursor). Cannot be easily renamed to 'io.ConfigXXX' because this is frequently used by backend implementations.
    ConfigMemoryCompactTimer:                      float; // = 60.0f          // Timer (in seconds) to free transient windows/tables memory buffers when unused. Set to -1.0f to disable.

    MouseDoubleClickTime:                          float; // = 0.30f          // Time for consecutive clicks to account as a double-click, in seconds.
    MouseDoubleClickMaxDist:                       float; // = 6.0f           // Distance threshold to stay in to validate a double-click or multiple clicks, in pixels.
    MouseSingleClickDelay:                         float; // = 0.60f          // Time for a delayed click when using GetItemClickedCountWithSingleClickDelay() or IsMouseReleasedWithDelay(), in seconds. Must be > io.MouseDoubleClickTime.
    MouseDragThreshold:                            float; // = 6.0f           // Distance threshold before considering we are dragging.
    KeyRepeatDelay:                                float; // = 0.275f         // When holding a key/button, time before it starts repeating, in seconds (for buttons in Repeat mode, etc.).
    KeyRepeatRate:                                 float; // = 0.050f         // When holding a key/button, rate at which it repeats, in seconds.

    ConfigErrorRecovery:                           bool; // = true       // Enable error recovery support. Some errors won't be detected and lead to direct crashes if recovery is disabled.
    ConfigErrorRecoveryEnableAssert:               bool; // = true       // Enable asserts on recoverable error. By default call IM_ASSERT() when returning from a failing IM_ASSERT_USER_ERROR()
    ConfigErrorRecoveryEnableDebugLog:             bool; // = true       // Enable debug log output on recoverable errors.
    ConfigErrorRecoveryEnableTooltip:              bool; // = true       // Enable tooltip on recoverable errors. The tooltip include a way to enable asserts if they were disabled.

    ConfigDebugIsDebuggerPresent:                  bool; // = false          // Enable various tools calling IM_DEBUG_BREAK().

    ConfigDebugHighlightIdConflicts:               bool; // = true           // Highlight and show an error message popup when multiple items have conflicting identifiers.
    ConfigDebugHighlightIdConflictsShowItemPicker: bool; //=true // Show "Item Picker" button in aforementioned popup.

    ConfigDebugBeginReturnValueOnce:               bool; // = false          // First-time calls to Begin()/BeginChild() will return false. NEEDS TO BE SET AT APPLICATION BOOT TIME if you don't want to miss windows.
    ConfigDebugBeginReturnValueLoop:               bool; // = false          // Some calls to Begin()/BeginChild() will return false. Will cycle through window depths then repeat. Suggested use: add "io.ConfigDebugBeginReturnValue = io.KeyShift" in your main loop then occasionally press SHIFT. Windows should be flickering while running.

    ConfigDebugIgnoreFocusLoss:                    bool; // = false          // Ignore io.AddFocusEvent(false), consequently not calling io.ClearInputKeys()/io.ClearInputMouse() in input processing.

    ConfigDebugDrawListDefaultsToStrokeLegacy:     bool; // false // Default all ImDrawList to ImDrawFlags_StrokeLegacy mode, mimicking pre-1.93.0 rendering.

    BackendPlatformName:                           *u8; // = NULL
    BackendRendererName:                           *u8; // = NULL
    BackendPlatformUserData:                       *void; // = NULL           // User data for platform backend
    BackendRendererUserData:                       *void; // = NULL           // User data for renderer backend
    BackendLanguageUserData:                       *void; // = NULL           // User data for non C++ programming language backend

    // Input Functions
    AddKeyEvent :: (this: *ImGuiIO, key: ImGuiKey, down: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO11AddKeyEventE8ImGuiKeyb";
    AddKeyAnalogEvent :: (this: *ImGuiIO, key: ImGuiKey, down: bool, v: float) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO17AddKeyAnalogEventE8ImGuiKeybf";
    AddMousePosEvent :: (this: *ImGuiIO, x: float, y: float) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO16AddMousePosEventEff";
    AddMouseButtonEvent :: (this: *ImGuiIO, button: s32, down: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO19AddMouseButtonEventEib";
    AddMouseWheelEvent :: (this: *ImGuiIO, wheel_x: float, wheel_y: float) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO18AddMouseWheelEventEff";
    AddMouseSourceEvent :: (this: *ImGuiIO, source: ImGuiMouseSource) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO19AddMouseSourceEventE16ImGuiMouseSource";
    AddFocusEvent :: (this: *ImGuiIO, focused: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO13AddFocusEventEb";
    AddInputCharacter :: (this: *ImGuiIO, c: u32) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO17AddInputCharacterEj";
    AddInputCharacterUTF16 :: (this: *ImGuiIO, c: ImWchar16) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO22AddInputCharacterUTF16Et";
    AddInputCharactersUTF8 :: (this: *ImGuiIO, str: *u8) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO22AddInputCharactersUTF8EPKc";

    SetKeyEventNativeData :: (this: *ImGuiIO, key: ImGuiKey, native_keycode: s32, native_scancode: s32, native_legacy_index: s32 = -1) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO21SetKeyEventNativeDataE8ImGuiKeyiii";
    SetAppAcceptingEvents :: (this: *ImGuiIO, accepting_events: bool) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO21SetAppAcceptingEventsEb";
    ClearEventsQueue :: (this: *ImGuiIO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO16ClearEventsQueueEv";
    ClearInputKeys :: (this: *ImGuiIO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO14ClearInputKeysEv";
    ClearInputMouse :: (this: *ImGuiIO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIO15ClearInputMouseEv";

    WantCaptureMouse:                              bool; // Set when Dear ImGui will use mouse inputs, in this case do not dispatch them to your main game/application (either way, always pass on mouse inputs to imgui). (e.g. unclicked mouse is hovering over an imgui window, widget is active, mouse was clicked over an imgui window, etc.).
    WantCaptureKeyboard:                           bool; // Set when Dear ImGui will use keyboard inputs, in this case do not dispatch them to your main game/application (either way, always pass keyboard inputs to imgui). (e.g. InputText active, or an imgui window is focused and navigation is enabled, etc.).
    WantTextInput:                                 bool; // Mobile/console: when set, you may display an on-screen keyboard. This is set by Dear ImGui when it wants textual keyboard input to happen (e.g. when a InputText widget is active).
    WantSetMousePos:                               bool; // MousePos has been altered, backend should reposition mouse on next frame. Rarely used! Set only when io.ConfigNavMoveSetMousePos is enabled.
    WantSaveIniSettings:                           bool; // When manual .ini load/save is active (io.IniFilename == NULL), this will be set to notify your application that you can call SaveIniSettingsToMemory() and save yourself. Important: clear io.WantSaveIniSettings yourself after saving!
    NavActive:                                     bool; // Keyboard/Gamepad navigation is currently allowed (will handle ImGuiKey_NavXXX events) = a window is focused and it doesn't use the ImGuiWindowFlags_NoNavInputs flag.
    NavVisible:                                    bool; // Keyboard/Gamepad navigation highlight is visible and allowed (will handle ImGuiKey_NavXXX events).
    Framerate:                                     float; // Estimate of application framerate (rolling average over 60 frames, based on io.DeltaTime), in frame per second. Solely for convenience. Slow applications may not want to use a moving average or may want to reset underlying buffers occasionally.
    MetricsRenderVertices:                         s32; // Vertices output during last call to Render()
    MetricsRenderIndices:                          s32; // Indices output during last call to Render() = number of triangles * 3
    MetricsRenderWindows:                          s32; // Number of visible windows
    MetricsActiveWindows:                          s32; // Number of active windows
    MouseDelta:                                    ImVec2; // Mouse delta. Note that this is zero if either current or previous position are invalid (-FLT_MAX,-FLT_MAX), so a disappearing/reappearing mouse won't have a huge delta.

    Ctx:                                           *ImGuiContext; // Parent UI context (needs to be set explicitly by parent).

    MousePos:                                      ImVec2; // Mouse position, in pixels. Set to ImVec2(-FLT_MAX, -FLT_MAX) if mouse is unavailable (on another screen, etc.)
    MouseDown:                                     [5] bool; // Mouse buttons: 0=left, 1=right, 2=middle + extras (ImGuiMouseButton_COUNT == 5). Dear ImGui mostly uses left and right buttons. Other buttons allow us to track if the mouse is being used by your application + available to user as a convenience via IsMouse** API.
    MouseWheel:                                    float; // Mouse wheel Vertical: 1 unit scrolls about 5 lines text. >0 scrolls Up, <0 scrolls Down. Hold Shift to turn vertical scroll into horizontal scroll.
    MouseWheelH:                                   float; // Mouse wheel Horizontal. >0 scrolls Left, <0 scrolls Right. Most users don't have a mouse with a horizontal wheel, may not be filled by all backends.
    MouseSource:                                   ImGuiMouseSource; // Mouse actual input peripheral (Mouse/TouchScreen/Pen).
    KeyCtrl:                                       bool; // Keyboard modifier down: Ctrl (non-macOS), Cmd (macOS)
    KeyShift:                                      bool; // Keyboard modifier down: Shift
    KeyAlt:                                        bool; // Keyboard modifier down: Alt
    KeySuper:                                      bool; // Keyboard modifier down: Windows/Super (non-macOS), Ctrl (macOS)

    KeyMods:                                       ImGuiKeyChord; // Key mods flags (any of ImGuiMod_Ctrl/ImGuiMod_Shift/ImGuiMod_Alt/ImGuiMod_Super flags, same as io.KeyCtrl/KeyShift/KeyAlt/KeySuper but merged into flags). Read-only, updated by NewFrame()
    KeysData:                                      [155] ImGuiKeyData; // Key state for all known keys. MUST use 'key - ImGuiKey_NamedKey_BEGIN' as index. Use IsKeyXXX() functions to access this.
    WantCaptureMouseUnlessPopupClose:              bool; // Alternative to WantCaptureMouse: (WantCaptureMouse == true && WantCaptureMouseUnlessPopupClose == false) when a click over void is expected to close a popup.
    MousePosPrev:                                  ImVec2; // Previous mouse position (note that MouseDelta is not necessary == MousePos-MousePosPrev, in case either position is invalid)
    MouseClickedPos:                               [5] ImVec2; // Position at time of clicking
    MouseClickedTime:                              [5] float64; // Time of last click (used to figure out double-click)
    MouseClicked:                                  [5] bool; // Mouse button went from !Down to Down (same as MouseClickedCount[x] != 0)
    MouseDoubleClicked:                            [5] bool; // Has mouse button been double-clicked? (same as MouseClickedCount[x] == 2)
    MouseClickedCount:                             [5] ImU16; // == 0 (not clicked), == 1 (same as MouseClicked[]), == 2 (double-clicked), == 3 (triple-clicked) etc. when going from !Down to Down
    MouseClickedLastCount:                         [5] ImU16; // Count successive number of clicks. Stays valid after mouse release. Reset after another click is done.
    MouseReleased:                                 [5] bool; // Mouse button went from Down to !Down
    MouseReleasedTime:                             [5] float64; // Time of last released (rarely used! but useful to handle delayed single-click when trying to disambiguate them from double-click).
    MouseDownOwned:                                [5] bool; // Track if button was clicked inside a dear imgui window or over void blocked by a popup. We don't request mouse capture from the application if click started outside ImGui bounds.
    MouseDownOwnedUnlessPopupClose:                [5] bool; // Track if button was clicked inside a dear imgui window.
    MouseWheelRequestAxisSwap:                     bool; // On a non-Mac system, holding Shift requests WheelY to perform the equivalent of a WheelX event. On a Mac system this is already enforced by the system.
    MouseCtrlLeftAsRightClick:                     bool; // (OSX) Set to true when the current click was a Ctrl+Click that spawned a simulated right click
    MouseDownDuration:                             [5] float; // Duration the mouse button has been down (0.0f == just clicked)
    MouseDownDurationPrev:                         [5] float; // Previous time the mouse button has been down
    MouseDragMaxDistanceSqr:                       [5] float; // Squared maximum distance of how much mouse has traveled from the clicking point (used for moving thresholds)
    PenPressure:                                   float; // Touch/Pen pressure (0.0f to 1.0f, should be >0.0f only when MouseDown[0] == true). Helper storage currently unused by Dear ImGui.
    AppFocusLost:                                  bool; // Only modify via AddFocusEvent()
    AppAcceptingEvents:                            bool; // Only modify via SetAppAcceptingEvents()
    InputQueueSurrogate:                           ImWchar16; // For AddInputCharacterUTF16()
    InputQueueCharacters:                          ImVector(ImWchar); // Queue of _characters_ input (obtained by platform backend). Fill using AddInputCharacter() helper.

    FontGlobalScale:                               float; // Moved io.FontGlobalScale to style.FontScaleMain in 1.92.0 (June 2025)

    Constructor :: (this: *ImGuiIO) -> void #cpp_method #foreign libimgui "_ZN7ImGuiIOC1Ev";
}

// Shared state of InputText(), passed as an argument to your callback when a ImGuiInputTextFlags_Callback* flag is used.
// The callback function should return 0 by default.
// Callbacks (follow a flag name and see comments in ImGuiInputTextFlags_ declarations for more details)
// - ImGuiInputTextFlags_CallbackEdit:        Callback on buffer edit. Note that InputText() already returns true on edit + you can always use IsItemEdited(). The callback is useful to manipulate the underlying buffer while focus is active.
// - ImGuiInputTextFlags_CallbackAlways:      Callback on each iteration
// - ImGuiInputTextFlags_CallbackCompletion:  Callback on pressing TAB
// - ImGuiInputTextFlags_CallbackHistory:     Callback on pressing Up/Down arrows
// - ImGuiInputTextFlags_CallbackCharFilter:  Callback on character inputs to replace or discard them. Modify 'EventChar' to replace or discard, or return 1 in callback to discard.
// - ImGuiInputTextFlags_CallbackResize:      Callback on buffer capacity changes request (beyond 'buf_size' parameter value), allowing the string to grow.
ImGuiInputTextCallbackData :: struct {
    Ctx:            *ImGuiContext; // Parent UI context
    EventFlag:      ImGuiInputTextFlags; // One ImGuiInputTextFlags_Callback*    // Read-only
    Flags:          ImGuiInputTextFlags; // What user passed to InputText()      // Read-only
    UserData:       *void; // What user passed to InputText()      // Read-only
    ID:             ImGuiID; // Widget ID                            // Read-only

    EventKey:       ImGuiKey; // Key pressed (Up/Down/TAB)            // Read-only    // [Completion,History]
    EventChar:      ImWchar; // Character input                      // Read-write   // [CharFilter] Replace character with another one, or set to zero to drop. return 1 is equivalent to setting EventChar=0;
    EventActivated: bool; // Input field just got activated       // Read-only    // [Always]
    BufDirty:       bool; // Set if you modify Buf/BufTextLen!    // Write        // [Completion,History,Always]
    Buf:            *u8; // Text buffer                          // Read-write   // [Resize] Can replace pointer / [Completion,History,Always] Only write to pointed data, don't replace the actual pointer!
    BufTextLen:     s32; // Text length (in bytes)               // Read-write   // [Resize,Completion,History,Always] Exclude zero-terminator storage. In C land: == strlen(some_text), in C++ land: string.length()
    BufSize:        s32; // Buffer size (in bytes) = capacity+1  // Read-only    // [Resize,Completion,History,Always] Include zero-terminator storage. In C land: == ARRAYSIZE(my_char_array), in C++ land: string.capacity()+1
    CursorPos:      s32; //                                      // Read-write   // [Completion,History,Always,CharFilter]
    SelectionStart: s32; //                                      // Read-write   // [Completion,History,Always,CharFilter] == to SelectionEnd when no selection
    SelectionEnd:   s32; //                                      // Read-write   // [Completion,History,Always,CharFilter]

    // Helper functions for text manipulation.
    // Use those function to benefit from the CallbackResize behaviors. Calling those function reset the selection.
    Constructor :: (this: *ImGuiInputTextCallbackData) -> void #cpp_method #foreign libimgui "_ZN26ImGuiInputTextCallbackDataC1Ev";
    DeleteChars :: (this: *ImGuiInputTextCallbackData, pos: s32, bytes_count: s32) -> void #cpp_method #foreign libimgui "_ZN26ImGuiInputTextCallbackData11DeleteCharsEii";
    InsertChars :: (this: *ImGuiInputTextCallbackData, pos: s32, text: *u8, text_end: *u8 = null) -> void #cpp_method #foreign libimgui "_ZN26ImGuiInputTextCallbackData11InsertCharsEiPKcS1_";
}

// Resizing callback data to apply custom constraint. As enabled by SetNextWindowSizeConstraints(). Callback is called during the next Begin().
// NB: For basic min/max size constraint on each axis you don't need to use the callback! The SetNextWindowSizeConstraints() parameters are enough.
ImGuiSizeCallbackData :: struct {
    UserData:    *void; // Read-only.   What user passed to SetNextWindowSizeConstraints(). Generally store an integer or float in here (need reinterpret_cast<>).
    Pos:         ImVec2; // Read-only.   Window position, for reference.
    CurrentSize: ImVec2; // Read-only.   Current window size.
    DesiredSize: ImVec2; // Read-write.  Desired size, based on user's mouse position. Write to this field to restrain resizing.
}

// Data payload for Drag and Drop operations: AcceptDragDropPayload(), GetDragDropPayload()
ImGuiPayload :: struct {
    Data:           *void; // Data (copied and owned by dear imgui)
    DataSize:       s32; // Data size

    SourceId:       ImGuiID; // Source item id
    SourceParentId: ImGuiID; // Source parent id (if available)
    DataFrameCount: s32; // Data timestamp
    DataType:       [33] u8; // Data type tag (short user-supplied string, 32 characters max)
    Preview:        bool; // Set when AcceptDragDropPayload() was called and mouse has been hovering the target item (nb: handle overlapping drag targets)
    Delivery:       bool; // Set when AcceptDragDropPayload() was called and mouse button is released over the target item.
}

// Helper: Execute a block of code at maximum once a frame. Convenient if you want to quickly create a UI within deep-nested code that runs multiple times every frame.
// Usage: static ImGuiOnceUponAFrame oaf; if (oaf) ImGui::Text("This will be called only once per frame");
ImGuiOnceUponAFrame :: struct {
    RefFrame: s32;
}

// Helper: Parse and apply text filters e.g. 'aaa bbb' (all), 'aaa,bbb' (any), '-aaa' (exclude), '"Hello, world"' (exact sequence)
ImGuiTextFilterItem :: struct {}
ImGuiTextFilter :: struct {
    Constructor :: (this: *ImGuiTextFilter, default_filter: *u8 = "") -> void #cpp_method #foreign libimgui "_ZN15ImGuiTextFilterC1EPKc";
    PassFilter :: (this: *ImGuiTextFilter, text: *u8, text_end: *u8 = null) -> bool #cpp_method #foreign libimgui "_ZNK15ImGuiTextFilter10PassFilterEPKcS1_";
    Build :: (this: *ImGuiTextFilter) -> void #cpp_method #foreign libimgui "_ZN15ImGuiTextFilter5BuildEv";

    // Helper to call InputText() + Build() when buffer is changed.
    Draw :: (this: *ImGuiTextFilter, label: *u8 = "Filter") -> bool #cpp_method #foreign libimgui "_ZN15ImGuiTextFilter4DrawEPKc";
    DrawWithHint :: (this: *ImGuiTextFilter, label: *u8 = "Filter", hint: *u8 = "incl -excl") -> bool #cpp_method #foreign libimgui "_ZN15ImGuiTextFilter12DrawWithHintEPKcS1_";

    InputBuf:      [256] u8; // User input buffer
    _CountExclude: s32; // [Internal] >= 0 count of leading exclude
    _Items:        ImVector(ImGuiTextFilterItem); // [Internal] Pre-parsed, trimmed, reordered items
}

// Helper: Growable text buffer for logging/accumulating text
// (this could be called 'ImGuiTextBuilder' / 'ImGuiStringBuilder')
ImGuiTextBuffer :: struct {
    Buf: ImVector(u8);

    append :: (this: *ImGuiTextBuffer, str: *u8, str_end: *u8 = null) -> void #cpp_method #foreign libimgui "_ZN15ImGuiTextBuffer6appendEPKcS1_";
    appendf_CFormat :: (this: *ImGuiTextBuffer, fmt: *u8, __args: ..Any) -> void #cpp_method #foreign libimgui "_ZN15ImGuiTextBuffer7appendfEPKcz";
    appendf :: (this: *ImGuiTextBuffer, fmt: string, __args: ..Any) {
        push_allocator(temp);
        formatted_text_builder: String_Builder;
        print_to_builder(*formatted_text_builder, fmt, ..__args);
        append(*formatted_text_builder, "\0");
        formatted_text := builder_to_string(*formatted_text_builder);
        appendf_CFormat(this, "%s", formatted_text.data);
    } @PrintLike
}

EmptyString: [1] u8 #elsewhere libimgui "_ZN15ImGuiTextBuffer11EmptyStringE";

// [Internal] Key+Value for ImGuiStorage
ImGuiStoragePair :: struct {
    key: ImGuiID;
    struct {
        val_p: *void; // largest member, moved to the start of the struct/union to support #overlay.

        #overlay (val_p) val_i: s32;
        #overlay (val_p) val_f: float;
    }
}

// Helper: Key->Value storage
// Typically you don't have to worry about this since a storage is held within each Window.
// We use it to e.g. store collapse state for a tree (Int 0/1)
// This is optimized for efficient lookup (dichotomy into a contiguous buffer) and rare insertion (typically tied to user interactions aka max once a frame)
// You can use it as custom user storage for temporary values. Declare your own storage if, for example:
// - You want to manipulate the open/close state of a particular sub-tree in your interface (tree node uses Int 0/1 to store their state).
// - You want to store custom debug data easily without adding or editing structures in your code (probably not efficient, but convenient)
// Types are NOT stored, so it is up to you to make sure your Key don't collide with different types.
ImGuiStorage :: struct {
    // [Internal]
    Data: ImVector(ImGuiStoragePair);

    GetInt :: (this: *ImGuiStorage, key: ImGuiID, default_val: s32 = 0) -> s32 #cpp_method #foreign libimgui "_ZNK12ImGuiStorage6GetIntEji";
    SetInt :: (this: *ImGuiStorage, key: ImGuiID, val: s32) -> void #cpp_method #foreign libimgui "_ZN12ImGuiStorage6SetIntEji";
    GetBool :: (this: *ImGuiStorage, key: ImGuiID, default_val := false) -> bool #cpp_method #foreign libimgui "_ZNK12ImGuiStorage7GetBoolEjb";
    SetBool :: (this: *ImGuiStorage, key: ImGuiID, val: bool) -> void #cpp_method #foreign libimgui "_ZN12ImGuiStorage7SetBoolEjb";
    GetFloat :: (this: *ImGuiStorage, key: ImGuiID, default_val: float = 0.0) -> float #cpp_method #foreign libimgui "_ZNK12ImGuiStorage8GetFloatEjf";
    SetFloat :: (this: *ImGuiStorage, key: ImGuiID, val: float) -> void #cpp_method #foreign libimgui "_ZN12ImGuiStorage8SetFloatEjf";
    GetVoidPtr :: (this: *ImGuiStorage, key: ImGuiID) -> *void #cpp_method #foreign libimgui "_ZNK12ImGuiStorage10GetVoidPtrEj";
    SetVoidPtr :: (this: *ImGuiStorage, key: ImGuiID, val: *void) -> void #cpp_method #foreign libimgui "_ZN12ImGuiStorage10SetVoidPtrEjPv";

    // - Get***Ref() functions finds pair, insert on demand if missing, return pointer. Useful if you intend to do Get+Set.
    // - References are only valid until a new value is added to the storage. Calling a Set***() function or a Get***Ref() function invalidates the pointer.
    // - A typical use case where this is convenient for quick hacking (e.g. add storage during a live Edit&Continue session if you can't modify existing struct)
    //      float* pvar = ImGui::GetFloatRef(key); ImGui::SliderFloat("var", pvar, 0, 100.0f); some_var += *pvar;
    GetIntRef :: (this: *ImGuiStorage, key: ImGuiID, default_val: s32 = 0) -> *s32 #cpp_method #foreign libimgui "_ZN12ImGuiStorage9GetIntRefEji";
    GetBoolRef :: (this: *ImGuiStorage, key: ImGuiID, default_val := false) -> *bool #cpp_method #foreign libimgui "_ZN12ImGuiStorage10GetBoolRefEjb";
    GetFloatRef :: (this: *ImGuiStorage, key: ImGuiID, default_val: float = 0.0) -> *float #cpp_method #foreign libimgui "_ZN12ImGuiStorage11GetFloatRefEjf";
    GetVoidPtrRef :: (this: *ImGuiStorage, key: ImGuiID, default_val: *void = null) -> **void #cpp_method #foreign libimgui "_ZN12ImGuiStorage13GetVoidPtrRefEjPv";

    // Advanced: for quicker full rebuild of a storage (instead of an incremental one), you may add all your contents and then sort once.
    BuildSortByKey :: (this: *ImGuiStorage) -> void #cpp_method #foreign libimgui "_ZN12ImGuiStorage14BuildSortByKeyEv";

    // Obsolete: use on your own storage if you know only integer are being stored (open/close all tree nodes)
    SetAllInt :: (this: *ImGuiStorage, val: s32) -> void #cpp_method #foreign libimgui "_ZN12ImGuiStorage9SetAllIntEi";
}

// [Internal] Used for small stacks. Do not use.
ImSmallStack_ :: struct(T: Type, Capacity: s32, SZ_T: Type = xx ImU16) {
    LocalData: [Capacity] T; // FIXME: should evolve into using heap, e.g union {} with T* HeapData + add SZ_T Capacity.
    Size:      SZ_T = 0;
}

// Flags for ImGuiListClipper (currently not fully exposed in function calls: a future refactor will likely add this to ImGuiListClipper::Begin function equivalent)
ImGuiListClipperFlags_ :: enum u32 {
    None                  :: 0;
    NoSetTableRowCounters :: 1;

    ImGuiListClipperFlags_None                  :: None;
    ImGuiListClipperFlags_NoSetTableRowCounters :: NoSetTableRowCounters;
}

// Helper: Manually clip large list of items.
// If you have lots evenly spaced items and you have random access to the list, you can perform coarse
// clipping based on visibility to only submit items that are in view.
// The clipper calculates the range of visible items and advance the cursor to compensate for the non-visible items we have skipped.
// (Dear ImGui already clip items based on their bounds but: it needs to first layout the item to do so, and generally
//  fetching/submitting your own data incurs additional cost. Coarse clipping using ImGuiListClipper allows you to easily
//  scale using lists with tens of thousands of items without a problem)
// Usage:
//   ImGuiListClipper clipper;
//   clipper.Begin(1000);         // We have 1000 elements, evenly spaced.
//   while (clipper.Step())
//       for (int i = clipper.DisplayStart; i < clipper.DisplayEnd; i++)
//           ImGui::Text("line number %d", i);
// Generally what happens is:
// - Clipper lets you process the first element (DisplayStart = 0, DisplayEnd = 1) regardless of it being visible or not.
// - User code submit that one element.
// - Clipper can measure the height of the first element
// - Clipper calculate the actual range of elements to display based on the current clipping rectangle, position the cursor before the first visible element.
// - User code submit visible elements.
// - The clipper also handles various subtleties related to keyboard/gamepad navigation, wrapping etc.
ImGuiListClipper :: struct {
    DisplayStart:     s32; // First item to display, updated by each call to Step()
    DisplayEnd:       s32; // End of items to display (exclusive)
    UserIndex:        s32; // Helper storage for user convenience/code. Optional, and otherwise unused if you don't use it.
    ItemsCount:       s32; // [Internal] Number of items
    ItemsHeight:      float; // [Internal] Height of item after a first step and item submission can calculate it
    Flags:            ImGuiListClipperFlags; // [Internal] Flags, currently not yet well exposed.
    StartPosY:        float64; // [Internal] Cursor position at the time of Begin() or after table frozen rows are all processed
    StartSeekOffsetY: float64; // [Internal] Account for frozen rows in a table and initial loss of precision in very large windows.
    Ctx:              *ImGuiContext; // [Internal] Parent UI context
    TempData:         *void; // [Internal] Internal data

    // items_count: Use INT_MAX if you don't know how many items you have (in which case the cursor won't be advanced in the final step, and you can call SeekCursorForItem() manually if you need)
    // items_height: Use -1.0f to be calculated automatically on first step. Otherwise pass in the distance between your items, typically GetTextLineHeightWithSpacing() or GetFrameHeightWithSpacing().
    Constructor :: (this: *ImGuiListClipper) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipperC1Ev";
    Destructor_Base :: (this: *ImGuiListClipper) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipperD2Ev";
    Destructor :: (this: *ImGuiListClipper) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipperD1Ev";
    Begin :: (this: *ImGuiListClipper, items_count: s32, items_height: float = -1.0) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipper5BeginEif";
    End :: (this: *ImGuiListClipper) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipper3EndEv";
    Step :: (this: *ImGuiListClipper) -> bool #cpp_method #foreign libimgui "_ZN16ImGuiListClipper4StepEv";

    IncludeItemsByIndex :: (this: *ImGuiListClipper, item_begin: s32, item_end: s32) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipper19IncludeItemsByIndexEii";

    // Seek cursor toward given item. This is automatically called while stepping.
    // - The only reason to call this is: you can use ImGuiListClipper::Begin(INT_MAX) if you don't know item count ahead of time.
    // - In this case, after all steps are done, you'll want to call SeekCursorForItem(item_count).
    SeekCursorForItem :: (this: *ImGuiListClipper, item_index: s32) -> void #cpp_method #foreign libimgui "_ZN16ImGuiListClipper17SeekCursorForItemEi";
}

// Helper: ImColor() implicitly converts colors to either ImU32 (packed 4x1 byte) or ImVec4 (4x1 float)
// Prefer using IM_COL32() macros if you want a guaranteed compile-time ImU32 for usage with ImDrawList API.
// **Avoid storing ImColor! Store either u32 of ImVec4. This is not a full-featured color class. MAY OBSOLETE.
// **None of the ImGui API are using ImColor directly but you can use it as a convenience to pass colors in either ImU32 or ImVec4 formats. Explicitly cast to ImU32 or ImVec4 if needed.
ImColor :: struct {
    Value: ImVec4;
}

// Flags for BeginMultiSelect()
ImGuiMultiSelectFlags_ :: enum u32 {
    None                  :: 0;
    SingleSelect          :: 1;
    NoSelectAll           :: 2;
    NoRangeSelect         :: 4;
    NoAutoSelect          :: 8;
    NoAutoClear           :: 16;
    NoAutoClearOnReselect :: 32;
    BoxSelect1d           :: 64;
    BoxSelect2d           :: 128;
    BoxSelectNoScroll     :: 256;
    ClearOnEscape         :: 512;
    ClearOnClickVoid      :: 1024;
    ScopeWindow           :: 2048;
    ScopeRect             :: 4096;
    SelectOnAuto          :: 8192;
    SelectOnClickAlways   :: 16384;
    SelectOnClickRelease  :: 32768;

    NavWrapX              :: 65536;
    NoSelectOnRightClick  :: 131072;
    SelectOnMask_         :: 57344;
    CheckboxMode_         :: 1048576;

    SelectOnClick         :: 8192;

    ImGuiMultiSelectFlags_None                  :: None;
    ImGuiMultiSelectFlags_SingleSelect          :: SingleSelect;
    ImGuiMultiSelectFlags_NoSelectAll           :: NoSelectAll;
    ImGuiMultiSelectFlags_NoRangeSelect         :: NoRangeSelect;
    ImGuiMultiSelectFlags_NoAutoSelect          :: NoAutoSelect;
    ImGuiMultiSelectFlags_NoAutoClear           :: NoAutoClear;
    ImGuiMultiSelectFlags_NoAutoClearOnReselect :: NoAutoClearOnReselect;
    ImGuiMultiSelectFlags_BoxSelect1d           :: BoxSelect1d;
    ImGuiMultiSelectFlags_BoxSelect2d           :: BoxSelect2d;
    ImGuiMultiSelectFlags_BoxSelectNoScroll     :: BoxSelectNoScroll;
    ImGuiMultiSelectFlags_ClearOnEscape         :: ClearOnEscape;
    ImGuiMultiSelectFlags_ClearOnClickVoid      :: ClearOnClickVoid;
    ImGuiMultiSelectFlags_ScopeWindow           :: ScopeWindow;
    ImGuiMultiSelectFlags_ScopeRect             :: ScopeRect;
    ImGuiMultiSelectFlags_SelectOnAuto          :: SelectOnAuto;
    ImGuiMultiSelectFlags_SelectOnClickAlways   :: SelectOnClickAlways;
    ImGuiMultiSelectFlags_SelectOnClickRelease  :: SelectOnClickRelease;

    ImGuiMultiSelectFlags_NavWrapX              :: NavWrapX;
    ImGuiMultiSelectFlags_NoSelectOnRightClick  :: NoSelectOnRightClick;
    ImGuiMultiSelectFlags_SelectOnMask_         :: SelectOnMask_;
    ImGuiMultiSelectFlags_CheckboxMode_         :: CheckboxMode_;

    ImGuiMultiSelectFlags_SelectOnClick         :: SelectOnClick;
}

// Main IO structure returned by BeginMultiSelect()/EndMultiSelect().
// This mainly contains a list of selection requests.
// - Use 'Demo->Tools->Debug Log->Selection' to see requests as they happen.
// - Some fields are only useful if your list is dynamic and allows deletion (getting post-deletion focus/state right is shown in the demo)
// - Below: who reads/writes each fields? 'r'=read, 'w'=write, 'ms'=multi-select code, 'app'=application/user code.
ImGuiMultiSelectIO :: struct {
    Requests:      ImVector(ImGuiSelectionRequest); //  ms:w, app:r     /  ms:w  app:r   // Requests to apply to your selection data.
    RangeSrcItem:  ImGuiSelectionUserData; //  ms:w  app:r     /                // (If using clipper) Begin: Source item (often the first selected item) must never be clipped: use clipper.IncludeItemByIndex() to ensure it is submitted.
    NavIdItem:     ImGuiSelectionUserData; //  ms:w, app:r     /                // (If using deletion) Last known SetNextItemSelectionUserData() value for NavId (if part of submitted items).
    NavIdSelected: bool; //  ms:w, app:r     /        app:r   // (If using deletion) Last known selection state for NavId (if part of submitted items).
    RangeSrcReset: bool; //        app:w     /  ms:r          // (If using deletion) Set before EndMultiSelect() to reset ResetSrcItem (e.g. if deleted selection).
    ItemsCount:    s32; //  ms:w, app:r     /        app:r   // 'int items_count' parameter to BeginMultiSelect() is copied here for convenience, allowing simpler calls to your ApplyRequests handler. Not used internally.
}

// Selection request type
ImGuiSelectionRequestType :: enum u32 {
    None     :: 0;
    SetAll   :: 1;
    SetRange :: 2;

    ImGuiSelectionRequestType_None     :: None;
    ImGuiSelectionRequestType_SetAll   :: SetAll;
    ImGuiSelectionRequestType_SetRange :: SetRange;
}

// Selection request item
ImGuiSelectionRequest :: struct {
    Type:           ImGuiSelectionRequestType; //  ms:w, app:r     /  ms:w, app:r   // Request type. You'll most often receive 1 Clear + 1 SetRange with a single-item range.
    Selected:       bool; //  ms:w, app:r     /  ms:w, app:r   // Parameter for SetAll/SetRange requests (true = select, false = unselect)
    RangeDirection: ImS8; //                  /  ms:w  app:r   // Parameter for SetRange request: +1 when RangeFirstItem comes before RangeLastItem, -1 otherwise. Useful if you want to preserve selection order on a backward Shift+Click.
    RangeFirstItem: ImGuiSelectionUserData; //                  /  ms:w, app:r   // Parameter for SetRange request (this is generally == RangeSrcItem when shift selecting from top to bottom).
    RangeLastItem:  ImGuiSelectionUserData; //                  /  ms:w, app:r   // Parameter for SetRange request (this is generally == RangeSrcItem when shift selecting from bottom to top). Inclusive!
}

// Optional helper to store multi-selection state + apply multi-selection requests.
// - Used by our demos and provided as a convenience to easily implement basic multi-selection.
// - Iterate selection with 'void* it = NULL; ImGuiID id; while (selection.GetNextSelectedItem(&it, &id)) { ... }'
//   Or you can check 'if (Contains(id)) { ... }' for each possible object if their number is not too high to iterate.
// - USING THIS IS NOT MANDATORY. This is only a helper and not a required API.
// To store a multi-selection, in your application you could:
// - Use this helper as a convenience. We use our simple key->value ImGuiStorage as a std::set<ImGuiID> replacement.
// - Use your own external storage: e.g. std::set<MyObjectId>, std::vector<MyObjectId>, interval trees, intrusively stored selection etc.
// In ImGuiSelectionBasicStorage we:
// - always use indices in the multi-selection API (passed to SetNextItemSelectionUserData(), retrieved in ImGuiMultiSelectIO)
// - use the AdapterIndexToStorageId() indirection layer to abstract how persistent selection data is derived from an index.
// - use decently optimized logic to allow queries and insertion of very large selection sets.
// - do not preserve selection order.
// Many combinations are possible depending on how you prefer to store your items and how you prefer to store your selection.
// Large applications are likely to eventually want to get rid of this indirection layer and do their own thing.
// See https://github.com/ocornut/imgui/wiki/Multi-Select for details and pseudo-code using this helper.
ImGuiSelectionBasicStorage :: struct {
    Size:                    s32; //          // Number of selected items, maintained by this helper.
    PreserveOrder:           bool; // = false  // GetNextSelectedItem() will return ordered selection (currently implemented by two additional sorts of selection. Could be improved)
    UserData:                *void; // = NULL   // User data for use by adapter function        // e.g. selection.UserData = (void*)my_items;
    AdapterIndexToStorageId: #type (self: *ImGuiSelectionBasicStorage, idx: s32) -> ImGuiID #c_call; // e.g. selection.AdapterIndexToStorageId = [](ImGuiSelectionBasicStorage* self, int idx) { return ((MyItems**)self->UserData)[idx]->ID; };
    _SelectionOrder:         s32; // [Internal] Increasing counter to store selection order
    _Storage:                ImGuiStorage; // [Internal] Selection set. Think of this as similar to e.g. std::set<ImGuiID>. Prefer not accessing directly: iterate with GetNextSelectedItem().

    // Methods
    Constructor :: (this: *ImGuiSelectionBasicStorage) -> void #cpp_method #foreign libimgui "_ZN26ImGuiSelectionBasicStorageC1Ev";
    ApplyRequests :: (this: *ImGuiSelectionBasicStorage, ms_io: *ImGuiMultiSelectIO) -> void #cpp_method #foreign libimgui "_ZN26ImGuiSelectionBasicStorage13ApplyRequestsEP18ImGuiMultiSelectIO";
    Contains :: (this: *ImGuiSelectionBasicStorage, id: ImGuiID) -> bool #cpp_method #foreign libimgui "_ZNK26ImGuiSelectionBasicStorage8ContainsEj";
    Clear :: (this: *ImGuiSelectionBasicStorage) -> void #cpp_method #foreign libimgui "_ZN26ImGuiSelectionBasicStorage5ClearEv";
    Swap :: (this: *ImGuiSelectionBasicStorage, r: *ImGuiSelectionBasicStorage) -> void #cpp_method #foreign libimgui "_ZN26ImGuiSelectionBasicStorage4SwapERS_";
    SetItemSelected :: (this: *ImGuiSelectionBasicStorage, id: ImGuiID, selected: bool) -> void #cpp_method #foreign libimgui "_ZN26ImGuiSelectionBasicStorage15SetItemSelectedEjb";
    GetNextSelectedItem :: (this: *ImGuiSelectionBasicStorage, opaque_it: **void, out_id: *ImGuiID) -> bool #cpp_method #foreign libimgui "_ZN26ImGuiSelectionBasicStorage19GetNextSelectedItemEPPvPj";
}

// Optional helper to apply multi-selection requests to existing randomly accessible storage.
// Convenient if you want to quickly wire multi-select API on e.g. an array of bool or items storing their own selection state.
ImGuiSelectionExternalStorage :: struct {
    UserData:               *void; // User data for use by adapter function                                // e.g. selection.UserData = (void*)my_items;
    AdapterSetItemSelected: #type (self: *ImGuiSelectionExternalStorage, idx: s32, selected: bool) -> void #c_call; // e.g. AdapterSetItemSelected = [](ImGuiSelectionExternalStorage* self, int idx, bool selected) { ((MyItems**)self->UserData)[idx]->Selected = selected; }

    // Methods
    Constructor :: (this: *ImGuiSelectionExternalStorage) -> void #cpp_method #foreign libimgui "_ZN29ImGuiSelectionExternalStorageC1Ev";
    ApplyRequests :: (this: *ImGuiSelectionExternalStorage, ms_io: *ImGuiMultiSelectIO) -> void #cpp_method #foreign libimgui "_ZN29ImGuiSelectionExternalStorage13ApplyRequestsEP18ImGuiMultiSelectIO";
}

ImDrawIdx :: u16;

ImDrawCallback :: #type (parent_list: *ImDrawList, cmd: *ImDrawCmd) -> void #c_call;

// Typically, 1 command = 1 GPU draw call (unless command is a callback)
// - VtxOffset: When 'io.BackendFlags & ImGuiBackendFlags_RendererHasVtxOffset' is enabled,
//   this fields allow us to render meshes larger than 64K vertices while keeping 16-bit indices.
//   Backends made for <1.71. will typically ignore the VtxOffset fields.
// - The ClipRect/TexRef/VtxOffset fields must be contiguous as we memcmp() them together (this is asserted for).
ImDrawCmd :: struct {
    ClipRect:               ImVec4; // 4*4  // Clipping rectangle (x1, y1, x2, y2). Subtract ImDrawData->DisplayPos to get clipping rectangle in "viewport" coordinates
    TexRef:                 ImTextureRef; // 16   // Reference to a font/texture atlas (where backend called ImTextureData::SetTexID()) or to a user-provided texture ID (via e.g. ImGui::Image() calls). Both will lead to a ImTextureID value.
    VtxOffset:              u32; // 4    // Start offset in vertex buffer. ImGuiBackendFlags_RendererHasVtxOffset: always 0, otherwise may be >0 to support meshes larger than 64K vertices with 16-bit indices.
    IdxOffset:              u32; // 4    // Start offset in index buffer.
    ElemCount:              u32; // 4    // Number of indices (multiple of 3) to be rendered as triangles. Vertices are stored in the callee ImDrawList's vtx_buffer[] array, indices in idx_buffer[].
    UserCallback:           ImDrawCallback; // 4-8  // If != NULL, call the function instead of rendering the vertices. clip_rect and texture_id will be set normally.
    UserCallbackData:       *void; // 4-8  // Callback user data (when UserCallback != NULL). If called AddCallback() with size == 0, this is a copy of the AddCallback() argument. If called AddCallback() with size > 0, this is pointing to a buffer where data is stored.
    UserCallbackDataSize:   s32; // 4 // Size of callback user data when using storage, otherwise 0.
    UserCallbackDataOffset: s32; // 4 // [Internal] Offset of callback user data when using storage, otherwise -1.
}

ImDrawVert :: struct {
    pos: ImVec2;
    uv:  ImVec2;
    col: ImU32;
}

// [Internal] For use by ImDrawList
ImDrawCmdHeader :: struct {
    ClipRect:  ImVec4;
    TexRef:    ImTextureRef;
    VtxOffset: u32;
}

// Forward declarations: ImDrawList, ImFontAtlas layer
ImDrawChannel :: struct {
    _CmdBuffer: ImVector(ImDrawCmd);
    _IdxBuffer: ImVector(ImDrawIdx);
}

// Split/Merge functions are used to split the draw list into different layers which can be drawn into out of order.
// This is used by the Columns/Tables API, so items of each column can be batched together in a same draw call.
ImDrawListSplitter :: struct {
    _Current:  s32; // Current channel number (0)
    _Count:    s32; // Number of active channels (1+)
    _Channels: ImVector(ImDrawChannel); // Draw channels (not resized down so _Count might be < Channels.Size)

    ClearFreeMemory :: (this: *ImDrawListSplitter) -> void #cpp_method #foreign libimgui "_ZN18ImDrawListSplitter15ClearFreeMemoryEv";
    Split :: (this: *ImDrawListSplitter, draw_list: *ImDrawList, count: s32) -> void #cpp_method #foreign libimgui "_ZN18ImDrawListSplitter5SplitEP10ImDrawListi";
    Merge :: (this: *ImDrawListSplitter, draw_list: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN18ImDrawListSplitter5MergeEP10ImDrawList";
    SetCurrentChannel :: (this: *ImDrawListSplitter, draw_list: *ImDrawList, channel_idx: s32) -> void #cpp_method #foreign libimgui "_ZN18ImDrawListSplitter17SetCurrentChannelEP10ImDrawListi";
}

// Flags for ImDrawList functions
ImDrawFlags_ :: enum s32 {
    None                     :: 0;

    RoundTopLeft             :: 16;
    RoundTopRight            :: 32;
    RoundBottomLeft          :: 64;
    RoundBottomRight         :: 128;
    RoundNone                :: 256;
    RoundAll                 :: 240;
    RoundTop                 :: 48;
    RoundBottom              :: 192;
    RoundLeft                :: 80;
    RoundRight               :: 160;

    Closed                   :: 512;
    JoinMiter                :: 1024;
    CapSquare                :: 2048;

    AAFill                   :: 4096;
    AALines                  :: 8192;
    AALineEnds               :: 16384;

    StrokeInside             :: 131072;
    StrokeCenter             :: 262144;
    StrokeCenterBiased       :: 393216;
    StrokeOutside            :: 524288;
    StrokeLegacy             :: 917504;

    TextNoPixelSnap          :: 1048576;
    UseTexForRoundCorners    :: 2097152;
    UseVtxOffset             :: 4194304;
    AllowTexForRoundCorners_ :: 8388608;

    RoundMask_               :: 496;
    AllowInPushScope_        :: 8286704;
    AllowInFrameScope_       :: 16675312;
    StrokeMask_              :: 917504;
    InvalidMask_             :: -2147483633;

    RoundCornersTopLeft      :: 16;
    RoundCornersTopRight     :: 32;
    RoundCornersBottomLeft   :: 64;
    RoundCornersBottomRight  :: 128;
    RoundCornersNone         :: 256;
    RoundCornersAll          :: 240;
    RoundCornersTop          :: 48;
    RoundCornersBottom       :: 192;
    RoundCornersLeft         :: 80;
    RoundCornersRight        :: 160;
    RoundCornersMask_        :: 496;

    ImDrawFlags_None                     :: None;

    ImDrawFlags_RoundTopLeft             :: RoundTopLeft;
    ImDrawFlags_RoundTopRight            :: RoundTopRight;
    ImDrawFlags_RoundBottomLeft          :: RoundBottomLeft;
    ImDrawFlags_RoundBottomRight         :: RoundBottomRight;
    ImDrawFlags_RoundNone                :: RoundNone;
    ImDrawFlags_RoundAll                 :: RoundAll;
    ImDrawFlags_RoundTop                 :: RoundTop;
    ImDrawFlags_RoundBottom              :: RoundBottom;
    ImDrawFlags_RoundLeft                :: RoundLeft;
    ImDrawFlags_RoundRight               :: RoundRight;

    ImDrawFlags_Closed                   :: Closed;
    ImDrawFlags_JoinMiter                :: JoinMiter;
    ImDrawFlags_CapSquare                :: CapSquare;

    ImDrawFlags_AAFill                   :: AAFill;
    ImDrawFlags_AALines                  :: AALines;
    ImDrawFlags_AALineEnds               :: AALineEnds;

    ImDrawFlags_StrokeInside             :: StrokeInside;
    ImDrawFlags_StrokeCenter             :: StrokeCenter;
    ImDrawFlags_StrokeCenterBiased       :: StrokeCenterBiased;
    ImDrawFlags_StrokeOutside            :: StrokeOutside;
    ImDrawFlags_StrokeLegacy             :: StrokeLegacy;

    ImDrawFlags_TextNoPixelSnap          :: TextNoPixelSnap;
    ImDrawFlags_UseTexForRoundCorners    :: UseTexForRoundCorners;
    ImDrawFlags_UseVtxOffset             :: UseVtxOffset;
    ImDrawFlags_AllowTexForRoundCorners_ :: AllowTexForRoundCorners_;

    ImDrawFlags_RoundMask_               :: RoundMask_;
    ImDrawFlags_AllowInPushScope_        :: AllowInPushScope_;
    ImDrawFlags_AllowInFrameScope_       :: AllowInFrameScope_;
    ImDrawFlags_StrokeMask_              :: StrokeMask_;
    ImDrawFlags_InvalidMask_             :: InvalidMask_;

    ImDrawFlags_RoundCornersTopLeft      :: RoundCornersTopLeft;
    ImDrawFlags_RoundCornersTopRight     :: RoundCornersTopRight;
    ImDrawFlags_RoundCornersBottomLeft   :: RoundCornersBottomLeft;
    ImDrawFlags_RoundCornersBottomRight  :: RoundCornersBottomRight;
    ImDrawFlags_RoundCornersNone         :: RoundCornersNone;
    ImDrawFlags_RoundCornersAll          :: RoundCornersAll;
    ImDrawFlags_RoundCornersTop          :: RoundCornersTop;
    ImDrawFlags_RoundCornersBottom       :: RoundCornersBottom;
    ImDrawFlags_RoundCornersLeft         :: RoundCornersLeft;
    ImDrawFlags_RoundCornersRight        :: RoundCornersRight;
    ImDrawFlags_RoundCornersMask_        :: RoundCornersMask_;
}

// Draw command list
// This is the low-level list of polygons that ImGui:: functions are filling. At the end of the frame,
// all command lists are passed to your ImGuiIO::RenderDrawListFn function for rendering.
// Each dear imgui window contains its own ImDrawList. You can use ImGui::GetWindowDrawList() to
// access the current window draw list and draw custom primitives.
// You can interleave normal ImGui:: calls and adding primitives to the current draw list.
// In single viewport mode, top-left is == GetMainViewport()->Pos (generally 0,0), bottom-right is == GetMainViewport()->Pos+Size (generally io.DisplaySize).
// You are totally free to apply whatever transformation matrix you want to the data (depending on the use of the transformation you may want to apply it to ClipRect as well!)
// Important: Primitives are always added to the list and not culled (culling is done at higher-level by ImGui:: functions), if you use this API a lot consider coarse culling your drawn objects.
ImDrawList :: struct {
    CmdBuffer:             ImVector(ImDrawCmd); // Draw commands. Typically 1 command = 1 GPU draw call, unless the command is a callback.
    IdxBuffer:             ImVector(ImDrawIdx); // Index buffer. Each command consume ImDrawCmd::ElemCount of those
    VtxBuffer:             ImVector(ImDrawVert); // Vertex buffer.
    Flags:                 ImDrawFlags; // Current flags for drawing primitives.  Alter with PushDrawFlag()/PopDrawFlags() to adjust defaults to a given scope.

    _VtxCurrentIdx:        u32; // [Internal] generally == VtxBuffer.Size unless we are past 64K vertices, in which case this gets reset to 0.
    _Data:                 *ImDrawListSharedData; // Pointer to shared draw data (you can use ImGui::GetDrawListSharedData() to get the one from current ImGui context)
    _VtxWritePtr:          *ImDrawVert; // [Internal] point within VtxBuffer.Data after each add command (to avoid using the ImVector<> operators too much)
    _IdxWritePtr:          *ImDrawIdx; // [Internal] point within IdxBuffer.Data after each add command (to avoid using the ImVector<> operators too much)
    _Path:                 ImVector(ImVec2); // [Internal] current path building
    _CmdHeader:            ImDrawCmdHeader; // [Internal] template of active commands. Fields should match those of CmdBuffer.back().
    _Splitter:             ImDrawListSplitter; // [Internal] for channels api (note: prefer using your own persistent instance of ImDrawListSplitter!)
    _ClipRectStack:        ImVector(ImVec4); // [Internal]
    _TextureStack:         ImVector(ImTextureRef); // [Internal]
    _CallbacksDataBuf:     ImVector(ImU8); // [Internal]
    _DrawFlagsStack:       ImSmallStack_(ImDrawFlags, 3) = 3; // [Internal]
    _FringeScale:          float; // [Internal] anti-alias fringe is scaled by this value, this helps to keep things sharp while zooming at vertex buffer content
    _InvFringeScale:       float; // [internal] 1.0 / _FringeScale // FIXME: Consider renaming to _PixelDensity.
    _FringeScaleIsInteger: bool; // [Internal] true if 1/_FringeScale is a whole number, used to select fast path for rendering
    _OwnerName:            *u8; // Pointer to owner window's name for debugging

    // If you want to create ImDrawList instances, pass them ImGui::GetDrawListSharedData().
    // (advanced: you may create and use your own ImDrawListSharedData so you can use ImDrawList without ImGui, but that's more involved)
    Constructor :: (this: *ImDrawList, shared_data: *ImDrawListSharedData) -> void #cpp_method #foreign libimgui "_ZN10ImDrawListC1EP20ImDrawListSharedData";
    Destructor_Base :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawListD2Ev";
    Destructor :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawListD1Ev";

    PushClipRect :: (this: *ImDrawList, clip_rect_min: *ImVec2, clip_rect_max: *ImVec2, intersect_with_current_clip_rect := false) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList12PushClipRectERK6ImVec2S2_b";
    PushClipRect :: (this: *ImDrawList, clip_rect_min: ImVec2, clip_rect_max: ImVec2, intersect_with_current_clip_rect := false) #no_context {
        PushClipRect(this, *clip_rect_min, *clip_rect_max, intersect_with_current_clip_rect);
    }
    PushClipRectFullScreen :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList22PushClipRectFullScreenEv";
    PopClipRect :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11PopClipRectEv";
    PushTexture :: (this: *ImDrawList, tex_ref: ImTextureRef) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11PushTextureE12ImTextureRef";
    PopTexture :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList10PopTextureEv";
    PushDrawFlag :: (this: *ImDrawList, flags: ImDrawFlags, enabled: bool) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList12PushDrawFlagEib";
    PopDrawFlag :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11PopDrawFlagEv";

    // Primitives
    // - Filled shapes must always use clockwise winding order. The anti-aliasing fringe depends on it. Counter-clockwise shapes will have "inward" anti-aliasing.
    // - For rectangular primitives, "p_min" and "p_max" represent the upper-left and lower-right corners.
    // - For circle primitives, use "num_segments == 0" to automatically calculate tessellation (preferred).
    //   In older versions (until Dear ImGui 1.77) the AddCircle functions defaulted to num_segments == 12.
    //   In future versions we will use textures to provide cheaper and higher-quality circles.
    //   Use AddNgon() and AddNgonFilled() functions if you need to guarantee a specific number of sides.
    AddLine :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList7AddLineERK6ImVec2S2_jfi";
    AddLine :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddLine(this, *p1, *p2, col, thickness, flags);
    }
    AddLineH :: (this: *ImDrawList, min_x: float, max_x: float, y: float, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList8AddLineHEfffjfi";
    AddLineV :: (this: *ImDrawList, x: float, min_y: float, max_y: float, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList8AddLineVEfffjfi";
    AddRect :: (this: *ImDrawList, p_min: *ImVec2, p_max: *ImVec2, col: ImU32, rounding: float = 0.0, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList7AddRectERK6ImVec2S2_jffi";
    AddRect :: (this: *ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, rounding: float = 0.0, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddRect(this, *p_min, *p_max, col, rounding, thickness, flags);
    }
    AddRectFilled :: (this: *ImDrawList, p_min: *ImVec2, p_max: *ImVec2, col: ImU32, rounding: float = 0.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList13AddRectFilledERK6ImVec2S2_jfi";
    AddRectFilled :: (this: *ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, rounding: float = 0.0, flags: ImDrawFlags = 0) #no_context {
        AddRectFilled(this, *p_min, *p_max, col, rounding, flags);
    }
    AddRectFilledMultiColor :: (this: *ImDrawList, p_min: *ImVec2, p_max: *ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList23AddRectFilledMultiColorERK6ImVec2S2_jjjj";
    AddRectFilledMultiColor :: (this: *ImDrawList, p_min: ImVec2, p_max: ImVec2, col_upr_left: ImU32, col_upr_right: ImU32, col_bot_right: ImU32, col_bot_left: ImU32) #no_context {
        AddRectFilledMultiColor(this, *p_min, *p_max, col_upr_left, col_upr_right, col_bot_right, col_bot_left);
    }
    AddQuad :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, p4: *ImVec2, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList7AddQuadERK6ImVec2S2_S2_S2_jfi";
    AddQuad :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddQuad(this, *p1, *p2, *p3, *p4, col, thickness, flags);
    }
    AddQuadFilled :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, p4: *ImVec2, col: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList13AddQuadFilledERK6ImVec2S2_S2_S2_j";
    AddQuadFilled :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32) #no_context {
        AddQuadFilled(this, *p1, *p2, *p3, *p4, col);
    }
    AddTriangle :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11AddTriangleERK6ImVec2S2_S2_jfi";
    AddTriangle :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddTriangle(this, *p1, *p2, *p3, col, thickness, flags);
    }
    AddTriangleFilled :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, col: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList17AddTriangleFilledERK6ImVec2S2_S2_j";
    AddTriangleFilled :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32) #no_context {
        AddTriangleFilled(this, *p1, *p2, *p3, col);
    }
    AddCircle :: (this: *ImDrawList, center: *ImVec2, radius: float, col: ImU32, num_segments: s32 = 0, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList9AddCircleERK6ImVec2fjifi";
    AddCircle :: (this: *ImDrawList, center: ImVec2, radius: float, col: ImU32, num_segments: s32 = 0, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddCircle(this, *center, radius, col, num_segments, thickness, flags);
    }
    AddCircleFilled :: (this: *ImDrawList, center: *ImVec2, radius: float, col: ImU32, num_segments: s32 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList15AddCircleFilledERK6ImVec2fji";
    AddCircleFilled :: (this: *ImDrawList, center: ImVec2, radius: float, col: ImU32, num_segments: s32 = 0) #no_context {
        AddCircleFilled(this, *center, radius, col, num_segments);
    }
    AddNgon :: (this: *ImDrawList, center: *ImVec2, radius: float, col: ImU32, num_segments: s32, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList7AddNgonERK6ImVec2fjifi";
    AddNgon :: (this: *ImDrawList, center: ImVec2, radius: float, col: ImU32, num_segments: s32, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddNgon(this, *center, radius, col, num_segments, thickness, flags);
    }
    AddNgonFilled :: (this: *ImDrawList, center: *ImVec2, radius: float, col: ImU32, num_segments: s32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList13AddNgonFilledERK6ImVec2fji";
    AddNgonFilled :: (this: *ImDrawList, center: ImVec2, radius: float, col: ImU32, num_segments: s32) #no_context {
        AddNgonFilled(this, *center, radius, col, num_segments);
    }
    AddEllipse :: (this: *ImDrawList, center: *ImVec2, radius: *ImVec2, col: ImU32, rot: float = 0.0, num_segments: s32 = 0, thickness: float = 1.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList10AddEllipseERK6ImVec2S2_jfifi";
    AddEllipse :: (this: *ImDrawList, center: ImVec2, radius: ImVec2, col: ImU32, rot: float = 0.0, num_segments: s32 = 0, thickness: float = 1.0, flags: ImDrawFlags = 0) #no_context {
        AddEllipse(this, *center, *radius, col, rot, num_segments, thickness, flags);
    }
    AddEllipseFilled :: (this: *ImDrawList, center: *ImVec2, radius: *ImVec2, col: ImU32, rot: float = 0.0, num_segments: s32 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList16AddEllipseFilledERK6ImVec2S2_jfi";
    AddEllipseFilled :: (this: *ImDrawList, center: ImVec2, radius: ImVec2, col: ImU32, rot: float = 0.0, num_segments: s32 = 0) #no_context {
        AddEllipseFilled(this, *center, *radius, col, rot, num_segments);
    }
    AddText :: (this: *ImDrawList, pos: *ImVec2, col: ImU32, text_begin: *u8, text_end: *u8 = null) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList7AddTextERK6ImVec2jPKcS4_";
    AddText :: (this: *ImDrawList, pos: ImVec2, col: ImU32, text_begin: *u8, text_end: *u8 = null) #no_context {
        AddText(this, *pos, col, text_begin, text_end);
    }
    AddText :: (this: *ImDrawList, font: *ImFont, font_size: float, pos: *ImVec2, col: ImU32, text_begin: *u8, text_end: *u8 = null, wrap_width: float = 0.0, cpu_fine_clip_rect: *ImVec4 = null) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList7AddTextEP6ImFontfRK6ImVec2jPKcS6_fPK6ImVec4";
    AddText :: (this: *ImDrawList, font: *ImFont, font_size: float, pos: ImVec2, col: ImU32, text_begin: *u8, text_end: *u8 = null, wrap_width: float = 0.0, cpu_fine_clip_rect: *ImVec4 = null) #no_context {
        AddText(this, font, font_size, *pos, col, text_begin, text_end, wrap_width, cpu_fine_clip_rect);
    }
    AddBezierCubic :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, p4: *ImVec2, col: ImU32, thickness: float, num_segments: s32 = 0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList14AddBezierCubicERK6ImVec2S2_S2_S2_jfii";
    AddBezierCubic :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, col: ImU32, thickness: float, num_segments: s32 = 0, flags: ImDrawFlags = 0) #no_context {
        AddBezierCubic(this, *p1, *p2, *p3, *p4, col, thickness, num_segments, flags);
    }
    AddBezierQuadratic :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, col: ImU32, thickness: float, num_segments: s32 = 0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList18AddBezierQuadraticERK6ImVec2S2_S2_jfii";
    AddBezierQuadratic :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, p3: ImVec2, col: ImU32, thickness: float, num_segments: s32 = 0, flags: ImDrawFlags = 0) #no_context {
        AddBezierQuadratic(this, *p1, *p2, *p3, col, thickness, num_segments, flags);
    }

    AddConvexPolyFilled :: (this: *ImDrawList, points: *ImVec2, num_points: s32, col: ImU32, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList19AddConvexPolyFilledEPK6ImVec2iji";
    AddConcavePolyFilled :: (this: *ImDrawList, points: *ImVec2, num_points: s32, col: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList20AddConcavePolyFilledEPK6ImVec2ij";

    // Image primitives
    // - Read FAQ to understand what ImTextureID/ImTextureRef are.
    // - "p_min" and "p_max" represent the upper-left and lower-right corners of the rectangle.
    // - "uv_min" and "uv_max" represent the normalized texture coordinates to use for those corners. Using (0,0)->(1,1) texture coordinates will generally display the entire texture.
    AddImage :: (this: *ImDrawList, tex_ref: ImTextureRef, p_min: *ImVec2, p_max: *ImVec2, uv_min: *ImVec2, uv_max: *ImVec2, col: ImU32 = 4294967295) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList8AddImageE12ImTextureRefRK6ImVec2S3_S3_S3_j";
    AddImage :: (this: *ImDrawList, tex_ref: ImTextureRef, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2 = ImVec2.{0, 0}, uv_max: ImVec2 = ImVec2.{1, 1}, col: ImU32 = 4294967295) #no_context {
        AddImage(this, tex_ref, *p_min, *p_max, *uv_min, *uv_max, col);
    }
    AddImageQuad :: (this: *ImDrawList, tex_ref: ImTextureRef, p1: *ImVec2, p2: *ImVec2, p3: *ImVec2, p4: *ImVec2, uv1: *ImVec2, uv2: *ImVec2, uv3: *ImVec2, uv4: *ImVec2, col: ImU32 = 4294967295) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList12AddImageQuadE12ImTextureRefRK6ImVec2S3_S3_S3_S3_S3_S3_S3_j";
    AddImageQuad :: (this: *ImDrawList, tex_ref: ImTextureRef, p1: ImVec2, p2: ImVec2, p3: ImVec2, p4: ImVec2, uv1: ImVec2 = ImVec2.{0, 0}, uv2: ImVec2 = ImVec2.{1, 0}, uv3: ImVec2 = ImVec2.{1, 1}, uv4: ImVec2 = ImVec2.{0, 1}, col: ImU32 = 4294967295) #no_context {
        AddImageQuad(this, tex_ref, *p1, *p2, *p3, *p4, *uv1, *uv2, *uv3, *uv4, col);
    }
    AddImageRounded :: (this: *ImDrawList, tex_ref: ImTextureRef, p_min: *ImVec2, p_max: *ImVec2, uv_min: *ImVec2, uv_max: *ImVec2, col: ImU32, rounding: float, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList15AddImageRoundedE12ImTextureRefRK6ImVec2S3_S3_S3_jfi";
    AddImageRounded :: (this: *ImDrawList, tex_ref: ImTextureRef, p_min: ImVec2, p_max: ImVec2, uv_min: ImVec2, uv_max: ImVec2, col: ImU32, rounding: float, flags: ImDrawFlags = 0) #no_context {
        AddImageRounded(this, tex_ref, *p_min, *p_max, *uv_min, *uv_max, col, rounding, flags);
    }

    PathArcTo :: (this: *ImDrawList, center: *ImVec2, radius: float, a_min: float, a_max: float, num_segments: s32 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList9PathArcToERK6ImVec2fffi";
    PathArcTo :: (this: *ImDrawList, center: ImVec2, radius: float, a_min: float, a_max: float, num_segments: s32 = 0) #no_context {
        PathArcTo(this, *center, radius, a_min, a_max, num_segments);
    }
    PathArcToFast :: (this: *ImDrawList, center: *ImVec2, radius: float, a_min_of_12: s32, a_max_of_12: s32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList13PathArcToFastERK6ImVec2fii";
    PathArcToFast :: (this: *ImDrawList, center: ImVec2, radius: float, a_min_of_12: s32, a_max_of_12: s32) #no_context {
        PathArcToFast(this, *center, radius, a_min_of_12, a_max_of_12);
    }
    PathEllipticalArcTo :: (this: *ImDrawList, center: *ImVec2, radius: *ImVec2, rot: float, a_min: float, a_max: float, num_segments: s32 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList19PathEllipticalArcToERK6ImVec2S2_fffi";
    PathEllipticalArcTo :: (this: *ImDrawList, center: ImVec2, radius: ImVec2, rot: float, a_min: float, a_max: float, num_segments: s32 = 0) #no_context {
        PathEllipticalArcTo(this, *center, *radius, rot, a_min, a_max, num_segments);
    }
    PathBezierCubicCurveTo :: (this: *ImDrawList, p2: *ImVec2, p3: *ImVec2, p4: *ImVec2, num_segments: s32 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList22PathBezierCubicCurveToERK6ImVec2S2_S2_i";
    PathBezierCubicCurveTo :: (this: *ImDrawList, p2: ImVec2, p3: ImVec2, p4: ImVec2, num_segments: s32 = 0) #no_context {
        PathBezierCubicCurveTo(this, *p2, *p3, *p4, num_segments);
    }
    PathBezierQuadraticCurveTo :: (this: *ImDrawList, p2: *ImVec2, p3: *ImVec2, num_segments: s32 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList26PathBezierQuadraticCurveToERK6ImVec2S2_i";
    PathBezierQuadraticCurveTo :: (this: *ImDrawList, p2: ImVec2, p3: ImVec2, num_segments: s32 = 0) #no_context {
        PathBezierQuadraticCurveTo(this, *p2, *p3, num_segments);
    }
    PathRect :: (this: *ImDrawList, rect_min: *ImVec2, rect_max: *ImVec2, rounding: float = 0.0, flags: ImDrawFlags = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList8PathRectERK6ImVec2S2_fi";
    PathRect :: (this: *ImDrawList, rect_min: ImVec2, rect_max: ImVec2, rounding: float = 0.0, flags: ImDrawFlags = 0) #no_context {
        PathRect(this, *rect_min, *rect_max, rounding, flags);
    }

    // Advanced: Draw Callbacks
    // - May be used to alter render state (change sampler, blending, current shader). May be used to emit custom rendering commands (difficult to do correctly, but possible).
    // - Use special GetPlatformIO().DrawCallback_ResetRenderState callback to instruct backend to reset its render state to the default.
    // - See other standard callbacks in GetPlatformIO(), which may or not be supported by your backend.
    // - Your rendering loop must check for 'UserCallback' in ImDrawCmd and call the function instead of rendering triangles. All standard backends are honoring this.
    // - For some backends, the callback may access selected render-states exposed by the backend in a ImGui_ImplXXXX_RenderState structure pointed to by platform_io.Renderer_RenderState.
    // - IMPORTANT: please be mindful of the different level of indirection between using size==0 (copying argument) and using size>0 (copying pointed data into a buffer).
    //   - If userdata_size == 0: we copy/store the 'userdata' argument as-is. It will be available unmodified in ImDrawCmd::UserCallbackData during render.
    //   - If userdata_size > 0,  we copy/store 'userdata_size' bytes pointed to by 'userdata'. We store them in a buffer stored inside the drawlist. ImDrawCmd::UserCallbackData will point inside that buffer so you have to retrieve data from there. Your callback may need to use ImDrawCmd::UserCallbackDataSize if you expect dynamically-sized data.
    //   - Support for userdata_size > 0 was added in v1.91.4, October 2024. So earlier code always only allowed to copy/store a simple void*.
    AddCallback :: (this: *ImDrawList, callback: ImDrawCallback, userdata: *void = null, userdata_size: u64 = 0) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11AddCallbackEPFvPKS_PK9ImDrawCmdEPvm";

    // Advanced: Miscellaneous
    AddDrawCmd :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList10AddDrawCmdEv";
    CloneOutput :: (this: *ImDrawList) -> *ImDrawList #cpp_method #foreign libimgui "_ZNK10ImDrawList11CloneOutputEv";

    // Advanced: Primitives allocations
    // - We render triangles (three vertices)
    // - All primitives needs to be reserved via PrimReserve() beforehand.
    PrimReserve :: (this: *ImDrawList, idx_count: s32, vtx_count: s32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11PrimReserveEii";
    PrimUnreserve :: (this: *ImDrawList, idx_count: s32, vtx_count: s32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList13PrimUnreserveEii";
    PrimRect :: (this: *ImDrawList, a: *ImVec2, b: *ImVec2, col: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList8PrimRectERK6ImVec2S2_j";
    PrimRect :: (this: *ImDrawList, a: ImVec2, b: ImVec2, col: ImU32) #no_context {
        PrimRect(this, *a, *b, col);
    }
    PrimRectUV :: (this: *ImDrawList, a: *ImVec2, b: *ImVec2, uv_a: *ImVec2, uv_b: *ImVec2, col: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList10PrimRectUVERK6ImVec2S2_S2_S2_j";
    PrimRectUV :: (this: *ImDrawList, a: ImVec2, b: ImVec2, uv_a: ImVec2, uv_b: ImVec2, col: ImU32) #no_context {
        PrimRectUV(this, *a, *b, *uv_a, *uv_b, col);
    }
    PrimQuadUV :: (this: *ImDrawList, a: *ImVec2, b: *ImVec2, c: *ImVec2, d: *ImVec2, uv_a: *ImVec2, uv_b: *ImVec2, uv_c: *ImVec2, uv_d: *ImVec2, col: ImU32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList10PrimQuadUVERK6ImVec2S2_S2_S2_S2_S2_S2_S2_j";
    PrimQuadUV :: (this: *ImDrawList, a: ImVec2, b: ImVec2, c: ImVec2, d: ImVec2, uv_a: ImVec2, uv_b: ImVec2, uv_c: ImVec2, uv_d: ImVec2, col: ImU32) #no_context {
        PrimQuadUV(this, *a, *b, *c, *d, *uv_a, *uv_b, *uv_c, *uv_d, col);
    }

    // [Internal helpers]
    _SetDrawListSharedData :: (this: *ImDrawList, data: *ImDrawListSharedData) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList22_SetDrawListSharedDataEP20ImDrawListSharedData";
    _ResetForNewFrame :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList17_ResetForNewFrameEv";
    _SetPixelDensity :: (this: *ImDrawList, pixel_density: float) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList16_SetPixelDensityEf";
    _ClearFreeMemory :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList16_ClearFreeMemoryEv";
    _PopUnusedDrawCmd :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList17_PopUnusedDrawCmdEv";
    _TryMergeDrawCmds :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList17_TryMergeDrawCmdsEv";
    _OnChangedClipRect :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList18_OnChangedClipRectEv";
    _OnChangedTexture :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList17_OnChangedTextureEv";
    _OnChangedVtxOffset :: (this: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList19_OnChangedVtxOffsetEv";
    _SetTexture :: (this: *ImDrawList, tex_ref: ImTextureRef) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11_SetTextureE12ImTextureRef";
    _CalcCircleAutoSegmentCount :: (this: *ImDrawList, radius: float) -> s32 #cpp_method #foreign libimgui "_ZNK10ImDrawList27_CalcCircleAutoSegmentCountEf";
    _PathArcToFastEx :: (this: *ImDrawList, center: *ImVec2, radius: float, a_min_sample: s32, a_max_sample: s32, a_step: s32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList16_PathArcToFastExERK6ImVec2fiii";
    _PathArcToFastEx :: (this: *ImDrawList, center: ImVec2, radius: float, a_min_sample: s32, a_max_sample: s32, a_step: s32) #no_context {
        _PathArcToFastEx(this, *center, radius, a_min_sample, a_max_sample, a_step);
    }
    _PathArcToN :: (this: *ImDrawList, center: *ImVec2, radius: float, a_min: float, a_max: float, num_segments: s32) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList11_PathArcToNERK6ImVec2fffi";
    _PathArcToN :: (this: *ImDrawList, center: ImVec2, radius: float, a_min: float, a_max: float, num_segments: s32) #no_context {
        _PathArcToN(this, *center, radius, a_min, a_max, num_segments);
    }
    _AddRectFilledBaked :: (this: *ImDrawList, p_min: *ImVec2, p_max: *ImVec2, col: ImU32, r: float, tex_uvs: *ImVec4, flags: ImDrawFlags) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList19_AddRectFilledBakedERK6ImVec2S2_jfRK6ImVec4i";
    _AddRectFilledBaked :: (this: *ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, r: float, tex_uvs: ImVec4, flags: ImDrawFlags) #no_context {
        _AddRectFilledBaked(this, *p_min, *p_max, col, r, *tex_uvs, flags);
    }
    _AddRectBaked :: (this: *ImDrawList, p_min: *ImVec2, p_max: *ImVec2, col: ImU32, r: float, t: float, tex_uvs: *ImVec4, flags: ImDrawFlags) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList13_AddRectBakedERK6ImVec2S2_jffRK6ImVec4i";
    _AddRectBaked :: (this: *ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, r: float, t: float, tex_uvs: ImVec4, flags: ImDrawFlags) #no_context {
        _AddRectBaked(this, *p_min, *p_max, col, r, t, *tex_uvs, flags);
    }
    _AddLine :: (this: *ImDrawList, p1: *ImVec2, p2: *ImVec2, col: ImU32, thickness: float, flags: ImDrawFlags) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList8_AddLineERK6ImVec2S2_jfi";
    _AddLine :: (this: *ImDrawList, p1: ImVec2, p2: ImVec2, col: ImU32, thickness: float, flags: ImDrawFlags) #no_context {
        _AddLine(this, *p1, *p2, col, thickness, flags);
    }
    _AddRectTinyRounding :: (this: *ImDrawList, p_min: *ImVec2, p_max: *ImVec2, col: ImU32, rounding: float, thickness: float, flags: ImDrawFlags) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList20_AddRectTinyRoundingERK6ImVec2S2_jffi";
    _AddRectTinyRounding :: (this: *ImDrawList, p_min: ImVec2, p_max: ImVec2, col: ImU32, rounding: float, thickness: float, flags: ImDrawFlags) #no_context {
        _AddRectTinyRounding(this, *p_min, *p_max, col, rounding, thickness, flags);
    }
    _SelectLineTexture :: (this: *ImDrawList, screen_thickness: float, out_uv0: *ImVec2, out_uv1: *ImVec2, out_fringe: *float, flags: ImDrawFlags) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList18_SelectLineTextureEfP6ImVec2S1_Pfi";
    _CalculateCenterBiasedOffset :: (this: *ImDrawList, thickness: float) -> float #cpp_method #foreign libimgui "_ZN10ImDrawList28_CalculateCenterBiasedOffsetEf";
    _AddPolyline :: (this: *ImDrawList, points: *ImVec2, num_points: s32, col: ImU32, thickness: float, flags: ImDrawFlags, max_inner_offset: float) -> void #cpp_method #foreign libimgui "_ZN10ImDrawList12_AddPolylineEPK6ImVec2ijfif";
}

// All draw data to render a Dear ImGui frame
// (NB: the style and the naming convention here is a little inconsistent, we currently preserve them for backward compatibility purpose,
// as this is one of the oldest structure exposed by the library! Basically, ImDrawList == CmdList)
ImDrawData :: struct {
    Valid:            bool; // Only valid after Render() is called and before the next NewFrame() is called.
    FrameCount:       s32; // Frame counter of the emitter context. Mostly for debugging purpose.
    TotalIdxCount:    s32; // For convenience, sum of all ImDrawList's IdxBuffer.Size
    TotalVtxCount:    s32; // For convenience, sum of all ImDrawList's VtxBuffer.Size
    CmdLists:         ImVector(*ImDrawList); // Array of ImDrawList* to render. The ImDrawLists are owned by ImGuiContext and only pointed to from here.
    DisplayPos:       ImVec2; // Top-left position of the viewport to render (== top-left of the orthogonal projection matrix to use) (== GetMainViewport()->Pos for the main viewport, == (0.0) in most single-viewport applications)
    DisplaySize:      ImVec2; // Size of the viewport to render (== GetMainViewport()->Size for the main viewport, == io.DisplaySize in most single-viewport applications)
    FramebufferScale: ImVec2; // Amount of pixels for each unit of DisplaySize. Copied from viewport->FramebufferScale (== io.DisplayFramebufferScale for main viewport). Generally (1,1) on normal display, (2,2) on OSX with Retina display.
    OwnerViewport:    *ImGuiViewport; // Viewport carrying the ImDrawData instance, might be of use to the renderer (generally not).
    Textures:         *ImVector(*ImTextureData); // List of textures to update. Most of the times the list is shared by all ImDrawData, has only 1 texture and it doesn't need any update. This almost always points to ImGui::GetPlatformIO().Textures[]. May be overridden or set to NULL if you want to manually update textures.

    CmdListsCount:    s32; // [OBSOLETED in 1.92.9] Use CmdLists.Size instead. Number of ImDrawList* to render.

    Clear :: (this: *ImDrawData) -> void #cpp_method #foreign libimgui "_ZN10ImDrawData5ClearEv";
    AddDrawList :: (this: *ImDrawData, draw_list: *ImDrawList) -> void #cpp_method #foreign libimgui "_ZN10ImDrawData11AddDrawListEP10ImDrawList";
    DeIndexAllBuffers :: (this: *ImDrawData) -> void #cpp_method #foreign libimgui "_ZN10ImDrawData17DeIndexAllBuffersEv";
    ScaleClipRects :: (this: *ImDrawData, fb_scale: *ImVec2) -> void #cpp_method #foreign libimgui "_ZN10ImDrawData14ScaleClipRectsERK6ImVec2";
    ScaleClipRects :: (this: *ImDrawData, fb_scale: ImVec2) #no_context {
        ScaleClipRects(this, *fb_scale);
    }
}

// We intentionally support a limited amount of texture formats to limit burden on CPU-side code and extension.
// Most standard backends only support RGBA32 but we provide a single channel option for low-resource/embedded systems.
ImTextureFormat :: enum u32 {
    RGBA32 :: 0;
    Alpha8 :: 1;

    ImTextureFormat_RGBA32 :: RGBA32;
    ImTextureFormat_Alpha8 :: Alpha8;
}

// Status of a texture to communicate with Renderer Backend.
ImTextureStatus :: enum u32 {
    OK          :: 0;
    Destroyed   :: 1;
    WantCreate  :: 2;
    WantUpdates :: 3;
    WantDestroy :: 4;

    ImTextureStatus_OK          :: OK;
    ImTextureStatus_Destroyed   :: Destroyed;
    ImTextureStatus_WantCreate  :: WantCreate;
    ImTextureStatus_WantUpdates :: WantUpdates;
    ImTextureStatus_WantDestroy :: WantDestroy;
}

// Coordinates of a rectangle within a texture.
// When a texture is in ImTextureStatus_WantUpdates state, we provide a list of individual rectangles to copy to the graphics system.
// You may use ImTextureData::Updates[] for the list, or ImTextureData::UpdateBox for a single bounding box.
ImTextureRect :: struct {
    x: u16; // Upper-left coordinates of rectangle to update, within the parent Pixels[] array.
    y: u16; // Upper-left coordinates of rectangle to update, within the parent Pixels[] array.
    w: u16; // Size of rectangle to update (in pixels)
    h: u16; // Size of rectangle to update (in pixels)
}

// Specs and pixel storage for a texture used by Dear ImGui.
// This is only useful for (1) core library and (2) backends. End-user/applications do not need to care about this.
// Renderer Backends will create a GPU-side version of this.
// Why does we store two identifiers: TexID and BackendUserData?
// - ImTextureID    TexID           = lower-level identifier stored in ImDrawCmd. ImDrawCmd can refer to textures not created by the backend, and for which there's no ImTextureData.
// - void*          BackendUserData = higher-level opaque storage for backend own book-keeping. Some backends may have enough with TexID and not need both.
// In columns below: who reads/writes each fields? 'r'=read, 'w'=write, 'core'=main library, 'backend'=renderer backend
ImTextureData :: struct {
    UniqueID:             s32; // w    -   // [DEBUG] Sequential index to facilitate identifying a texture when debugging/printing. Unique per atlas.
    Status:               ImTextureStatus; // rw   rw  // ImTextureStatus_OK/_WantCreate/_WantUpdates/_WantDestroy. Always use SetStatus() to modify!
    BackendUserData:      *void; // -    rw  // Convenience storage for backend. Some backends may have enough with TexID.
    QueueUserData:        *void; // r    -   // Convenience storage for a staged/multi-threaded rendering texture queue (e.g. imgui_threaded_rendering.h. See #8597). When != NULL, core assumes the texture is referenced by the queue.
    TexID:                ImTextureID; // r    w   // Backend-specific texture identifier. Always use SetTexID() to modify! The identifier will stored in ImDrawCmd::GetTexID() and passed to backend's RenderDrawData function.
    Format:               ImTextureFormat; // w    r   // ImTextureFormat_RGBA32 (default) or ImTextureFormat_Alpha8
    Width:                s32; // w    r   // Texture width
    Height:               s32; // w    r   // Texture height
    BytesPerPixel:        s32; // w    r   // 4 or 1
    Pixels:               *u8; // w    r   // Pointer to whole texture buffer holding 'Width*Height' pixels and 'Width*Height*BytesPerPixels' bytes.
    UsedRect:             ImTextureRect; // w    r   // Bounding box encompassing all past and queued Updates[].
    UpdateRect:           ImTextureRect; // w    r   // Bounding box encompassing all queued Updates[].
    Updates:              ImVector(ImTextureRect); // w    r   // Array of individual updates.
    UnusedFrames:         s32; // w    r   // In order to facilitate handling Status==WantDestroy in some backend: this is a count successive frames where the texture was not used. Always >0 when Status==WantDestroy.
    RefCount:             u16; // w    r   // Number of contexts using this texture. Used during backend shutdown.
    UseColors:            bool; // w    r   // Tell whether our texture data is known to use colors (rather than just white + alpha).
    WantDestroyNextFrame: bool; // rw   -   // [Internal] Queued to set ImTextureStatus_WantDestroy next frame. May still be used in the current frame.

    Create :: (this: *ImTextureData, format: ImTextureFormat, w: s32, h: s32) -> void #cpp_method #foreign libimgui "_ZN13ImTextureData6CreateE15ImTextureFormatii";
    DestroyPixels :: (this: *ImTextureData) -> void #cpp_method #foreign libimgui "_ZN13ImTextureData13DestroyPixelsEv";
}

// A font input/source (we may rename this to ImFontSource in the future)
ImFontConfig :: struct {
    Name:                 [40] u8; // <auto>   // Name (strictly to ease debugging, hence limited size buffer)
    FontData:             *void; //          // TTF/OTF data
    FontDataSize:         s32; //          // TTF/OTF data size
    FontDataOwnedByAtlas: bool; // true     // TTF/OTF data ownership taken by the owner ImFontAtlas (will delete memory itself). SINCE 1.92, THE DATA NEEDS TO PERSIST FOR WHOLE DURATION OF ATLAS.

    MergeMode:            bool; // false    // Merge into previous ImFont, so you can combine multiple inputs font into one ImFont (e.g. ASCII font + icons + Japanese glyphs). You may want to use GlyphOffset.y when merge font of different heights.
    PixelSnapH:           bool; // false    // Align every glyph AdvanceX to pixel boundaries. Prevents fractional font size from working correctly! Useful e.g. if you are merging a non-pixel aligned font with the default font. If enabled, OversampleH/V will default to 1.
    OversampleH:          ImS8; // 0 (2)    // Rasterize at higher quality for sub-pixel positioning. 0 == auto == 1 or 2 depending on size. Note the difference between 2 and 3 is minimal. You can reduce this to 1 for large glyphs save memory. Read https://github.com/nothings/stb/blob/master/tests/oversample/README.md for details.
    OversampleV:          ImS8; // 0 (1)    // Rasterize at higher quality for sub-pixel positioning. 0 == auto == 1. This is not really useful as we don't use sub-pixel positions on the Y axis.
    EllipsisChar:         ImWchar; // 0        // Explicitly specify Unicode codepoint of ellipsis character. When fonts are being merged first specified ellipsis will be used.
    SizePixels:           float; //          // Output size in pixels for rasterizer (more or less maps to the resulting font height).
    GlyphRanges:          *ImWchar; // NULL     // *LEGACY* THE ARRAY DATA NEEDS TO PERSIST AS LONG AS THE FONT IS ALIVE. Pointer to a user-provided list of Unicode range (2 value per range, values are inclusive, zero-terminated list).
    GlyphExcludeRanges:   *ImWchar; // NULL     // Pointer to a small user-provided list of Unicode ranges (2 value per range, values are inclusive, zero-terminated list). This is very close to GlyphRanges[] but designed to exclude ranges from a font source, when merging fonts with overlapping glyphs. Use "Input Glyphs Overlap Detection Tool" to find about your overlapping ranges.

    GlyphOffset:          ImVec2; // 0, 0     // Offset (in pixels) all glyphs from this font input. Absolute value for default size, other sizes will scale this value.
    GlyphMinAdvanceX:     float; // 0        // Minimum AdvanceX for glyphs, set Min to align font icons, set both Min/Max to enforce mono-space font. Absolute value for default size, other sizes will scale this value.
    GlyphMaxAdvanceX:     float; // FLT_MAX  // Maximum AdvanceX for glyphs
    GlyphExtraAdvanceX:   float; // 0        // Extra spacing (in pixels) between glyphs. Please contact us if you are using this. // FIXME-NEWATLAS: Intentionally unscaled
    FontNo:               ImU32; // 0        // Index of font within TTF/OTF file
    FontLoaderFlags:      u32; // 0        // Settings for custom font builder. THIS IS BUILDER IMPLEMENTATION DEPENDENT. Leave as zero if unsure.

    RasterizerMultiply:   float; // 1.0f     // Linearly brighten (>1.0f) or darken (<1.0f) font output. Brightening small fonts may be a good workaround to make them more readable. This is a silly thing we may remove in the future.
    RasterizerDensity:    float; // 1.0f     // [LEGACY: this only makes sense when ImGuiBackendFlags_RendererHasTextures is not supported] DPI scale multiplier for rasterization. Not altering other font metrics: makes it easy to swap between e.g. a 100% and a 400% fonts for a zooming display, or handle Retina screen. IMPORTANT: If you change this it is expected that you increase/decrease font scale roughly to the inverse of this, otherwise quality may look lowered.
    ExtraSizeScale:       float; // 1.0f     // Extra rasterizer scale over SizePixels.

    Flags:                ImFontFlags; // Font flags (don't use just yet, will be exposed in upcoming 1.92.X updates)
    DstFont:              *ImFont; // Target font (as we merging fonts, multiple ImFontConfig may target the same font)
    FontLoader:           *ImFontLoader; // Custom font backend for this source (default source is the one stored in ImFontAtlas)
    FontLoaderData:       *void; // Font loader opaque storage (per font config)

    PixelSnapV:           bool; // true    // [Obsoleted in 1.91.6] Align Scaled GlyphOffset.y to pixel boundaries.

    Constructor :: (this: *ImFontConfig) -> void #cpp_method #foreign libimgui "_ZN12ImFontConfigC1Ev";
}

// Hold rendering data for one glyph.
// (Note: some language parsers may fail to convert the bitfield members, in this case maybe drop store a single u32 or we can rework this)
ImFontGlyph :: struct {
    __bitfield: u32;
    /* 
        Colored: u32; /* 1 bits */ // Flag to indicate glyph is colored and should generally ignore tinting (make it usable with no shift on little-endian as this is used in loops)
        Visible: u32; /* 1 bits */ // Flag to indicate glyph has no visible pixels (e.g. space). Allow early out when rendering.
        SourceIdx: u32; /* 4 bits */ // Index of source in parent font
        Codepoint: u32; /* 26 bits */ // 0x0000..0x10FFFF;
    */

    AdvanceX:   float; // Horizontal distance to advance cursor/layout position.
    X0:         float; // Glyph corners. Offsets from current cursor/layout position.
    Y0:         float; // Glyph corners. Offsets from current cursor/layout position.
    X1:         float; // Glyph corners. Offsets from current cursor/layout position.
    Y1:         float; // Glyph corners. Offsets from current cursor/layout position.
    U0:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    V0:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    U1:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    V1:         float; // Texture coordinates for the current value of ImFontAtlas->TexRef. Cached equivalent of calling GetCustomRect() with PackId.
    PackId:     s32; // [Internal] ImFontAtlasRectId value (FIXME: Cold data, could be moved elsewhere?)
}

set_Colored :: (fields: *ImFontGlyph, value: bool) {
    if value fields.__bitfield |= 1 << 0;
    else     fields.__bitfield &= ~cast(u32)(1 << 0);
}
get_Colored :: (fields: ImFontGlyph) -> bool {
    return (fields.__bitfield & (1 << 0)) != 0;
}

set_Visible :: (fields: *ImFontGlyph, value: bool) {
    if value fields.__bitfield |= 1 << 1;
    else     fields.__bitfield &= ~cast(u32)(1 << 1);
}
get_Visible :: (fields: ImFontGlyph) -> bool {
    return (fields.__bitfield & (1 << 1)) != 0;
}

set_SourceIdx :: (fields: *ImFontGlyph, value: u32) {
    MASK0: u32 : (0b1111 << 2);
    fields.__bitfield = (fields.__bitfield & ~MASK0) | ((value << 2) & MASK0);
}
get_SourceIdx :: (fields: ImFontGlyph) -> u32 {
    return ((fields.__bitfield & (0b1111 << 2)) >> 2);
}

set_Codepoint :: (fields: *ImFontGlyph, value: u32) {
    MASK0: u32 : (0b11_1111_1111_1111_1111_1111_1111 << 6);
    fields.__bitfield = (fields.__bitfield & ~MASK0) | ((value << 6) & MASK0);
}
get_Codepoint :: (fields: ImFontGlyph) -> u32 {
    return ((fields.__bitfield & (0b11_1111_1111_1111_1111_1111_1111 << 6)) >> 6);
}


// Helper to build glyph ranges from text/string data. Feed your application strings/characters to it then call BuildRanges().
// This is essentially a tightly packed of vector of 64k booleans = 8KB storage.
ImFontGlyphRangesBuilder :: struct {
    UsedChars: ImVector(ImU32); // Store 1-bit per Unicode code point (0=unused, 1=used)

    AddText :: (this: *ImFontGlyphRangesBuilder, text: *u8, text_end: *u8 = null) -> void #cpp_method #foreign libimgui "_ZN24ImFontGlyphRangesBuilder7AddTextEPKcS1_";
    AddRanges :: (this: *ImFontGlyphRangesBuilder, ranges: *ImWchar) -> void #cpp_method #foreign libimgui "_ZN24ImFontGlyphRangesBuilder9AddRangesEPKt";
    BuildRanges :: (this: *ImFontGlyphRangesBuilder, out_ranges: *ImVector(ImWchar)) -> void #cpp_method #foreign libimgui "_ZN24ImFontGlyphRangesBuilder11BuildRangesEP8ImVectorItE";
}

// An opaque identifier to a rectangle in the atlas. -1 when invalid.
// The rectangle may move and UV may be invalidated, use GetCustomRect() to retrieve it.
ImFontAtlasRectId :: s32;

// Output of ImFontAtlas::GetCustomRect() when using custom rectangles.
// Those values may not be cached/stored as they are only valid for the current value of atlas->TexRef
// (this is in theory derived from ImTextureRect but we use separate structures for reasons)
ImFontAtlasRect :: struct {
    x:   u16; // Position (in current texture)
    y:   u16; // Position (in current texture)
    w:   u16; // Size
    h:   u16; // Size
    uv0: ImVec2; // UV coordinates (in current texture)
    uv1: ImVec2; // UV coordinates (in current texture)
}

// Flags for ImFontAtlas build
ImFontAtlasFlags_ :: enum u32 {
    None                :: 0;
    NoPowerOfTwoHeight  :: 1;
    NoMouseCursors      :: 2;
    NoBakedLines        :: 4;
    NoBakedRoundCorners :: 8;

    ImFontAtlasFlags_None                :: None;
    ImFontAtlasFlags_NoPowerOfTwoHeight  :: NoPowerOfTwoHeight;
    ImFontAtlasFlags_NoMouseCursors      :: NoMouseCursors;
    ImFontAtlasFlags_NoBakedLines        :: NoBakedLines;
    ImFontAtlasFlags_NoBakedRoundCorners :: NoBakedRoundCorners;
}

// Load and rasterize multiple TTF/OTF fonts into a same texture. The font atlas will build a single texture holding:
//  - One or more fonts.
//  - Custom graphics data needed to render the shapes needed by Dear ImGui.
//  - Mouse cursor shapes for software cursor rendering (unless setting 'Flags |= ImFontAtlasFlags_NoMouseCursors' in the font atlas).
//  - If you don't call any AddFont*** functions, the default font embedded in the code will be loaded for you.
// It is the rendering backend responsibility to upload texture into your graphics API:
//  - ImGui_ImplXXXX_RenderDrawData() functions generally iterate platform_io->Textures[] to create/update/destroy each ImTextureData instance.
//  - Backend then set ImTextureData's TexID and BackendUserData.
//  - Texture id are passed back to you during rendering to identify the texture. Read FAQ entry about ImTextureID/ImTextureRef for more details.
// Legacy path:
//  - Call Build() + GetTexDataAsAlpha8() or GetTexDataAsRGBA32() to build and retrieve pixels data.
//  - Call SetTexID(my_tex_id); and pass the pointer/identifier to your texture in a format natural to your graphics API.
// Common pitfalls:
// - If you pass a 'glyph_ranges' array to AddFont*** functions, you need to make sure that your array persists up until the
//   atlas is build (when calling GetTexData*** or Build()). We only copy the pointer, not the data.
// - Important: By default, AddFontFromMemoryTTF() takes ownership of the data. Even though we are not writing to it, we will free the pointer on destruction.
//   You can set font_cfg->FontDataOwnedByAtlas=false to keep ownership of your data and it won't be freed,
// - Even though many functions are suffixed with "TTF", OTF data is supported just as well.
// - This is an old API and it is currently awkward for those and various other reasons! We will address them in the future!
ImFontAtlas :: struct {
    Constructor :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlasC1Ev";
    Destructor_Base :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlasD2Ev";
    Destructor :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlasD1Ev";
    AddFont :: (this: *ImFontAtlas, font_cfg: *ImFontConfig) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas7AddFontEPK12ImFontConfig";
    AddFontDefault :: (this: *ImFontAtlas, font_cfg: *ImFontConfig = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas14AddFontDefaultEPK12ImFontConfig";
    AddFontDefaultVector :: (this: *ImFontAtlas, font_cfg: *ImFontConfig = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas20AddFontDefaultVectorEPK12ImFontConfig";
    AddFontDefaultBitmap :: (this: *ImFontAtlas, font_cfg: *ImFontConfig = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas20AddFontDefaultBitmapEPK12ImFontConfig";
    AddFontFromFileTTF :: (this: *ImFontAtlas, filename: *u8, size_pixels: float = 0.0, font_cfg: *ImFontConfig = null, glyph_ranges: *ImWchar = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas18AddFontFromFileTTFEPKcfPK12ImFontConfigPKt";
    AddFontFromMemoryTTF :: (this: *ImFontAtlas, font_data: *void, font_data_size: s32, size_pixels: float = 0.0, font_cfg: *ImFontConfig = null, glyph_ranges: *ImWchar = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas20AddFontFromMemoryTTFEPvifPK12ImFontConfigPKt";
    AddFontFromMemoryCompressedTTF :: (this: *ImFontAtlas, compressed_font_data: *void, compressed_font_data_size: s32, size_pixels: float = 0.0, font_cfg: *ImFontConfig = null, glyph_ranges: *ImWchar = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas30AddFontFromMemoryCompressedTTFEPKvifPK12ImFontConfigPKt";
    AddFontFromMemoryCompressedBase85TTF :: (this: *ImFontAtlas, compressed_font_data_base85: *u8, size_pixels: float = 0.0, font_cfg: *ImFontConfig = null, glyph_ranges: *ImWchar = null) -> *ImFont #cpp_method #foreign libimgui "_ZN11ImFontAtlas36AddFontFromMemoryCompressedBase85TTFEPKcfPK12ImFontConfigPKt";
    RemoveFont :: (this: *ImFontAtlas, font: *ImFont) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas10RemoveFontEP6ImFont";
    CompactCache :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas12CompactCacheEv";
    SetFontLoader :: (this: *ImFontAtlas, font_loader: *ImFontLoader) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas13SetFontLoaderEPK12ImFontLoader";

    // Clearing the atlas/fonts has little use nowadays, unless you want to batch remove all fonts.
    // - Since 1.92, you can call ClearFonts() mid-frame, if you load new fonts afterwards.
    // - As we are transitioning toward our new font system the semantic for those functions gets increasingly misleading and are often a source of issues.
    //   TL;DR; most likely, don't use any of those functions. We expect to obsolete/rework them.
    Clear :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas5ClearEv";
    ClearFonts :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas10ClearFontsEv";
    ClearInputData :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas14ClearInputDataEv";
    ClearTexData :: (this: *ImFontAtlas) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas12ClearTexDataEv";

    // Legacy path for build atlas + retrieving pixel data.
    // - User is in charge of copying the pixels into graphics memory (e.g. create a texture with your engine). Then store your texture handle with SetTexID().
    // - The pitch is always = Width * BytesPerPixels (1 or 4)
    // - Building in RGBA32 format is provided for convenience and compatibility, but note that unless you manually manipulate or copy color data into
    //   the texture (e.g. when using the AddCustomRect*** api), then the RGB pixels emitted will always be white (~75% of memory/bandwidth waste).
    // - From 1.92 with backends supporting ImGuiBackendFlags_RendererHasTextures:
    //   - Calling Build(), GetTexDataAsAlpha8(), GetTexDataAsRGBA32() is not needed.
    //   - In backend: replace calls to ImFontAtlas::SetTexID() with calls to ImTextureData::SetTexID() after honoring texture creation.
    Build :: (this: *ImFontAtlas) -> bool #cpp_method #foreign libimgui "_ZN11ImFontAtlas5BuildEv";
    GetTexDataAsAlpha8 :: (this: *ImFontAtlas, out_pixels: **u8, out_width: *s32, out_height: *s32, out_bytes_per_pixel: *s32 = null) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas18GetTexDataAsAlpha8EPPhPiS2_S2_";
    GetTexDataAsRGBA32 :: (this: *ImFontAtlas, out_pixels: **u8, out_width: *s32, out_height: *s32, out_bytes_per_pixel: *s32 = null) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas18GetTexDataAsRGBA32EPPhPiS2_S2_";

    // Since 1.92: specifying glyph ranges is only useful/necessary if your backend doesn't support ImGuiBackendFlags_RendererHasTextures!
    GetGlyphRangesDefault :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas21GetGlyphRangesDefaultEv";

    // Helpers to retrieve list of common Unicode ranges (2 value per range, values are inclusive, zero-terminated list)
    // NB: Make sure that your string are UTF-8 and NOT in your local code page.
    // Read https://github.com/ocornut/imgui/blob/master/docs/FONTS.md/#about-utf-8-encoding for details.
    // NB: Consider using ImFontGlyphRangesBuilder to build glyph ranges from textual data.
    GetGlyphRangesGreek :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas19GetGlyphRangesGreekEv";
    GetGlyphRangesKorean :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas20GetGlyphRangesKoreanEv";
    GetGlyphRangesJapanese :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas22GetGlyphRangesJapaneseEv";
    GetGlyphRangesChineseFull :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas25GetGlyphRangesChineseFullEv";
    GetGlyphRangesChineseSimplifiedCommon :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas37GetGlyphRangesChineseSimplifiedCommonEv";
    GetGlyphRangesCyrillic :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas22GetGlyphRangesCyrillicEv";
    GetGlyphRangesThai :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas18GetGlyphRangesThaiEv";
    GetGlyphRangesVietnamese :: (this: *ImFontAtlas) -> *ImWchar #cpp_method #foreign libimgui "_ZN11ImFontAtlas24GetGlyphRangesVietnameseEv";

    // Register and retrieve custom rectangles
    // - You can request arbitrary rectangles to be packed into the atlas, for your own purpose.
    // - Since 1.92.0, packing is done immediately in the function call (previously packing was done during the Build call)
    // - You can render your pixels into the texture right after calling the AddCustomRect() functions.
    // - VERY IMPORTANT:
    //   - Texture may be created/resized at any time when calling ImGui or ImFontAtlas functions.
    //   - IT WILL INVALIDATE RECTANGLE DATA SUCH AS UV COORDINATES. Always use latest values from GetCustomRect().
    //   - UV coordinates are associated to the current texture identifier aka 'atlas->TexRef'. Both TexRef and UV coordinates are typically changed at the same time.
    // - If you render colored output into your custom rectangles: set 'atlas->TexPixelsUseColors = true' as this may help some backends decide of preferred texture format.
    // - Read docs/FONTS.md for more details about using colorful icons.
    // - Note: this API may be reworked further in order to facilitate supporting e.g. multi-monitor, varying DPI settings.
    // - (Pre-1.92 names) ------------> (1.92 names)
    //   - GetCustomRectByIndex()   --> Use GetCustomRect()
    //   - CalcCustomRectUV()       --> Use GetCustomRect() and read uv0, uv1 fields.
    //   - AddCustomRectRegular()   --> Renamed to AddCustomRect()
    //   - AddCustomRectFontGlyph() --> Prefer using custom ImFontLoader inside ImFontConfig
    //   - ImFontAtlasCustomRect    --> Renamed to ImFontAtlasRect
    AddCustomRect :: (this: *ImFontAtlas, width: s32, height: s32, out_r: *ImFontAtlasRect = null) -> ImFontAtlasRectId #cpp_method #foreign libimgui "_ZN11ImFontAtlas13AddCustomRectEiiP15ImFontAtlasRect";
    RemoveCustomRect :: (this: *ImFontAtlas, id: ImFontAtlasRectId) -> void #cpp_method #foreign libimgui "_ZN11ImFontAtlas16RemoveCustomRectEi";
    GetCustomRect :: (this: *ImFontAtlas, id: ImFontAtlasRectId, out_r: *ImFontAtlasRect) -> bool #cpp_method #foreign libimgui "_ZNK11ImFontAtlas13GetCustomRectEiP15ImFontAtlasRect";

    Flags:               ImFontAtlasFlags; // Build flags (see ImFontAtlasFlags_)
    TexDesiredFormat:    ImTextureFormat; // Desired texture format (default to ImTextureFormat_RGBA32 but may be changed to ImTextureFormat_Alpha8).
    TexGlyphPadding:     s32; // FIXME: Should be called "TexPackPadding". Padding between glyphs within texture in pixels. Defaults to 1. If your rendering method never relies on bilinear filtering you may set this to 0.
    TexMinWidth:         s32; // Minimum desired texture width. Must be a power of two. Default to 512.
    TexMinHeight:        s32; // Minimum desired texture height. Must be a power of two. Default to 128.
    TexMaxWidth:         s32; // Maximum desired texture width. Must be a power of two. Default to 8192.
    TexMaxHeight:        s32; // Maximum desired texture height. Must be a power of two. Default to 8192.
    UserData:            *void; // Store your own atlas related user-data (if e.g. you have multiple font atlas).

    struct {
        TexRef: ImTextureRef; // Latest texture identifier == TexData->GetTexRef(). // RENAMED TexID to TexRef in 1.92.0.

        #overlay (TexRef) TexID: ImTextureRef; // Latest texture identifier == TexData->GetTexRef(). // RENAMED TexID to TexRef in 1.92.0.
    }

    TexData:             *ImTextureData; // Latest texture.

    TexList:             ImVector(*ImTextureData); // Texture list (most often TexList.Size == 1). TexData is always == TexList.back(). DO NOT USE DIRECTLY, USE GetDrawData().Textures[]/GetPlatformIO().Textures[] instead!
    Locked:              bool; // Marked as locked during ImGui::NewFrame()..EndFrame() scope if TexUpdates are not supported. Any attempt to modify the atlas will assert.
    RendererHasTextures: bool; // Copy of (BackendFlags & ImGuiBackendFlags_RendererHasTextures) from supporting context.
    TexIsBuilt:          bool; // Set when texture was built matching current font input. Mostly useful for legacy IsBuilt() call.
    TexPixelsUseColors:  bool; // Tell whether our texture data is known to use colors (rather than just alpha channel), in order to help backend select a format or conversion process.
    TexUvScale:          ImVec2; // = (1.0f/TexData->TexWidth, 1.0f/TexData->TexHeight). May change as new texture gets created.
    TexUvWhitePixel:     ImVec2; // Texture coordinates to a white pixel. May change as new texture gets created.
    Fonts:               ImVector(*ImFont); // Hold all the fonts returned by AddFont*. Fonts[0] is the default font upon calling ImGui::NewFrame(), use ImGui::PushFont()/PopFont() to change the current font.
    Sources:             ImVector(ImFontConfig); // Source/configuration data
    TexNextUniqueID:     s32; // Next value to be stored in TexData->UniqueID
    FontNextUniqueID:    s32; // Next value to be stored in ImFont->FontID
    DrawListSharedDatas: ImVector(*ImDrawListSharedData); // List of users for this atlas. Typically one per Dear ImGui context.
    Builder:             *ImFontAtlasBuilder; // Opaque interface to our data that doesn't need to be public and may be discarded when rebuilding.
    FontLoader:          *ImFontLoader; // Font loader opaque interface (default to use FreeType when IMGUI_ENABLE_FREETYPE is defined, otherwise default to use stb_truetype). Use SetFontLoader() to change this at runtime.
    FontLoaderName:      *u8; // Font loader name (for display e.g. in About box) == FontLoader->Name
    FontLoaderData:      *void; // Font backend opaque storage
    FontLoaderFlags:     u32; // Shared flags (for all fonts) for font loader. THIS IS BUILD IMPLEMENTATION DEPENDENT (e.g. Per-font override is also available in ImFontConfig).
    RefCount:            s32; // Number of contexts using this atlas
    OwnerContext:        *ImGuiContext; // Context which own the atlas will be in charge of updating and destroying it.

    TempRect:            ImFontAtlasRect; // For old GetCustomRectByIndex() API

    AddCustomRectFontGlyph :: (this: *ImFontAtlas, font: *ImFont, codepoint: ImWchar, w: s32, h: s32, advance_x: float, offset: *ImVec2) -> ImFontAtlasRectId #cpp_method #foreign libimgui "_ZN11ImFontAtlas22AddCustomRectFontGlyphEP6ImFonttiifRK6ImVec2";
    AddCustomRectFontGlyph :: (this: *ImFontAtlas, font: *ImFont, codepoint: ImWchar, w: s32, h: s32, advance_x: float, offset: ImVec2 = ImVec2.{0, 0}) -> ImFontAtlasRectId #no_context {
        return AddCustomRectFontGlyph(this, font, codepoint, w, h, advance_x, *offset);
    }
    AddCustomRectFontGlyphForSize :: (this: *ImFontAtlas, font: *ImFont, font_size: float, codepoint: ImWchar, w: s32, h: s32, advance_x: float, offset: *ImVec2) -> ImFontAtlasRectId #cpp_method #foreign libimgui "_ZN11ImFontAtlas29AddCustomRectFontGlyphForSizeEP6ImFontftiifRK6ImVec2";
    AddCustomRectFontGlyphForSize :: (this: *ImFontAtlas, font: *ImFont, font_size: float, codepoint: ImWchar, w: s32, h: s32, advance_x: float, offset: ImVec2 = ImVec2.{0, 0}) -> ImFontAtlasRectId #no_context {
        return AddCustomRectFontGlyphForSize(this, font, font_size, codepoint, w, h, advance_x, *offset);
    }
}

// Font runtime data for a given size
// Important: pointers to ImFontBaked are only valid for the current frame.
ImFontBaked :: struct {
    IndexAdvanceX:      ImVector(float); // 12-16 // out // Sparse. Glyphs->AdvanceX in a directly indexable way (cache-friendly for CalcTextSize functions which only this info, and are often bottleneck in large UI).
    FallbackAdvanceX:   float; // 4     // out // FindGlyph(FallbackChar)->AdvanceX
    Size:               float; // 4     // in  // Height of characters/line, set during loading (doesn't change after loading)
    RasterizerDensity:  float; // 4     // in  // Density this is baked at

    IndexLookup:        ImVector(ImU16); // 12-16 // out // Sparse. Index glyphs by Unicode code-point.
    Glyphs:             ImVector(ImFontGlyph); // 12-16 // out // All glyphs.
    FallbackGlyphIndex: s32; // 4     // out // Index of FontFallbackChar

    Ascent:             float; // 4+4   // out // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize] (unscaled)
    Descent:            float; // 4+4   // out // Ascent: distance from top to bottom of e.g. 'A' [0..FontSize] (unscaled)
    __bitfield:         u32;
    /* 
        MetricsTotalSurface: u32; /* 26 bits */ // 3  // out // Total surface in pixels to get an idea of the font rasterization/texture cost (not exact, we approximate the cost of padding between glyphs)
        WantDestroy: u32; /* 1 bits */ // 0  //     // Queued for destroy
        LoadNoFallback: u32; /* 1 bits */ // 0  //     // Disable loading fallback in lower-level calls.
        LoadNoRenderOnLayout: u32; /* 1 bits */ // 0  //     // Enable a two-steps mode where CalcTextSize() calls will load AdvanceX *without* rendering/packing glyphs. Only advantageous if you know that the glyph is unlikely to actually be rendered, otherwise it is slower because we'd do one query on the first CalcTextSize and one query on the first Draw.;
    */

    LastUsedFrame:      s32; // 4  //     // Record of that time this was bounds
    BakedId:            ImGuiID; // 4     //     // Unique ID for this baked storage
    OwnerFont:          *ImFont; // 4-8   // in  // Parent font
    FontLoaderDatas:    *void; // 4-8   //     // Font loader opaque storage (per baked font * sources): single contiguous buffer allocated by imgui, passed to loader.

    // Functions
    Constructor :: (this: *ImFontBaked) -> void #cpp_method #foreign libimgui "_ZN11ImFontBakedC1Ev";
    ClearOutputData :: (this: *ImFontBaked) -> void #cpp_method #foreign libimgui "_ZN11ImFontBaked15ClearOutputDataEv";
    FindGlyph :: (this: *ImFontBaked, c: ImWchar) -> *ImFontGlyph #cpp_method #foreign libimgui "_ZN11ImFontBaked9FindGlyphEt";
    FindGlyphNoFallback :: (this: *ImFontBaked, c: ImWchar) -> *ImFontGlyph #cpp_method #foreign libimgui "_ZN11ImFontBaked19FindGlyphNoFallbackEt";
    GetCharAdvance :: (this: *ImFontBaked, c: ImWchar) -> float #cpp_method #foreign libimgui "_ZN11ImFontBaked14GetCharAdvanceEt";
    IsGlyphLoaded :: (this: *ImFontBaked, c: ImWchar) -> bool #cpp_method #foreign libimgui "_ZN11ImFontBaked13IsGlyphLoadedEt";
}

set_MetricsTotalSurface :: (fields: *ImFontBaked, value: u32) {
    MASK0: u32 : 0b11_1111_1111_1111_1111_1111_1111;
    fields.__bitfield = (fields.__bitfield & ~MASK0) | (value & MASK0);
}
get_MetricsTotalSurface :: (fields: ImFontBaked) -> u32 {
    return (fields.__bitfield & 0b11_1111_1111_1111_1111_1111_1111);
}

set_WantDestroy :: (fields: *ImFontBaked, value: bool) {
    if value fields.__bitfield |= 1 << 26;
    else     fields.__bitfield &= ~cast(u32)(1 << 26);
}
get_WantDestroy :: (fields: ImFontBaked) -> bool {
    return (fields.__bitfield & (1 << 26)) != 0;
}

set_LoadNoFallback :: (fields: *ImFontBaked, value: bool) {
    if value fields.__bitfield |= 1 << 27;
    else     fields.__bitfield &= ~cast(u32)(1 << 27);
}
get_LoadNoFallback :: (fields: ImFontBaked) -> bool {
    return (fields.__bitfield & (1 << 27)) != 0;
}

set_LoadNoRenderOnLayout :: (fields: *ImFontBaked, value: bool) {
    if value fields.__bitfield |= 1 << 28;
    else     fields.__bitfield &= ~cast(u32)(1 << 28);
}
get_LoadNoRenderOnLayout :: (fields: ImFontBaked) -> bool {
    return (fields.__bitfield & (1 << 28)) != 0;
}


// Font flags
// (in future versions as we redesign font loading API, this will become more important and better documented. for now please consider this as internal/advanced use)
ImFontFlags_ :: enum u32 {
    None            :: 0;
    NoLoadError     :: 2;
    NoLoadGlyphs    :: 4;
    LockBakedSizes  :: 8;
    ImplicitRefSize :: 16;

    ImFontFlags_None            :: None;
    ImFontFlags_NoLoadError     :: NoLoadError;
    ImFontFlags_NoLoadGlyphs    :: NoLoadGlyphs;
    ImFontFlags_LockBakedSizes  :: LockBakedSizes;
    ImFontFlags_ImplicitRefSize :: ImplicitRefSize;
}

// Font runtime data and rendering
// - ImFontAtlas automatically loads a default embedded font for you if you didn't load one manually.
// - Since 1.92.0 a font may be rendered as any size! Therefore a font doesn't have one specific size.
// - Use 'font->GetFontBaked(size)' to retrieve the ImFontBaked* corresponding to a given size.
// - If you used g.Font + g.FontSize (which is frequent from the ImGui layer), you can use g.FontBaked as a shortcut, as g.FontBaked == g.Font->GetFontBaked(g.FontSize).
ImFont :: struct {
    LastBaked:                *ImFontBaked; // 4-8   // Cache last bound baked. NEVER USE DIRECTLY. Use GetFontBaked().
    OwnerAtlas:               *ImFontAtlas; // 4-8   // What we have been loaded into.
    Flags:                    ImFontFlags; // 4     // Font flags.
    CurrentRasterizerDensity: float; // Current rasterizer density. This is a varying state of the font.

    FontId:                   ImGuiID; // Unique identifier for the font
    LegacySize:               float; // 4     // in  // Font size passed to AddFont(). Use for old code calling PushFont() expecting to use that size. (use ImGui::GetFontBaked() to get font baked at current bound size).
    Sources:                  ImVector(*ImFontConfig); // 16    // in  // List of sources. Pointers within OwnerAtlas->Sources[]
    EllipsisChar:             ImWchar; // 2-4   // out // Character used for ellipsis rendering ('...'). If you ever want to temporarily swap this for an alternative/dummy char, make sure to clear EllipsisAutoBake.
    FallbackChar:             ImWchar; // 2-4   // out // Character used if a glyph isn't found (U+FFFD, '?')
    Used8kPagesMap:           [1] ImU8; // 1 bytes if ImWchar=ImWchar16, 17 bytes if ImWchar==ImWchar32. Store 1-bit for each block of 8K codepoints that has one active glyph. This is mainly used to facilitate iterations across all used codepoints.
    EllipsisAutoBake:         bool; // 1     //     // Mark when the "..." glyph (== EllipsisChar) needs to be generated by combining multiple '.'.
    RemapPairs:               ImGuiStorage; // 16    //     // Remapping pairs when using AddRemapCodepointXXX().

    Scale:                    float; // 4     // in  // Legacy base font scale (~1.0f), multiplied by the per-window font scale which you can adjust with SetWindowFontScale()

    // Methods
    Constructor :: (this: *ImFont) -> void #cpp_method #foreign libimgui "_ZN6ImFontC1Ev";
    Destructor_Base :: (this: *ImFont) -> void #cpp_method #foreign libimgui "_ZN6ImFontD2Ev";
    Destructor :: (this: *ImFont) -> void #cpp_method #foreign libimgui "_ZN6ImFontD1Ev";
    IsGlyphInFont :: (this: *ImFont, c: ImWchar) -> bool #cpp_method #foreign libimgui "_ZN6ImFont13IsGlyphInFontEt";

    // [Internal] Don't use!
    // 'max_width' stops rendering after a certain width (could be turned into a 2d size). FLT_MAX to disable.
    // 'wrap_width' enable automatic word-wrapping across multiple lines to fit into given width. 0.0f to disable.
    GetFontBaked :: (this: *ImFont, font_size: float, density: float = -1.0) -> *ImFontBaked #cpp_method #foreign libimgui "_ZN6ImFont12GetFontBakedEff";
    CalcTextSizeA :: (this: *ImFont, size: float, max_width: float, wrap_width: float, text_begin: *u8, text_end: *u8 = null, out_remaining: **u8 = null) -> ImVec2 #cpp_method #foreign libimgui "_ZN6ImFont13CalcTextSizeAEfffPKcS1_PS1_";
    CalcWordWrapPosition :: (this: *ImFont, size: float, text: *u8, text_end: *u8, wrap_width: float) -> *u8 #cpp_method #foreign libimgui "_ZN6ImFont20CalcWordWrapPositionEfPKcS1_f";
    RenderChar :: (this: *ImFont, draw_list: *ImDrawList, size: float, pos: *ImVec2, col: ImU32, c: ImWchar, cpu_fine_clip: *ImVec4 = null) -> void #cpp_method #foreign libimgui "_ZN6ImFont10RenderCharEP10ImDrawListfRK6ImVec2jtPK6ImVec4";
    RenderChar :: (this: *ImFont, draw_list: *ImDrawList, size: float, pos: ImVec2, col: ImU32, c: ImWchar, cpu_fine_clip: *ImVec4 = null) #no_context {
        RenderChar(this, draw_list, size, *pos, col, c, cpu_fine_clip);
    }
    RenderText :: (this: *ImFont, draw_list: *ImDrawList, size: float, pos: *ImVec2, col: ImU32, clip_rect: *ImVec4, text_begin: *u8, text_end: *u8, wrap_width: float = 0.0, flags: ImDrawTextFlags = 0) -> void #cpp_method #foreign libimgui "_ZN6ImFont10RenderTextEP10ImDrawListfRK6ImVec2jRK6ImVec4PKcS9_fi";
    RenderText :: (this: *ImFont, draw_list: *ImDrawList, size: float, pos: ImVec2, col: ImU32, clip_rect: ImVec4, text_begin: *u8, text_end: *u8, wrap_width: float = 0.0, flags: ImDrawTextFlags = 0) #no_context {
        RenderText(this, draw_list, size, *pos, col, *clip_rect, text_begin, text_end, wrap_width, flags);
    }

    // [Internal] Don't use!
    ClearOutputData :: (this: *ImFont) -> void #cpp_method #foreign libimgui "_ZN6ImFont15ClearOutputDataEv";
    AddRemapCodepoint :: (this: *ImFont, from_codepoint: ImWchar, to_codepoint: ImWchar) -> void #cpp_method #foreign libimgui "_ZN6ImFont17AddRemapCodepointEtt";
    AddRemapCodepointToGlyphIndex :: (this: *ImFont, from_codepoint: ImWchar, font_src_idx: s32, glyph_idx: s32) -> void #cpp_method #foreign libimgui "_ZN6ImFont29AddRemapCodepointToGlyphIndexEtii";
    IsGlyphRangeUnused :: (this: *ImFont, c_begin: u32, c_last: u32) -> bool #cpp_method #foreign libimgui "_ZN6ImFont18IsGlyphRangeUnusedEjj";
}

// Flags stored in ImGuiViewport::Flags, giving indications to the platform backends.
ImGuiViewportFlags_ :: enum u32 {
    None              :: 0;
    IsPlatformWindow  :: 1;
    IsPlatformMonitor :: 2;
    OwnedByApp        :: 4;

    ImGuiViewportFlags_None              :: None;
    ImGuiViewportFlags_IsPlatformWindow  :: IsPlatformWindow;
    ImGuiViewportFlags_IsPlatformMonitor :: IsPlatformMonitor;
    ImGuiViewportFlags_OwnedByApp        :: OwnedByApp;
}

// - Currently represents the Platform Window created by the application which is hosting our Dear ImGui windows.
// - In 'docking' branch with multi-viewport enabled, we extend this concept to have multiple active viewports.
// - In the future we will extend this concept further to also represent Platform Monitor and support a "no main platform window" operation mode.
// - About Main Area vs Work Area:
//   - Main Area = entire viewport.
//   - Work Area = entire viewport minus sections used by main menu bars (for platform windows), or by task bar (for platform monitor).
//   - Windows are generally trying to stay within the Work Area of their host viewport.
ImGuiViewport :: struct {
    ID:                ImGuiID; // Unique identifier for the viewport
    Flags:             ImGuiViewportFlags; // See ImGuiViewportFlags_
    Pos:               ImVec2; // Main Area: Position of the viewport (Dear ImGui coordinates are the same as OS desktop/native coordinates)
    Size:              ImVec2; // Main Area: Size of the viewport.
    FramebufferScale:  ImVec2; // Density of the viewport for Retina display (always 1,1 on Windows, may be 2,2 etc on macOS/iOS). This will affect font rasterizer density.
    WorkPos:           ImVec2; // Work Area: Position of the viewport minus task bars, menus bars, status bars (>= Pos)
    WorkSize:          ImVec2; // Work Area: Size of the viewport minus task bars, menu bars, status bars (<= Size)

    PlatformHandle:    *void; // void* to hold higher-level, platform window handle (e.g. HWND, GLFWWindow*, SDL_Window*)
    PlatformHandleRaw: *void; // void* to hold lower-level, platform-native window handle (under Win32 this is expected to be a HWND, unused for other platforms)
}

// Access via ImGui::GetPlatformIO()
ImGuiPlatformIO :: struct {
    Constructor :: (this: *ImGuiPlatformIO) -> void #cpp_method #foreign libimgui "_ZN15ImGuiPlatformIOC1Ev";

    Platform_GetClipboardTextFn:    #type (ctx: *ImGuiContext) -> *u8 #c_call; // Should return NULL on failure (e.g. clipboard data is not text).
    Platform_SetClipboardTextFn:    #type (ctx: *ImGuiContext, text: *u8) -> void #c_call;
    Platform_ClipboardUserData:     *void;

    // Optional: Open link/folder/file in OS Shell
    // (default to use ShellExecuteW() on Windows, system() on Linux/Mac. expected to return false on failure, but some platforms may always return true)
    Platform_OpenInShellFn:         #type (ctx: *ImGuiContext, path: *u8) -> bool #c_call;
    Platform_OpenInShellUserData:   *void;

    // Optional: Notify OS Input Method Editor of the screen position of your cursor for text input position (e.g. when using Japanese/Chinese IME on Windows)
    // (default to use native imm32 api on Windows)
    Platform_SetImeDataFn:          #type (ctx: *ImGuiContext, viewport: *ImGuiViewport, data: *ImGuiPlatformImeData) -> void #c_call;
    Platform_ImeUserData:           *void;

    Platform_LocaleDecimalPoint:    ImWchar; // '.'

    Platform_SessionDate:           s32; // Integer storing YYYYMMDD e.g. 20261231 corresponding to the beginning of application session.

    // Optional: Maximum texture size supported by renderer (used to adjust how we size textures). 0 if not known.
    Renderer_TextureMaxWidth:       s32;
    Renderer_TextureMaxHeight:      s32;

    // Written by some backends during ImGui_ImplXXXX_RenderDrawData() call to point backend_specific ImGui_ImplXXXX_RenderState* structure.
    Renderer_RenderState:           *void;

    DrawCallback_ResetRenderState:  ImDrawCallback; // Request to reset the graphics/render state.
    DrawCallback_SetSamplerLinear:  ImDrawCallback; // Request backend to set texture sampling to Linear.
    DrawCallback_SetSamplerNearest: ImDrawCallback; // Request backend to set texture sampling to Nearest/Point.
    DrawCallback_SetSamplerFromTex: ImDrawCallback; // Request backend to use sampler associated to texture - only available in some backends: OpenGL2/3 and SDLRenderer3.

    Textures:                       ImVector(*ImTextureData); // List of textures used by Dear ImGui (most often 1) + contents of external texture list is automatically appended into this.

    //------------------------------------------------------------------
    // Functions
    //------------------------------------------------------------------
    ClearPlatformHandlers :: (this: *ImGuiPlatformIO) -> void #cpp_method #foreign libimgui "_ZN15ImGuiPlatformIO21ClearPlatformHandlersEv";
    ClearRendererHandlers :: (this: *ImGuiPlatformIO) -> void #cpp_method #foreign libimgui "_ZN15ImGuiPlatformIO21ClearRendererHandlersEv";
}

// (Optional) Support for IME (Input Method Editor) via the platform_io.Platform_SetImeDataFn() function. Handler is called during EndFrame().
ImGuiPlatformImeData :: struct {
    WantVisible:     bool; // A widget wants the IME to be visible.
    WantTextInput:   bool; // A widget wants text input, not necessarily IME to be visible. This is automatically set to the upcoming value of io.WantTextInput.
    InputPos:        ImVec2; // Position of input cursor (for IME).
    InputLineHeight: float; // Line height (for IME).
    ViewportId:      ImGuiID; // ID of platform window/viewport.
}

// -- RENAMED in 1.93.0: Merged ImDrawListFlags into ImDrawFlags.
ImDrawListFlags :: ImDrawFlags;
ImDrawListFlags_ :: enum u32 {
    None                   :: 0;
    AntiAliasedFill        :: 4096;
    AntiAliasedLines       :: 8192;
    AntiAliasedLinesUseTex :: 8192;
    AllowVtxOffset         :: 4194304;
    TextNoPixelSnap        :: 1048576;

    ImDrawListFlags_None                   :: None;
    ImDrawListFlags_AntiAliasedFill        :: AntiAliasedFill;
    ImDrawListFlags_AntiAliasedLines       :: AntiAliasedLines;
    ImDrawListFlags_AntiAliasedLinesUseTex :: AntiAliasedLinesUseTex;
    ImDrawListFlags_AllowVtxOffset         :: AllowVtxOffset;
    ImDrawListFlags_TextNoPixelSnap        :: TextNoPixelSnap;
}

//-- OBSOLETED in 1.92.0: ImFontAtlasCustomRect becomes ImTextureRect
// - ImFontAtlasCustomRect::X,Y          --> ImTextureRect::x,y
// - ImFontAtlasCustomRect::Width,Height --> ImTextureRect::w,h
// - ImFontAtlasCustomRect::GlyphColored --> if you need to write to this, instead you can write to 'font->Glyphs.back()->Colored' after calling AddCustomRectFontGlyph()
// We could make ImTextureRect an union to use old names, but 1) this would be confusing 2) the fix is easy 3) ImFontAtlasCustomRect was always a rather esoteric api.
ImFontAtlasCustomRect :: ImFontAtlasRect;

#scope_file

#import "Basic"; // For print_to_builder

