zmo :: struct {
    // call inside your own window and before Manipulate() in order to draw gizmo to that window.
    // Or pass a specific ImDrawList to draw to (e.g. ImGui::GetForegroundDrawList()).
    set_drawlist :: (drawlist: *Draw_List = null) -> void #foreign libimgui "?SetDrawlist@ImGuizmo@@YAXPEAUImDrawList@@@Z";

    // call BeginFrame right after ImGui_XXXX_NewFrame();
    begin_frame :: () -> void #foreign libimgui "?BeginFrame@ImGuizmo@@YAXXZ";

    // this is necessary because when imguizmo is compiled into a dll, and imgui into another
    // globals are not shared between them.
    // More details at https://stackoverflow.com/questions/19373061/what-happens-to-global-and-static-variables-in-a-shared-library-when-it-is-dynam
    // expose method to set imgui context
    set_im_gui_context :: (ctx: *ImGuiContext) -> void #foreign libimgui "?SetImGuiContext@ImGuizmo@@YAXPEAUImGuiContext@@@Z";

    // return true if mouse cursor is over any gizmo control (axis, plan or screen component)
    is_over :: () -> bool #foreign libimgui "?IsOver@ImGuizmo@@YA_NXZ";

    // return true if mouse IsOver or if the gizmo is in moving state
    is_using :: () -> bool #foreign libimgui "?IsUsing@ImGuizmo@@YA_NXZ";

    // return true if the view gizmo is in moving state
    is_using_view_manipulate :: () -> bool #foreign libimgui "?IsUsingViewManipulate@ImGuizmo@@YA_NXZ";

    // only check if your mouse is over the view manipulator - no matter whether it's active or not
    is_view_manipulate_hovered :: () -> bool #foreign libimgui "?IsViewManipulateHovered@ImGuizmo@@YA_NXZ";

    // return true if any gizmo is in moving state
    is_using_any :: () -> bool #foreign libimgui "?IsUsingAny@ImGuizmo@@YA_NXZ";

    // enable/disable the gizmo. Stay in the state until next call to Enable.
    // gizmo is rendered with gray half transparent color when disabled
    enable :: (enable: bool) -> void #foreign libimgui "?Enable@ImGuizmo@@YAX_N@Z";

    // helper functions for manualy editing translation/rotation/scale with an input float
    // translation, rotation and scale float points to 3 floats each
    // Angles are in degrees (more suitable for human editing)
    // example:
    // float matrixTranslation[3], matrixRotation[3], matrixScale[3];
    // ImGuizmo::DecomposeMatrixToComponents(gizmoMatrix.m16, matrixTranslation, matrixRotation, matrixScale);
    // ImGui::InputFloat3("Tr", matrixTranslation, 3);
    // ImGui::InputFloat3("Rt", matrixRotation, 3);
    // ImGui::InputFloat3("Sc", matrixScale, 3);
    // ImGuizmo::RecomposeMatrixFromComponents(matrixTranslation, matrixRotation, matrixScale, gizmoMatrix.m16);
    //
    // These functions have some numerical stability issues for now. Use with caution.
    decompose_matrix_to_components :: (
        matrix: *float,
        translation: *float,
        rotation: *float,
        scale: *float,
    ) -> void #foreign libimgui "?DecomposeMatrixToComponents@ImGuizmo@@YAXPEBMPEAM11@Z";
    recompose_matrix_from_components :: (
        translation: *float,
        rotation: *float,
        scale: *float,
        matrix: *float,
    ) -> void #foreign libimgui "?RecomposeMatrixFromComponents@ImGuizmo@@YAXPEBM00PEAM@Z";

    set_rect :: (x: float, y: float, width: float, height: float) -> void #foreign libimgui "?SetRect@ImGuizmo@@YAXMMMM@Z";

    // default is false
    set_orthographic :: (is_orthographic: bool) -> void #foreign libimgui "?SetOrthographic@ImGuizmo@@YAX_N@Z";

    // Render coordinate system axes (red X, green Y and blue Z). Usefull for debug/tests
    draw_axes :: (view: *float, projection: *float, matrices: *float, matrix_count: s32) -> void #foreign libimgui "?DrawAxes@ImGuizmo@@YAXPEBM00H@Z";

    // Render a cube with face color corresponding to face normal. Usefull for debug/tests
    draw_cubes :: (view: *float, projection: *float, matrices: *float, matrix_count: s32) -> void #foreign libimgui "?DrawCubes@ImGuizmo@@YAXPEBM00H@Z";
    draw_grid :: (view: *float, projection: *float, matrix: *float, grid_size: float) -> void #foreign libimgui "?DrawGrid@ImGuizmo@@YAXPEBM00M@Z";

    // Render grid with customizable major line step and amount of segments between major lines.
    // NOTE(m.wlasiuk) : calling this function with majorStep = 1.0f and subdivision = 1 is equivalent to DrawGrid in terms of the end result but performs more calculations
    draw_grid_custom :: (
        view: *float,
        projection: *float,
        matrix: *float,
        grid_size: float,
        major_step: float,
        subdivision: u32,
    ) -> void #foreign libimgui "?DrawGridCustom@ImGuizmo@@YAXPEBM00MMI@Z";

    // Render grid with customizable major line step and amount of segments between major lines and with possibility to set custom colors for major, minor and center lines
    draw_grid_custom_color :: (
        view: *float,
        projection: *float,
        matrix: *float,
        grid_size: float,
        major_step: float,
        subdivision: u32,
        major_col: ImU32,
        minor_col: ImU32,
        center_col: ImU32,
    ) -> void #foreign libimgui "?DrawGridCustomColor@ImGuizmo@@YAXPEBM00MMIIII@Z";

    // call it when you want a gizmo
    // Needs view and projection matrices.
    // matrix parameter is the source matrix (where will be gizmo be drawn) and might be transformed by the function. Return deltaMatrix is optional
    // translation is applied in world space
    Operation :: enum s32 {
        TRANSLATE_X   :: 1;
        TRANSLATE_Y   :: 2;
        TRANSLATE_Z   :: 4;
        ROTATE_X      :: 8;
        ROTATE_Y      :: 16;
        ROTATE_Z      :: 32;
        ROTATE_SCREEN :: 64;
        SCALE_X       :: 128;
        SCALE_Y       :: 256;
        SCALE_Z       :: 512;
        BOUNDS        :: 1024;
        SCALE_XU      :: 2048;
        SCALE_YU      :: 4096;
        SCALE_ZU      :: 8192;

        TRANSLATE :: 7;
        ROTATE    :: 120;
        SCALE     :: 896;
        SCALEU    :: 14336;
        UNIVERSAL :: 14463;
    }

    Mode :: enum s32 {
        LOCAL :: 0;
        WORLD :: 1;
    }

    manipulate :: (
        view: *float,
        projection: *float,
        operation: Operation,
        mode: Mode,
        matrix: *float,
        delta_matrix: *float = null,
        snap: *float = null,
        local_bounds: *float = null,
        bounds_snap: *float = null,
    ) -> bool #foreign libimgui "?Manipulate@ImGuizmo@@YA_NPEBM0W4OPERATION@1@W4MODE@1@PEAM3000@Z";

    //
    // Please note that this cubeview is patented by Autodesk : https://patents.google.com/patent/US7782319B2/en
    // It seems to be a defensive patent in the US. I don't think it will bring troubles using it as
    // other software are using the same mechanics. But just in case, you are now warned!
    //
    view_manipulate :: (
        view: *float,
        length: float,
        position: Vector2,
        size: Vector2,
        background_color: U32,
    ) -> void #foreign libimgui "?ViewManipulate@ImGuizmo@@YAXPEAMMUImVec2@@1I@Z";

    // use this version if you did not call Manipulate before and you are just using ViewManipulate
    view_manipulate :: (
        view: *float,
        projection: *float,
        operation: OPERATION,
        mode: MODE,
        matrix: *float,
        length: float,
        position: Vector2,
        size: Vector2,
        background_color: U32,
    ) -> void #foreign libimgui "?ViewManipulate@ImGuizmo@@YAXPEAMPEBMW4OPERATION@1@W4MODE@1@0MUImVec2@@4I@Z";

    set_alternative_window :: (window: *Window) -> void #foreign libimgui "?SetAlternativeWindow@ImGuizmo@@YAXPEAUImGuiWindow@@@Z";

    set_id :: (id: s32) -> void #foreign libimgui "?SetID@ImGuizmo@@YAXH@Z";

    // ID stack/scopes
    // Read the FAQ (docs/FAQ.md or http://dearimgui.org/faq) for more details about how ID are handled in dear imgui.
    // - Those questions are answered and impacted by understanding of the ID stack system:
    //   - "Q: Why is my widget not reacting when I click on it?"
    //   - "Q: How can I have widgets with an empty label?"
    //   - "Q: How can I have multiple widgets with the same label?"
    // - Short version: ID are hashes of the entire ID stack. If you are creating widgets in a loop you most likely
    //   want to push a unique identifier (e.g. object pointer, loop index) to uniquely differentiate them.
    // - You can also use the "Label##foobar" syntax within widget label to distinguish them from each others.
    // - In this header file we use the "label"/"name" terminology to denote a string that will be displayed + used as an ID,
    //   whereas "str_id" denote a string that is only used as an ID and not normally displayed.
    push_id :: (str_id: *u8) -> void #foreign libimgui "?PushID@ImGuizmo@@YAXPEBD@Z";
    push_id :: (str_id_begin: *u8, str_id_end: *u8) -> void #foreign libimgui "?PushID@ImGuizmo@@YAXPEBD0@Z";
    push_id :: (str_id_begin: *u8, str_id_end: *u8) #no_context {
        push_id(str_id_begin, str_id_end);
    }
    push_id :: (ptr_id: *void) -> void #foreign libimgui "?PushID@ImGuizmo@@YAXPEBX@Z";
    push_id :: (int_id: s32) -> void #foreign libimgui "?PushID@ImGuizmo@@YAXH@Z";
    pop_id :: () -> void #foreign libimgui "?PopID@ImGuizmo@@YAXXZ";
    get_id :: (str_id: *u8) -> ID #foreign libimgui "?GetID@ImGuizmo@@YAIPEBD@Z";
    get_id :: (str_id_begin: *u8, str_id_end: *u8) -> ID #foreign libimgui "?GetID@ImGuizmo@@YAIPEBD0@Z";
    get_id :: (str_id_begin: *u8, str_id_end: *u8) -> ID #no_context {
        return get_id(str_id_begin, str_id_end);
    }
    get_id :: (ptr_id: *void) -> ID #foreign libimgui "?GetID@ImGuizmo@@YAIPEBX@Z";

    // return true if the cursor is over the operation's gizmo
    is_over :: (op: Operation) -> bool #foreign libimgui "?IsOver@ImGuizmo@@YA_NW4OPERATION@1@@Z";
    set_gizmo_size_clip_space :: (value: float) -> void #foreign libimgui "?SetGizmoSizeClipSpace@ImGuizmo@@YAXM@Z";

    // Allow axis to flip
    // When true (default), the guizmo axis flip for better visibility
    // When false, they always stay along the positive world/local axis
    allow_axis_flip :: (value: bool) -> void #foreign libimgui "?AllowAxisFlip@ImGuizmo@@YAX_N@Z";

    // Configure the limit where axis are hidden
    set_axis_limit :: (value: float) -> void #foreign libimgui "?SetAxisLimit@ImGuizmo@@YAXM@Z";

    // Set an axis mask to permanently hide a given axis (true -> hidden, false -> shown)
    set_axis_mask :: (x: bool, y: bool, z: bool) -> void #foreign libimgui "?SetAxisMask@ImGuizmo@@YAX_N00@Z";

    // Configure the limit where planes are hiden
    set_plane_limit :: (value: float) -> void #foreign libimgui "?SetPlaneLimit@ImGuizmo@@YAXM@Z";

    // from a x,y,z point in space and using Manipulation view/projection matrix, check if mouse is in pixel radius distance of that projected point
    is_over :: (position: *float, pixelRadius: float) -> bool #foreign libimgui "?IsOver@ImGuizmo@@YA_NPEAMM@Z";

    Color :: enum s32 {
        DIRECTION_X           :: 0;
        DIRECTION_Y           :: 1;
        DIRECTION_Z           :: 2;
        PLANE_X               :: 3;
        PLANE_Y               :: 4;
        PLANE_Z               :: 5;
        SELECTION             :: 6;
        INACTIVE              :: 7;
        TRANSLATION_LINE      :: 8;
        SCALE_LINE            :: 9;
        ROTATION_USING_BORDER :: 10;
        ROTATION_USING_FILL   :: 11;
        HATCHED_AXIS_LINES    :: 12;
        TEXT                  :: 13;
        TEXT_SHADOW           :: 14;
        COUNT                 :: 15;
    }

    Style :: struct {
        constructor :: (this: *Style) -> void #cpp_method #foreign libimgui "??0Style@ImGuizmo@@QEAA@XZ";

        translation_line_thickness:   float; // Thickness of lines for translation gizmo
        translation_line_arrow_size:   float; // Size of arrow at the end of lines for translation gizmo
        rotation_line_thickness:      float; // Thickness of lines for rotation gizmo
        rotation_outer_line_thickness: float; // Thickness of line surrounding the rotation gizmo
        scale_line_thickness:         float; // Thickness of lines for scale gizmo
        scale_line_circle_size:        float; // Size of circle at the end of lines for scale gizmo
        hatched_axis_line_thickness:   float; // Thickness of hatched axis lines
        center_circle_size:           float; // Size of circle at the center of the translate/scale gizmo

        colors:                     [15] Vector4;
    }

    get_style :: () -> *Style #foreign libimgui "?GetStyle@ImGuizmo@@YAAEAUStyle@1@XZ";
}

Window :: struct {};
