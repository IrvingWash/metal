init_editor :: (game: *Game) {
    editor.game = game;

    editor.ctx = IM.create_context();
    editor.io = IM.get_io();

    editor.io.log_filename = null;

    ok := IM.impl_sdl3_init_for_vulkan(cast(*void, game.window));
    assert(ok, "Failed to init SDL3 for vulkan for editor");

    pool_sizes := VK.Descriptor_Pool_Size.[
        {
            type = .SAMPLED_IMAGE,
            descriptor_count = IM.IMPL_VULKAN_MINIMUM_SAMPLED_IMAGE_POOL_SIZE,
        },
        {
            type = .SAMPLER,
            descriptor_count = IM.IMPL_VULKAN_MINIMUM_SAMPLER_POOL_SIZE,
        },
    ];
    pool_info := VK.Descriptor_Pool_Create_Info.{
        flags           = .FREE_DESCRIPTOR_SET,
        max_sets        = 16,
        pool_size_count = pool_sizes.count,
        p_pool_sizes    = pool_sizes.data,
    };
    result:, editor.descriptor_pool = VK.create_descriptor_pool(game.renderer.device, *pool_info);
    assert(result == .SUCCESS, "%", result);

    vulkan_init_info := IM.Impl_Vulkan_Init_Info.{
        api_version           = VK.make_version(1, 4, 0),
        instance              = game.renderer.instance,
        physical_device       = game.renderer.physical_device,
        device                = game.renderer.device,
        queue_family          = game.renderer.graphics_queue_info.family_index,
        queue                 = game.renderer.graphics_queue_info.queue,
        descriptor_pool       = editor.descriptor_pool,
        min_image_count       = game.renderer.swapchain_info.config.min_image_count,
        image_count           = xx game.renderer.swapchain_info.images.count,
        use_dynamic_rendering = true,
        pipeline_info_main.pipeline_rendering_create_info = {
            color_attachment_count     = 1,
            p_color_attachment_formats = *game
                .renderer
                .swapchain_info
                .config
                .image_format,
        },
    };

    ok = IM.impl_vulkan_init(*vulkan_init_info);
    assert(ok, "Failed to init vulkan for editor");

    Renderer.set_overlay_callback(*game.renderer, draw_overlay, null);
    Input.set_raw_event_callback(*game.input_state, process_editor_events);
}

update_editor :: (dt: float) {
    if editor.game.input_state.mouse.right_button & .DOWN && !editor.io.want_capture_mouse {
        fly_camera(*editor.game.camera, dt, get_fly_camera_input());
    }

    if editor.game.input_state.mouse.left_button & .PRESSED && !editor.io.want_capture_mouse {
        pick_entity();
    }
}

draw_editor :: (draw_editing_stuff: bool) {
    IM.impl_vulkan_new_frame();
    IM.impl_sdl3_new_frame();
    IM.new_frame();

    draw_fps_stat();

    if draw_editing_stuff {
        draw_editor_window();

        draw_gizmos();
    }

    IM.render();
}

deinit_editor :: () {
    VK.device_wait_idle(editor.game.renderer.device);

    Input.set_raw_event_callback(*editor.game.input_state, null);
    Renderer.set_overlay_callback(*editor.game.renderer, null, null);

    IM.impl_vulkan_shutdown();
    VK.destroy_descriptor_pool(editor.game.renderer.device, editor.descriptor_pool);
    IM.impl_sdl3_shutdown();

    IM.destroy_context(editor.ctx);

    editor = {};
}



#scope_file

Editor :: struct {
    game: *Game;

    ctx: *IM.Context;
    io:  *IM.IO;

    descriptor_pool: VK.Descriptor_Pool;

    is_entity_header_open:    bool;
    selected_entity_id:       s32;
    gizmo_mode:               Gizmo_Mode;
    gizmo_operation:          Gizmo_Operation;
    should_draw_model_bounds: bool;
}

Gizmo_Mode :: enum {
    WORLD;
    LOCAL;
}

Gizmo_Operation :: enum {
    TRANSLATE;
    ROTATE;
    SCALE;
}

editor: Editor;

