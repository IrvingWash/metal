Grid :: struct {
    depth: float = 2.5;
    cell_centers: [3][3]Vector3;
}

update_grid :: (grid: *Grid) {
    grid.cell_centers = make_grid(grid.depth);
}



#scope_file

make_grid :: (depth: float) -> [3][3]Vector3 {
    grid: [3][3]Vector3;

    camera_basis := calculate_camera_basis(game.camera);

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

Renderer :: #import "Renderer";
