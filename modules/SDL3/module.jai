Window_Id       :: #type u32;
Touch_Id        :: #type u64;
Sensor_Id       :: #type u32;
Pen_Id          :: #type u32;
Notification_Id :: #type u32;
Mouse_Id        :: #type u32;
Keyboard_Id     :: #type u32;
Joystick_Id     :: #type u32;
Finger_Id       :: #type u64;
Display_Id      :: #type u32;
Camera_Id       :: #type u32;
Audio_Device_Id :: #type u32;

Keymod :: #type u16;
Keycode :: #type u32;

Window :: struct {};

Window_Flags :: enum_flags u64 {
    VULKAN    :: 0x0000000010000000;
    RESIZABLE :: 0x0000000000000020;
}

Init_Flags :: enum_flags u64 {
    AUDIO    :: 0x00000010;
    VIDEO    :: 0x00000020;
    JOYSTICK :: 0x00000200;
    HAPTIC   :: 0x00001000;
    GAMEPAD  :: 0x00002000;
    EVENTS   :: 0x00004000;
    SENSOR   :: 0x00008000;
    CAMERA   :: 0x00010000;
}

Pen_Input_Flags :: enum_flags u32 {}

Mouse_Button_Flags :: enum_flags u32 {};

Pen_Axis :: enum u32 {
    PRESSURE            :: 0;
    XTILT               :: 1;
    YTILT               :: 2;
    DISTANCE            :: 3;
    ROTATION            :: 4;
    SLIDER              :: 5;
    TANGENTIAL_PRESSURE :: 6;
    COUNT               :: 7;
}

Mouse_Wheel_Direction :: enum u32 {
    NORMAL  :: 0;
    FLIPPED :: 1;
}