draw_editor_window :: () {
    IM.begin(
        "Editor",
    );
    draw_camera_section();
    draw_entity_section();
    draw_directional_light_section();
    draw_renderer_section();

    IM.end();
}

draw_directional_light_section :: () {
    if !IM.collapsing_header("Directional light") {
        return;
    }

    IM.push_item_width(200);
    is_changed := IM.color_picker3(
        "Color##DirectionalLight",
        *editor.game.directional_light.color.component,
        flags = .NO_SIDE_PREVIEW | .DISPLAY_RGB,
    );
    is_changed |= IM.drag_float(
        "Intensity##DirectionalLight",
        *editor.game.directional_light.intensity,
        v_speed = 0.1,
    );
    is_changed |= IM.drag_float3(
        "Direction##DirectionalLight",
        *editor.game.directional_light.direction.component,
        v_speed = 0.1,
    );
}

draw_gizmos :: () {
    IM.Zmo.begin_frame();
    IM.Zmo.set_orthographic(false);
    IM.Zmo.set_drawlist(IM.get_background_draw_list());
    view_rect_min, view_rect_max := Renderer.get_view_rectangle(editor.game.renderer);
    IM.Zmo.set_rect(
        view_rect_min.x,
        view_rect_min.y,
        view_rect_max.x - view_rect_min.x,
        view_rect_max.y - view_rect_min.y,
    );

     // Entity
    if editor.is_entity_header_open {
        selected_entity := editor.game.entity_manager.all[editor.selected_entity_id];

        column_major_matrix := transpose(make_world_transform(selected_entity));

        if IM.Zmo.manipulate(
            view = transpose(editor.game.renderer.transforms.view).floats.data,
            projection = transpose(editor.game.renderer.transforms.projection).floats.data,
            operation = gizmo_operation_to_imguizmo(editor.gizmo_operation),
            mode = gizmo_mode_to_imguizmo(editor.gizmo_mode),
            matrix = column_major_matrix.floats.data,
        ) {
            matrix := transpose(column_major_matrix);

            if #complete editor.gizmo_operation == {
                case .TRANSLATE;
                    selected_entity.position = calculate_translation_from_transform(matrix);
                case .SCALE;
                    selected_entity.scale    = calculate_scale_from_transform(matrix);
                case .ROTATE;
                    selected_entity.rotation = calculate_rotation_from_transform(matrix);
            }
        }
    }
}

draw_renderer_section :: () {
    if !IM.collapsing_header("Renderer") {
        return;
    }

    IM.drag_float(
        "Shadow distance ##Renderer",
        *editor.game.renderer.shadow_distance,
        v_speed = 0.5,
    );

    IM.separator_text("Ambient color##Renderer");
    { // Ambient
        ambient := Renderer.get_ambient_color(editor.game.renderer);

        IM.push_item_width(200);
        if IM.color_picker3(
            "##AmbientColor##Renderer",
            *ambient.component,
            flags = .NO_SIDE_PREVIEW | .DISPLAY_RGB,
        ) {
            Renderer.set_ambient_color(*editor.game.renderer, ambient);
        }
    }

    IM.separator_text("Clear color##Renderer");
    { // Clear color
        color := Renderer.get_clear_color(editor.game.renderer);
        IM.push_item_width(200);
        if IM.color_picker4(
            "##ClearColor##Renderer",
            *color.component,
            flags = .NO_SIDE_PREVIEW | .DISPLAY_RGB,
        ) {
            Renderer.set_clear_color(*editor.game.renderer, color);
        }
    }
}

