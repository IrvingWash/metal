Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    scale = { 0.05, 0.05, 0.05 };

    speed: float = 15;

    grid_row:    s8 = 1;
    grid_column: s8 = 1;
}

simulate_mech :: (mech: *Mech, dt: float) {
    orient_along_camera(mech);

    key_state := game.input_state.keys;
    using,only(Scan_Code) Input;
    right := ifx key_state[Scan_Code.D] & .DOWN then 1 else 0;
    left  := ifx key_state[Scan_Code.A] & .DOWN then 1 else 0;
    up    := ifx key_state[Scan_Code.W] & .DOWN then 1 else 0;
    down  := ifx key_state[Scan_Code.S] & .DOWN then 1 else 0;

    mech.grid_column = cast(s8, 1 + right - left);
    mech.grid_row    = cast(s8, 1 + down - up);

    model_accessor := asset_manager_get_model(game.asset_manager, mech.model_asset_handle).model_accessor;

    transformed_aabb := transform_aabb(model_accessor.aabb, make_world_transform(mech));

    grid := make_grid(transformed_aabb.center);
    center_offset := transformed_aabb.center - mech.position;

    target := grid[mech.grid_row][mech.grid_column] - center_offset;
    blend := 1 - exp(-mech.speed * dt);

    mech.position = lerp(mech.position, target, blend);
}



#scope_file

orient_along_camera :: (mech: *Mech) {
    yaw := atan2(game.camera.front.x, game.camera.front.z);
    pitch := asin(clamp(-game.camera.front.y, -1, 1));
    yaw_orientation, pitch_orientation: Quaternion;
    set_from_axis_and_angle(*yaw_orientation, { 0, 1, 0 }, yaw);
    set_from_axis_and_angle(*pitch_orientation, { 1, 0, 0 }, pitch);
    mech.rotation = yaw_orientation * pitch_orientation;
}

// @Todo: cache
make_grid :: (center: Vector3) -> [3][3]Vector3 {
    grid: [3][3]Vector3;

    camera_basis := calculate_camera_basis(game.camera);

    depth := dot(center - game.camera.position, camera_basis.front);
    tan_half_vertical := tan(game.camera.fov_vertical / 2);
    visible_height := 2 * depth * tan_half_vertical;
    visible_width := visible_height * Renderer.get_render_aspect_ratio(game.renderer);

    visible_square_size := min(visible_width, visible_height);

    grid_offset_x := ifx visible_width > visible_height
        then (visible_width - visible_square_size) / 2
        else 0;
    grid_offset_y := ifx visible_height > visible_width
        then (visible_height - visible_square_size) / 2
        else 0;

    cell_size := visible_square_size / 3;

    view_center := game.camera.position + camera_basis.front * depth;

    for row: 0..2 {
        for column: 0..2 {
            x := -visible_width / 2 + grid_offset_x + cell_size / 2 + cell_size * column;
            y := visible_height / 2 - grid_offset_y - cell_size / 2 - cell_size * row;

            grid[row][column] = view_center + camera_basis.right * x + camera_basis.up * y;
        }
    }

    #if DEVELOPER {
        draw_grid(view_center, camera_basis, visible_square_size);
    }

    return grid;
}

#if DEVELOPER {
    draw_grid :: (view_center: Vector3, camera_basis: Camera_Basis, size: float) {
        half_size := size / 2;
        cell_size := size / 3;

        for i: 0..3 {
            offset := -half_size + cell_size * i;

            draw_line(
                view_center + camera_basis.right * offset - camera_basis.up * half_size,
                view_center + camera_basis.right * offset + camera_basis.up * half_size,
            );
            draw_line(
                view_center + camera_basis.up * offset - camera_basis.right * half_size,
                view_center + camera_basis.up * offset + camera_basis.right * half_size,
            );
        }
    }
}

Input :: #import "Input";
Renderer :: #import "Renderer";