Scancode :: enum u32 {
    UNKNOWN :: 0;

    A :: 4;
    B :: 5;
    C :: 6;
    D :: 7;
    E :: 8;
    F :: 9;
    G :: 10;
    H :: 11;
    I :: 12;
    J :: 13;
    K :: 14;
    L :: 15;
    M :: 16;
    N :: 17;
    O :: 18;
    P :: 19;
    Q :: 20;
    R :: 21;
    S :: 22;
    T :: 23;
    U :: 24;
    V :: 25;
    W :: 26;
    X :: 27;
    Y :: 28;
    Z :: 29;

    _1 :: 30;
    _2 :: 31;
    _3 :: 32;
    _4 :: 33;
    _5 :: 34;
    _6 :: 35;
    _7 :: 36;
    _8 :: 37;
    _9 :: 38;
    _0 :: 39;

    RETURN    :: 40;
    ESCAPE    :: 41;
    BACKSPACE :: 42;
    TAB       :: 43;
    SPACE     :: 44;

    MINUS        :: 45;
    EQUALS       :: 46;
    LEFTBRACKET  :: 47;
    RIGHTBRACKET :: 48;
    BACKSLASH    :: 49;

    NONUSHASH :: 50;

    SEMICOLON  :: 51;
    APOSTROPHE :: 52;
    GRAVE      :: 53;

    COMMA  :: 54;
    PERIOD :: 55;
    SLASH  :: 56;

    CAPSLOCK :: 57;

    F1  :: 58;
    F2  :: 59;
    F3  :: 60;
    F4  :: 61;
    F5  :: 62;
    F6  :: 63;
    F7  :: 64;
    F8  :: 65;
    F9  :: 66;
    F10 :: 67;
    F11 :: 68;
    F12 :: 69;

    PRINTSCREEN :: 70;
    SCROLLLOCK  :: 71;
    PAUSE       :: 72;
    INSERT      :: 73;

    HOME     :: 74;
    PAGEUP   :: 75;
    DELETE   :: 76;
    END      :: 77;
    PAGEDOWN :: 78;
    RIGHT    :: 79;
    LEFT     :: 80;
    DOWN     :: 81;
    UP       :: 82;

    NUMLOCKCLEAR :: 83;

    KP_DIVIDE   :: 84;
    KP_MULTIPLY :: 85;
    KP_MINUS    :: 86;
    KP_PLUS     :: 87;
    KP_ENTER    :: 88;
    KP_1        :: 89;
    KP_2        :: 90;
    KP_3        :: 91;
    KP_4        :: 92;
    KP_5        :: 93;
    KP_6        :: 94;
    KP_7        :: 95;
    KP_8        :: 96;
    KP_9        :: 97;
    KP_0        :: 98;
    KP_PERIOD   :: 99;

    NONUSBACKSLASH :: 100;

    APPLICATION :: 101;
    POWER       :: 102;

    KP_EQUALS  :: 103;
    F13        :: 104;
    F14        :: 105;
    F15        :: 106;
    F16        :: 107;
    F17        :: 108;
    F18        :: 109;
    F19        :: 110;
    F20        :: 111;
    F21        :: 112;
    F22        :: 113;
    F23        :: 114;
    F24        :: 115;
    EXECUTE    :: 116;
    HELP       :: 117;
    MENU       :: 118;
    SELECT     :: 119;
    STOP       :: 120;
    AGAIN      :: 121;
    UNDO       :: 122;
    CUT        :: 123;
    COPY       :: 124;
    PASTE      :: 125;
    FIND       :: 126;
    MUTE       :: 127;
    VOLUMEUP   :: 128;
    VOLUMEDOWN :: 129;

    KP_COMMA       :: 133;
    KP_EQUALSAS400 :: 134;

    INTERNATIONAL1 :: 135;

    INTERNATIONAL2 :: 136;
    INTERNATIONAL3 :: 137;
    INTERNATIONAL4 :: 138;
    INTERNATIONAL5 :: 139;
    INTERNATIONAL6 :: 140;
    INTERNATIONAL7 :: 141;
    INTERNATIONAL8 :: 142;
    INTERNATIONAL9 :: 143;
    LANG1          :: 144;
    LANG2          :: 145;
    LANG3          :: 146;
    LANG4          :: 147;
    LANG5          :: 148;
    LANG6          :: 149;
    LANG7          :: 150;
    LANG8          :: 151;
    LANG9          :: 152;

    ALTERASE   :: 153;
    SYSREQ     :: 154;
    CANCEL     :: 155;
    CLEAR      :: 156;
    PRIOR      :: 157;
    RETURN2    :: 158;
    SEPARATOR  :: 159;
    OUT        :: 160;
    OPER       :: 161;
    CLEARAGAIN :: 162;
    CRSEL      :: 163;
    EXSEL      :: 164;

    KP_00              :: 176;
    KP_000             :: 177;
    THOUSANDSSEPARATOR :: 178;
    DECIMALSEPARATOR   :: 179;
    CURRENCYUNIT       :: 180;
    CURRENCYSUBUNIT    :: 181;
    KP_LEFTPAREN       :: 182;
    KP_RIGHTPAREN      :: 183;
    KP_LEFTBRACE       :: 184;
    KP_RIGHTBRACE      :: 185;
    KP_TAB             :: 186;
    KP_BACKSPACE       :: 187;
    KP_A               :: 188;
    KP_B               :: 189;
    KP_C               :: 190;
    KP_D               :: 191;
    KP_E               :: 192;
    KP_F               :: 193;
    KP_XOR             :: 194;
    KP_POWER           :: 195;
    KP_PERCENT         :: 196;
    KP_LESS            :: 197;
    KP_GREATER         :: 198;
    KP_AMPERSAND       :: 199;
    KP_DBLAMPERSAND    :: 200;
    KP_VERTICALBAR     :: 201;
    KP_DBLVERTICALBAR  :: 202;
    KP_COLON           :: 203;
    KP_HASH            :: 204;
    KP_SPACE           :: 205;
    KP_AT              :: 206;
    KP_EXCLAM          :: 207;
    KP_MEMSTORE        :: 208;
    KP_MEMRECALL       :: 209;
    KP_MEMCLEAR        :: 210;
    KP_MEMADD          :: 211;
    KP_MEMSUBTRACT     :: 212;
    KP_MEMMULTIPLY     :: 213;
    KP_MEMDIVIDE       :: 214;
    KP_PLUSMINUS       :: 215;
    KP_CLEAR           :: 216;
    KP_CLEARENTRY      :: 217;
    KP_BINARY          :: 218;
    KP_OCTAL           :: 219;
    KP_DECIMAL         :: 220;
    KP_HEXADECIMAL     :: 221;

    LCTRL  :: 224;
    LSHIFT :: 225;
    LALT   :: 226;
    LGUI   :: 227;
    RCTRL  :: 228;
    RSHIFT :: 229;
    RALT   :: 230;
    RGUI   :: 231;

    MODE :: 257;

    SLEEP :: 258;
    WAKE  :: 259;

    CHANNEL_INCREMENT :: 260;
    CHANNEL_DECREMENT :: 261;

    MEDIA_PLAY           :: 262;
    MEDIA_PAUSE          :: 263;
    MEDIA_RECORD         :: 264;
    MEDIA_FAST_FORWARD   :: 265;
    MEDIA_REWIND         :: 266;
    MEDIA_NEXT_TRACK     :: 267;
    MEDIA_PREVIOUS_TRACK :: 268;
    MEDIA_STOP           :: 269;
    MEDIA_EJECT          :: 270;
    MEDIA_PLAY_PAUSE     :: 271;
    MEDIA_SELECT         :: 272;

    AC_NEW        :: 273;
    AC_OPEN       :: 274;
    AC_CLOSE      :: 275;
    AC_EXIT       :: 276;
    AC_SAVE       :: 277;
    AC_PRINT      :: 278;
    AC_PROPERTIES :: 279;

    AC_SEARCH    :: 280;
    AC_HOME      :: 281;
    AC_BACK      :: 282;
    AC_FORWARD   :: 283;
    AC_STOP      :: 284;
    AC_REFRESH   :: 285;
    AC_BOOKMARKS :: 286;

    SOFTLEFT :: 287;
    SOFTRIGHT :: 288;

    CALL    :: 289;
    ENDCALL :: 290;

    RESERVED :: 400;

    COUNT :: 512;
}

