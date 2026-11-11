Animation :: struct {
    name: string;

    duration: float;
    tracks: [..]Animation_Track;
}

Animation_Track :: struct {
    node_index:    u32;

    path:          Animation_Path;
    interpolation: Animation_Interpolation;

    keyframe_times: [..]float;
    keyframe_values: union kind: Animation_Path {
        .TRANSLATION,, translation: [..]Vector3;
        .SCALE,,       scale:       [..]Vector3;
        .ROTATION,,    rotation:    [..]Quaternion;
    };
}

Animation_Path :: enum {
    TRANSLATION;
    ROTATION;
    SCALE;
}

Animation_Interpolation :: enum {
    LINEAR;
    STEP;
}