draw_entity_section :: () {
    for entity: editor.game.entity_manager.all {
        if entity.flags & .INVISIBLE {
            draw_sphere(entity.position, 0.5);
        }
    }

    IM.set_next_item_open(editor.is_entity_header_open);
    editor.is_entity_header_open = IM.collapsing_header("Entities");
    if !editor.is_entity_header_open {
        return;
    }

    IM.combo(
        "##Entity",
        current_item = *editor.selected_entity_id,
        getter = (user_data: *void, idx: s32) -> *u8 #c_call {
            push_context {
                return temp_c_string(editor.game.entity_manager.all[idx].name);
            }
        },
        user_data = null,
        items_count = xx editor.game.entity_manager.all.count,
    );

    selected_entity := editor.game.entity_manager.all[editor.selected_entity_id];

    IM.checkbox(
        "Draw model bounds",
        *editor.should_draw_model_bounds,
    );
    if editor.should_draw_model_bounds {
        model_asset := asset_manager_get_model(
            editor.game.asset_manager,
            selected_entity.model_asset_handle,
        );

        entity_transform := make_world_transform(selected_entity);
        draw_model_aabb(model_asset.model_accessor, entity_transform);
        draw_model_obb(model_asset.model_accessor, entity_transform, { 1, 0, 0, 1 });
    }

    { // Gizmo operations
        IM.push_item_width(100);
        defer IM.pop_item_width();
        IM.combo(
            "##Gizmo operation",
            cast(*s32, *editor.gizmo_operation),
            getter = (user_data: *void, idx: s32) -> *u8 #c_call {
                push_context {
                    return temp_c_string(enum_names(Gizmo_Operation)[idx]);
                }
            },
            user_data = null,
            xx enum_name_count(Gizmo_Operation),
        );
        IM.same_line();
        IM.combo(
            "##Gizmo mode",
            cast(*s32, *editor.gizmo_mode),
            getter = (user_data: *void, idx: s32) -> *u8 #c_call {
                push_context {
                    return temp_c_string(enum_names(Gizmo_Mode)[idx]);
                }
            },
            user_data = null,
            xx enum_name_count(Gizmo_Mode),
        );
    }

    IM.drag_float3(
        "Position##Entity",
        *selected_entity.position.component,
        v_speed = 0.1,
        v_min = 0,
        v_max = 0,
    );

    IM.drag_float3(
        "Scale##Entity",
        *selected_entity.scale.component,
        v_speed = 0.1,
        v_min = 0,
        v_max = 0,
    );

    euler := quaternion_to_euler(selected_entity.rotation);
    euler_degrees: Vector3 = {
        x = rad_to_deg(euler.x),
        y = rad_to_deg(euler.y),
        z = rad_to_deg(euler.z),
    };

    if IM.drag_float3(
        "Rotation##Entity",
        *euler_degrees.component,
        v_speed = 0.5,
        v_min = 0,
        v_max = 0,
    ) {
        euler_radians := Vector3.{
            x = deg_to_rad(euler_degrees.x),
            y = deg_to_rad(euler_degrees.y),
            z = deg_to_rad(euler_degrees.z),
        };

        selected_entity.rotation = euler_to_quaternion(euler_radians);
    }

    IM.color_picker4(
        "Tint##Entity",
        *selected_entity.tint.component,
        flags = .NO_SIDE_PREVIEW | .DISPLAY_RGB,
    );
}

draw_camera_section :: () {
    if !IM.collapsing_header("Camera") {
        return;
    }

    IM.push_item_width(200);

    IM.drag_float3(
        "Position##Camera",
        *editor.game.camera.position.component,
        v_speed = 0.1,
        v_min = 0,
        v_max = 0,
    );

    { // Rotation
        MAX_PITCH :: 89;

        yaw, pitch    := calculate_yaw_and_pitch_from_direction(editor.game.camera.front);
        yaw_degrees   := rad_to_deg(yaw);
        pitch_degrees := rad_to_deg(pitch);

        is_yaw_changed := IM.drag_float("Yaw", *yaw_degrees);
        is_pitch_changed := IM.drag_float("Pitch", *pitch_degrees);

        if is_yaw_changed || is_pitch_changed {
            direction := calculate_direction_from_yaw_and_pitch(
                deg_to_rad(yaw_degrees),
                deg_to_rad(clamp(pitch_degrees, -MAX_PITCH, MAX_PITCH)),
            );
            editor.game.camera.front = direction;
        }
    }

    { // FOV
        SPEED :: 1;
        MIN   :: 1;
        MAX   :: 120;

        current_fov_in_degrees := rad_to_deg(editor.game.camera.fov_vertical);

        if IM.drag_float(
            "FOV vertical##Camera",
            *current_fov_in_degrees,
            v_speed = SPEED,
            v_min = MIN,
            v_max = MAX,
        ) {
            editor.game.camera.fov_vertical = deg_to_rad(current_fov_in_degrees);
        }
    }

    IM.drag_float(
        "Exposure##Camera",
        *editor.game.camera.exposure,
        v_speed = 0.1,
        v_min = 0,
        v_max = 0,
    );
}