Power_State :: enum s32 {
    ERROR      :: -1;
    UNKNOWN    :: 0;
    ON_BATTERY :: 1;
    NO_BATTERY :: 2;
    CHARGING   :: 3;
    CHARGED    :: 4;
}

Event_Type :: enum u32 {
    FIRST                 :: 0;
    QUIT                  :: 256;
    TERMINATING           :: 257;
    LOW_MEMORY            :: 258;
    WILL_ENTER_BACKGROUND :: 259;
    DID_ENTER_BACKGROUND  :: 260;
    WILL_ENTER_FOREGROUND :: 261;
    DID_ENTER_FOREGROUND  :: 262;
    LOCALE_CHANGED        :: 263;
    SYSTEM_THEME_CHANGED  :: 264;

    DISPLAY_ORIENTATION           :: 337;
    DISPLAY_ADDED                 :: 338;
    DISPLAY_REMOVED               :: 339;
    DISPLAY_MOVED                 :: 340;
    DISPLAY_DESKTOP_MODE_CHANGED  :: 341;
    DISPLAY_CURRENT_MODE_CHANGED  :: 342;
    DISPLAY_CONTENT_SCALE_CHANGED :: 343;
    DISPLAY_USABLE_BOUNDS_CHANGED :: 344;
    DISPLAY_FIRST                 :: 337;
    DISPLAY_LAST                  :: 344;

    WINDOW_SHOWN                 :: 514;
    WINDOW_HIDDEN                :: 515;
    WINDOW_EXPOSED               :: 516;
    WINDOW_MOVED                 :: 517;
    WINDOW_RESIZED               :: 518;
    WINDOW_PIXEL_SIZE_CHANGED    :: 519;
    WINDOW_METAL_VIEW_RESIZED    :: 520;
    WINDOW_MINIMIZED             :: 521;
    WINDOW_MAXIMIZED             :: 522;
    WINDOW_RESTORED              :: 523;
    WINDOW_MOUSE_ENTER           :: 524;
    WINDOW_MOUSE_LEAVE           :: 525;
    WINDOW_FOCUS_GAINED          :: 526;
    WINDOW_FOCUS_LOST            :: 527;
    WINDOW_CLOSE_REQUESTED       :: 528;
    WINDOW_HIT_TEST              :: 529;
    WINDOW_ICCPROF_CHANGED       :: 530;
    WINDOW_DISPLAY_CHANGED       :: 531;
    WINDOW_DISPLAY_SCALE_CHANGED :: 532;
    WINDOW_SAFE_AREA_CHANGED     :: 533;
    WINDOW_OCCLUDED              :: 534;
    WINDOW_ENTER_FULLSCREEN      :: 535;
    WINDOW_LEAVE_FULLSCREEN      :: 536;
    WINDOW_DESTROYED             :: 537;

    WINDOW_HDR_STATE_CHANGED :: 538;
    WINDOW_SETTINGS_CHANGED  :: 539;
    WINDOW_FIRST             :: 514;
    WINDOW_LAST              :: 539;

    KEY_DOWN       :: 768;
    KEY_UP         :: 769;
    TEXT_EDITING   :: 770;
    TEXT_INPUT     :: 771;
    KEYMAP_CHANGED :: 772;

    KEYBOARD_ADDED          :: 773;
    KEYBOARD_REMOVED        :: 774;
    TEXT_EDITING_CANDIDATES :: 775;
    SCREEN_KEYBOARD_SHOWN   :: 776;
    SCREEN_KEYBOARD_HIDDEN  :: 777;
    KEYBOARD_FIRST          :: 768;
    KEYBOARD_LAST           :: 777;

    MOUSE_MOTION      :: 1024;
    MOUSE_BUTTON_DOWN :: 1025;
    MOUSE_BUTTON_UP   :: 1026;
    MOUSE_WHEEL       :: 1027;
    MOUSE_ADDED       :: 1028;
    MOUSE_REMOVED     :: 1029;
    MOUSE_FIRST       :: 1024;
    MOUSE_LAST        :: 1029;

    JOYSTICK_AXIS_MOTION     :: 1536;
    JOYSTICK_BALL_MOTION     :: 1537;
    JOYSTICK_HAT_MOTION      :: 1538;
    JOYSTICK_BUTTON_DOWN     :: 1539;
    JOYSTICK_BUTTON_UP       :: 1540;
    JOYSTICK_ADDED           :: 1541;
    JOYSTICK_REMOVED         :: 1542;
    JOYSTICK_BATTERY_UPDATED :: 1543;
    JOYSTICK_UPDATE_COMPLETE :: 1544;
    JOYSTICK_FIRST           :: 1536;
    JOYSTICK_LAST            :: 1544;

    GAMEPAD_AXIS_MOTION          :: 1616;
    GAMEPAD_BUTTON_DOWN          :: 1617;
    GAMEPAD_BUTTON_UP            :: 1618;
    GAMEPAD_ADDED                :: 1619;
    GAMEPAD_REMOVED              :: 1620;
    GAMEPAD_REMAPPED             :: 1621;
    GAMEPAD_TOUCHPAD_DOWN        :: 1622;
    GAMEPAD_TOUCHPAD_MOTION      :: 1623;
    GAMEPAD_TOUCHPAD_UP          :: 1624;
    GAMEPAD_SENSOR_UPDATE        :: 1625;
    GAMEPAD_UPDATE_COMPLETE      :: 1626;
    GAMEPAD_STEAM_HANDLE_UPDATED :: 1627;
    GAMEPAD_CAPSENSE_TOUCH       :: 1628;
    GAMEPAD_CAPSENSE_RELEASE     :: 1629;
    GAMEPAD_FIRST                :: 1616;
    GAMEPAD_LAST                 :: 1629;

    FINGER_DOWN     :: 1792;
    FINGER_UP       :: 1793;
    FINGER_MOTION   :: 1794;
    FINGER_CANCELED :: 1795;
    FINGER_FIRST    :: 1792;
    FINGER_LAST     :: 1795;

    PINCH_BEGIN  :: 1808;
    PINCH_UPDATE :: 1809;
    PINCH_END    :: 1810;
    PINCH_FIRST  :: 1808;
    PINCH_LAST   :: 1810;

    CLIPBOARD_UPDATE :: 2304;
    CLIPBOARD_FIRST  :: 2304;
    CLIPBOARD_LAST   :: 2304;

    DROP_FILE     :: 4096;
    DROP_TEXT     :: 4097;
    DROP_BEGIN    :: 4098;
    DROP_COMPLETE :: 4099;
    DROP_POSITION :: 4100;
    DROP_FIRST    :: 4096;
    DROP_LAST     :: 4100;

    AUDIO_DEVICE_ADDED          :: 4352;
    AUDIO_DEVICE_REMOVED        :: 4353;
    AUDIO_DEVICE_FORMAT_CHANGED :: 4354;
    AUDIO_DEVICE_FIRST          :: 4352;
    AUDIO_DEVICE_LAST           :: 4354;

    SENSOR_UPDATE :: 4608;
    SENSOR_FIRST  :: 4608;
    SENSOR_LAST   :: 4608;

    PEN_PROXIMITY_IN  :: 4864;
    PEN_PROXIMITY_OUT :: 4865;
    PEN_DOWN          :: 4866;
    PEN_UP            :: 4867;
    PEN_BUTTON_DOWN   :: 4868;
    PEN_BUTTON_UP     :: 4869;
    PEN_MOTION        :: 4870;
    PEN_AXIS          :: 4871;
    PEN_FIRST         :: 4864;
    PEN_LAST          :: 4871;

    CAMERA_DEVICE_ADDED    :: 5120;
    CAMERA_DEVICE_REMOVED  :: 5121;
    CAMERA_DEVICE_APPROVED :: 5122;
    CAMERA_DEVICE_DENIED   :: 5123;
    CAMERA_DEVICE_FIRST    :: 5120;
    CAMERA_DEVICE_LAST     :: 5123;

    NOTIFICATION_ACTION_INVOKED :: 5376;
    NOTIFICATION_FIRST          :: 5376;
    NOTIFICATION_LAST           :: 5376;

    RENDER_TARGETS_RESET :: 8192;
    RENDER_DEVICE_RESET  :: 8193;
    RENDER_DEVICE_LOST   :: 8194;
    RENDER_FIRST         :: 8192;
    RENDER_LAST          :: 8194;

    PRIVATE0 :: 16384;
    PRIVATE1 :: 16385;
    PRIVATE2 :: 16386;
    PRIVATE3 :: 16387;

    POLL_SENTINEL :: 32512;

    USER :: 32768;

    LAST :: 65535;

    ENUM_PADDING :: 2147483647;
}

