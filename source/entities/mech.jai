Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    scale = { 0.05, 0.05, 0.05 };

    strafe_speed: float = 3;

    grid_row: s8 = 1;
    grid_column: s8 = 1;
}

simulate_mech :: (mech: *Mech, dt: float) {
    // Orient so mech looks along camera z
    yaw := atan2(game.camera.front.x, game.camera.front.z);
    set_from_axis_and_angle(*mech.rotation, { 0, 1, 0 }, yaw);

    grid := make_grid(mech);

    if game.input_state.keys[Input.Scan_Code.D] & .PRESSED
        mech.grid_column += 1;
    if game.input_state.keys[Input.Scan_Code.A] & .PRESSED
        mech.grid_column -= 1;
    if game.input_state.keys[Input.Scan_Code.W] & .PRESSED
        mech.grid_row -= 1;
    if game.input_state.keys[Input.Scan_Code.S] & .PRESSED
        mech.grid_row += 1;
    mech.grid_row    = clamp(mech.grid_row, 0, 2);
    mech.grid_column = clamp(mech.grid_column, 0, 2);

    mech.position = grid[mech.grid_row][mech.grid_column];
}



#scope_file

make_grid :: (mech: Mech) -> [3][3]Vector3 {
    grid: [3][3]Vector3;

    camera_basis := calculate_camera_basis(game.camera);

    depth := dot(mech.position - game.camera.position, camera_basis.front);
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
        half      := size / 2;
        cell_size := size / 3;

        for i: 0..3 {
            offset := -half + cell_size * i;

            draw_line(
                view_center + camera_basis.right * offset - camera_basis.up * half,
                view_center + camera_basis.right * offset + camera_basis.up * half,
            );
            draw_line(
                view_center + camera_basis.up * offset - camera_basis.right * half,
                view_center + camera_basis.up * offset + camera_basis.right * half,
            );
        }
    }
}

Input :: #import "Input";
Renderer :: #import "Renderer";
