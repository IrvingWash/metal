Mech :: struct {
    #as using base: Entity;

    name = "Mech";

    model_path = "../../Models/rex-12_mech.glb";

    scale = { 0.05, 0.05, 0.05 };
    rotation = #run -> Quaternion {
        quaternion: Quaternion;

        set_from_axis_and_angle(*quaternion, { 0, 1, 0 }, deg_to_rad(180));

        return quaternion;
    };


    walk_speed: float = 10;
    turn_speed := #run deg_to_rad(120);
    yaw: float = #run deg_to_rad(180);
}

simulate_mech :: (mech: *Mech, dt: float, input_state: Input.Input_State) {
    turned: bool;
    if input_state.keys[Input.Scan_Code.D] & .DOWN {
        mech.yaw -= mech.turn_speed * dt; 
        turned = true;
    }
    if input_state.keys[Input.Scan_Code.A] & .DOWN {
        mech.yaw += mech.turn_speed * dt; 
        turned = true;
    }
    if turned {
        set_from_axis_and_angle(
            *mech.rotation,
            Vector3.{ 0, 1, 0 },
            mech.yaw,
        );
    }

    forward := Vector3.{
        sin(mech.yaw),
        0,
        cos(mech.yaw),
    };

    if input_state.keys[Input.Scan_Code.W] & .DOWN {
        mech.position += forward * mech.walk_speed * dt;
    }
    if input_state.keys[Input.Scan_Code.S] & .DOWN {
        mech.position -= forward * mech.walk_speed * dt;
    }
}



#scope_file

Input :: #import "Input";