Event :: struct {
    padding: [128] u8;

    #overlay (padding) type:            Event_Type;
    #overlay (padding) common:          Common_Event;
    #overlay (padding) display:         Display_Event;
    #overlay (padding) window:          Window_Event;
    #overlay (padding) kdevice:         Keyboard_Device_Event;
    #overlay (padding) key:             Keyboard_Event;
    #overlay (padding) edit:            Text_Editing_Event;
    #overlay (padding) edit_candidates: Text_Editing_Candidates_Event;
    #overlay (padding) text:            Text_Input_Event;
    #overlay (padding) mdevice:         Mouse_Device_Event;
    #overlay (padding) motion:          Mouse_Motion_Event;
    #overlay (padding) button:          Mouse_Button_Event;
    #overlay (padding) wheel:           Mouse_Wheel_Event;
    #overlay (padding) jdevice:         Joy_Device_Event;
    #overlay (padding) jaxis:           Joy_Axis_Event;
    #overlay (padding) jball:           Joy_Ball_Event;
    #overlay (padding) jhat:            Joy_Hat_Event;
    #overlay (padding) jbutton:         Joy_Button_Event;
    #overlay (padding) jbattery:        Joy_Battery_Event;
    #overlay (padding) gdevice:         Gamepad_Device_Event;
    #overlay (padding) gaxis:           Gamepad_Axis_Event;
    #overlay (padding) gbutton:         Gamepad_Button_Event;
    #overlay (padding) gtouchpad:       Gamepad_Touchpad_Event;
    #overlay (padding) gsensor:         Gamepad_Sensor_Event;
    #overlay (padding) gcapsense:       Gamepad_Cap_Sense_Event;
    #overlay (padding) adevice:         Audio_Device_Event;
    #overlay (padding) cdevice:         Camera_Device_Event;
    #overlay (padding) sensor:          Sensor_Event;
    #overlay (padding) quit:            Quit_Event;
    #overlay (padding) user:            User_Event;
    #overlay (padding) tfinger:         Touch_Finger_Event;
    #overlay (padding) pinch:           Pinch_Finger_Event;
    #overlay (padding) pproximity:      Pen_Proximity_Event;
    #overlay (padding) ptouch:          Pen_Touch_Event;
    #overlay (padding) pmotion:         Pen_Motion_Event;
    #overlay (padding) pbutton:         Pen_Button_Event;
    #overlay (padding) paxis:           Pen_Axis_Event;
    #overlay (padding) render:          Render_Event;
    #overlay (padding) drop:            Drop_Event;
    #overlay (padding) clipboard:       Clipboard_Event;
    #overlay (padding) notification:    Notification_Event;
}

