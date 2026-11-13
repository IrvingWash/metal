Animation :: struct {
    name: string;

    duration: float;
    tracks: [..]Animation_Track;
}

Animation_Player :: struct {
    animation_index:     Option(int);

    playback_time: float;
    should_loop:   bool;
    pose:          [..]Renderer.Node_Transform;
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

play_animation :: (
    entity: *Entity,
    animation_name: string,
    asset_manager: Asset_Manager,
    should_loop: bool,
) {
    model_asset := asset_manager_get_model(asset_manager, entity.model_asset_handle);

    animation: Animation;
    animation_index: int = -1;
    for candidate_animation: model_asset.animations {
        if candidate_animation.name == animation_name {
            animation = candidate_animation;
            animation_index = it_index;
            break;
        }
    }
    assert(animation_index != -1, "Couldn't find animation % to start playing it", animation_name);

    entity.animation_player.animation_index = some(animation_index);
    entity.animation_player.should_loop = should_loop;
    entity.animation_player.playback_time = 0;

    array_resize(
        *entity.animation_player.pose,
        model_asset.model_accessor.nodes.count,
        initialize = false,
    );
    for node: model_asset.model_accessor.nodes {
        entity.animation_player.pose[it_index] = node.local_transform;
    }
}

update_animation :: (entity: *Entity, dt: float, asset_manager: Asset_Manager) {
    if entity.animation_player.animation_index.kind == .NONE {
        return;
    }

    animation := asset_manager_get_model(asset_manager, entity.model_asset_handle)
        .animations[entity.animation_player.animation_index.some];

    player := *entity.animation_player;

    player.playback_time += dt;

    if animation.duration > 0 {
        if player.should_loop {
            player.playback_time = fmod_cycling(player.playback_time, animation.duration);
        } else {
            player.playback_time = min(player.playback_time, animation.duration);
        }
    }

    for track: animation.tracks {
        sample_track_into_pose(track, player.playback_time, player.pose);
    }
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



#scope_file

sample_track_into_pose :: (track: Animation_Track, playback_time: float, pose: []Renderer.Node_Transform) {
    target := *pose[track.node_index];

    keyframe_index := get_keyframe_index(track.keyframe_times, playback_time);
    next_keyframe_index := min(
        keyframe_index + 1,
        track.keyframe_times.count - 1,
    );


    t: float;
    if #complete track.interpolation == {
        case .STEP;
            t = 0;
        case .LINEAR;
            left_time  := track.keyframe_times[keyframe_index];
            right_time := track.keyframe_times[next_keyframe_index];
            if right_time > left_time {
                t = clamp((playback_time - left_time) / (right_time - left_time), 0, 1);
            }
    }

    if #complete track.keyframe_values.path == {
        case .TRANSLATION;
            left := track.keyframe_values.translation[keyframe_index];
            right := track.keyframe_values.translation[next_keyframe_index];
            target.translation = lerp(left, right, t);
        case .ROTATION;
            left := track.keyframe_values.rotation[keyframe_index];
            right := track.keyframe_values.rotation[next_keyframe_index];
            target.rotation = slerp(left, right, t);
        case .SCALE;
            left := track.keyframe_values.scale[keyframe_index];
            right := track.keyframe_values.scale[next_keyframe_index];
            target.scale = lerp(left, right, t);
    }
}

get_keyframe_index :: (keyframe_times: []float, playback_time: float) -> int {
    if playback_time < keyframe_times[0] {
        return 0;
    }

    if playback_time > peek(keyframe_times) {
        return keyframe_times.count - 1;
    }

    left: int;
    right := keyframe_times.count - 1;

    while right - left > 1 {
        middle := (right + left) / 2;
        if playback_time <= keyframe_times[middle] {
            right = middle;
        } else {
            left = middle;
        }
    }

    return left;
}

Renderer :: #import "Renderer";
