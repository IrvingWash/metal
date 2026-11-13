Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    scale = { 0.1, 0.1, 0.1 };
    rotation = #run -> Quaternion {
        quaternion: Quaternion;

        set_from_axis_and_angle(*quaternion, { 0, 1, 0 }, deg_to_rad(180));

        return quaternion;
    };
}