Window_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    data1:     s32;
    data2:     s32;
}

User_Event :: struct {
    type:      u32;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    code:      s32;
    data1:     *void;
    data2:     *void;
}

Touch_Finger_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    touchID:   Touch_Id;
    fingerID:  Finger_Id;
    x:         float;
    y:         float;
    dx:        float;
    dy:        float;
    pressure:  float;
    windowID:  Window_Id;
}

Text_Input_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    text:      *u8;
}

Text_Editing_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    text:      *u8;
    start:     s32;
    length:    s32;
}

Text_Editing_Candidates_Event :: struct {
    type:               Event_Type;
    reserved:           u32;
    timestamp:          u64;
    windowID:           Window_Id;
    candidates:         **u8;
    num_candidates:     s32;
    selected_candidate: s32;
    horizontal:         bool;
    padding1:           u8;
    padding2:           u8;
    padding3:           u8;
}

Sensor_Event :: struct {
    type:             Event_Type;
    reserved:         u32;
    timestamp:        u64;
    which:            Sensor_Id;
    data:             [6]float;
    sensor_timestamp: u64;
}

Render_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
}

Quit_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
}

Pinch_Finger_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    scale:     float;
    windowID:  Window_Id;
    span_x:    float;
    span_y:    float;
    focus_x:   float;
    focus_y:   float;
}

