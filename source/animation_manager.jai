Animation :: struct {
    name: string;

    duration: float;
    tracks: [..]Animation_Track;
}

Animation_Track :: struct {
    node_index:    u32;

    interpolation: Animation_Interpolation;

    keyframe_times: [..]float;
    keyframe_values: union path: Animation_Path {
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

destroy_animation :: (animation: *Animation) {
    free(animation.name);

    for track: animation.tracks {
        if #complete track.keyframe_values.path == {
            case .TRANSLATION;
                array_free(track.keyframe_values.translation);
            case .ROTATION;
                array_free(track.keyframe_values.rotation);
            case .SCALE;
                array_free(track.keyframe_values.scale);
        }

        array_free(track.keyframe_times);
    }
    array_free(animation.tracks);
}
