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

    center_offset := transformed_aabb.center - mech.position;

    target := game.grid.cell_centers[mech.grid_row][mech.grid_column] - center_offset;
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

Input :: #import "Input";