Pen_Touch_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Pen_Id;
    pen_state: Pen_Input_Flags;
    x:         float;
    y:         float;
    eraser:    bool;
    down:      bool;
}

Pen_Proximity_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Pen_Id;
    pen_state: Pen_Input_Flags;
}

Pen_Motion_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Pen_Id;
    pen_state: Pen_Input_Flags;
    x:         float;
    y:         float;
}

Pen_Button_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Pen_Id;
    pen_state: Pen_Input_Flags;
    x:         float;
    y:         float;
    button:    u8;
    down:      bool;
}

Pen_Axis_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Pen_Id;
    pen_state: Pen_Input_Flags;
    x:         float;
    y:         float;
    axis:      Pen_Axis;
    value:     float;
}

Notification_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Notification_Id;
    action_id: *u8;
}

Mouse_Wheel_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Mouse_Id;
    x:         float;
    y:         float;
    direction: Mouse_Wheel_Direction;
    mouse_x:   float;
    mouse_y:   float;
    integer_x: s32;
    integer_y: s32;
}

Mouse_Motion_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Mouse_Id;
    state:     Mouse_Button_Flags;
    x:         float;
    y:         float;
    xrel:      float;
    yrel:      float;
}

Mouse_Device_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Mouse_Id;
}

Mouse_Button_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Mouse_Id;
    button:    u8;
    down:      bool;
    clicks:    u8;
    padding:   u8;
    x:         float;
    y:         float;
}

Keyboard_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    which:     Keyboard_Id;
    scancode:  Scancode;
    key:       Keycode;
    mod:       Keymod;
    raw:       u16;
    down:      bool;
    repeat:    bool;
}

Keyboard_Device_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Keyboard_Id;
}

Joy_Hat_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    hat:       u8;
    value:     u8;
    padding1:  u8;
    padding2:  u8;
}

Joy_Device_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
}