draw_fps_stat :: () {
    WIDTH :: 80;

    viewport := IM.get_main_viewport();

    IM.set_next_window_bg_alpha(0.5);
    IM.set_next_window_pos({ viewport.work_pos.x + viewport.work_size.x - WIDTH, 0 });
    IM.set_next_window_size({ WIDTH, 0 });

    IM.begin(
        "FPS",
        flags = .NO_TITLE_BAR | .NO_RESIZE | .NO_COLLAPSE | .NO_DECORATION | .NO_NAV_FOCUS,
    );

    IM.text(tprint("FPS: %", cast(int, editor.io.framerate)));

    IM.end();
}

process_editor_events :: (event: *Input.Raw_Event_Type) {
    IM.impl_sdl3_process_event(cast(*void, event));
}

draw_overlay : Renderer.Overlay_Callback : (command_buffer: VK.Command_Buffer, user_data: *void) {
    draw_data := IM.get_draw_data();

    if draw_data {
        IM.impl_vulkan_render_draw_data(draw_data, cast(*void, command_buffer));
    }
}

pick_entity :: () {
    width, height := Windowing.get_renderable_size(editor.game.window);

    // Letterboxing offset
    view_rect_min := Renderer.get_view_rectangle(editor.game.renderer);

    ray_direction := Input.cast_ray_from_mouse_position(
        editor.game.input_state,
        Vector2.{ xx width, xx height },
        editor.game.renderer.transforms.projection,
        editor.game.renderer.transforms.view,
        offset = view_rect_min,
    );

    ray_position := editor.game.camera.position;

    Hit_Entity :: struct {
        id:       int;
        distance: float;
    };

    hit_entities: [..]Hit_Entity;
    hit_entities.allocator = temp;
    for entity: editor.game.entity_manager.all {
        model_asset := asset_manager_get_model(editor.game.asset_manager, entity.model_asset_handle);

        ok, distance := ray_vs_aabb(
            ray_position,
            ray_direction,
            model_asset.model_accessor.aabb,
            make_world_transform(entity),
        );

        if ok {
            array_add(*hit_entities, { id = it_index, distance = distance });
        }
    }

    if hit_entities.count < 1 {
        return;
    }

    editor.is_entity_header_open = true;

    quick_sort(
        hit_entities,
        (a: Hit_Entity, b: Hit_Entity) -> int {
            if b.distance > a.distance
                return -1;
            if a.distance > b.distance
                return 1;
            return 0;
        },
    );

    currently_selected_entity_index := -1;
    for hit_entity: hit_entities {
        if hit_entity.id == editor.selected_entity_id {
            currently_selected_entity_index = it_index;
        }
    }

    if (
        currently_selected_entity_index > -1
        && hit_entities.count - 1 > currently_selected_entity_index
    ) {
        editor.selected_entity_id = cast(s32, hit_entities[currently_selected_entity_index + 1].id);
        return;
    } else {
        editor.selected_entity_id = cast(s32, hit_entities[0].id);
        return;
    }
}

gizmo_operation_to_imguizmo :: (operation: Gizmo_Operation) -> IM.Zmo.Operation {
    if #complete operation == {
        case .TRANSLATE;
            return .TRANSLATE;
        case .ROTATE;
            return .ROTATE;
        case .SCALE;
            return .SCALE;
    }
}

gizmo_mode_to_imguizmo :: (mode: Gizmo_Mode) -> IM.Zmo.Mode {
    if #complete mode == {
        case .WORLD;
            return .WORLD;
        case .LOCAL;
            return .LOCAL;
    }
}

#import "Sort";

IM    :: #import "Dear_ImGui";
VK    :: #import "Jai_Vulkan";

Input     :: #import "Input";
Renderer  :: #import "Renderer";
Windowing :: #import "Windowing";
#import "Type_Utils";