Joy_Button_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    button:    u8;
    down:      bool;
    padding1:  u8;
    padding2:  u8;
}

Joy_Battery_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    state:     Power_State;
    percent:   s32;
}

Joy_Ball_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    ball:      u8;
    padding1:  u8;
    padding2:  u8;
    padding3:  u8;
    xrel:      s16;
    yrel:      s16;
}

Joy_Axis_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    axis:      u8;
    padding1:  u8;
    padding2:  u8;
    padding3:  u8;
    value:     s16;
    padding4:  u16;
}

Gamepad_Touchpad_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    touchpad:  s32;
    finger:    s32;
    x:         float;
    y:         float;
    pressure:  float;
}

Gamepad_Sensor_Event :: struct {
    type:             Event_Type;
    reserved:         u32;
    timestamp:        u64;
    which:            Joystick_Id;
    sensor:           s32;
    data:             [3]float;
    sensor_timestamp: u64;
}

Gamepad_Device_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
}

Gamepad_Cap_Sense_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    capsense:  u8;
    down:      bool;
    padding1:  u8;
    padding2:  u8;
}

Gamepad_Button_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    button:    u8;
    down:      bool;
    padding1:  u8;
    padding2:  u8;
}

Gamepad_Axis_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Joystick_Id;
    axis:      u8;
    padding1:  u8;
    padding2:  u8;
    padding3:  u8;
    value:     s16;
    padding4:  u16;
}

Drop_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    windowID:  Window_Id;
    x:         float;
    y:         float;
    source:    *u8;
    data:      *u8;
}

Display_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    displayID: Display_Id;
    data1:     s32;
    data2:     s32;
}

Common_Event :: struct {
    type:      u32;
    reserved:  u32;
    timestamp: u64;
}

Clipboard_Event :: struct {
    type:           Event_Type;
    reserved:       u32;
    timestamp:      u64;
    owner:          bool;
    num_mime_types: s32;
    mime_types:     **u8;
}

Camera_Device_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Camera_Id;
}

Audio_Device_Event :: struct {
    type:      Event_Type;
    reserved:  u32;
    timestamp: u64;
    which:     Audio_Device_Id;
    recording: bool;
    padding1:  u8;
    padding2:  u8;
    padding3:  u8;
}

init_subsystem :: (flags: Init_Flags) -> bool #foreign libsdl3 "SDL_InitSubSystem";
poll_event :: (event: *Event) -> bool #foreign libsdl3 "SDL_PollEvent";
create_window :: (title: *u8, w: s32, h: s32, flags: Window_Flags) -> *Window #foreign libsdl3 "SDL_CreateWindow";
destroy_window :: (window: *Window) -> void #foreign libsdl3 "SDL_DestroyWindow";
quit :: () -> void #foreign libsdl3 "SDL_Quit";
get_keyboard_state :: (numkeys: *s32) -> *bool #foreign libsdl3 "SDL_GetKeyboardState";

get_window_size_in_pixels :: (window: *Window) -> width: s32, height: s32 {
    w, h: s32;
    ok := SDL_GetWindowSizeInPixels(window, *w, *h);

    return w, h;
}

vulkan_get_instance_extensions :: (count: *u32) -> **u8 #foreign libsdl3 "SDL_Vulkan_GetInstanceExtensions";

vulkan_create_surface :: (
    window: *Window,
    instance: VK.Instance,
    allocator: *VK.Allocation_Callbacks = null,
) -> ok: bool, VK.Surface_Khr {
    surface: VK.Surface_Khr;

    ok := SDL_Vulkan_CreateSurface(window, instance, allocator, *surface);

    return ok, surface;
}

#scope_file

SDL_Vulkan_CreateSurface :: (window: *Window, instance: VK.Instance, allocator: *void, surface: *VK.Surface_Khr) -> bool #foreign libsdl3;
SDL_GetWindowSizeInPixels :: (window: *Window, w: *s32, h: *s32) -> bool #foreign libsdl3;

#if OS == {
    case .LINUX;
        libsdl3 :: #library "./LINUX/lib/libSDL3";
    case;
        #assert "Unsupported OS";
}

VK :: #import "Jai_Vulkan";
