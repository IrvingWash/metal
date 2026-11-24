Conductor :: struct {
    track: Audio_Asset;
    enemy_cube: Entity_Token;
}

start_conductor :: (conductor: *Conductor) {
    Audio_Player.play_audio(*game.audio_player, conductor.track.audio_accessor);
    Audio_Player.set_volume_for_audio(*game.audio_player, conductor.track.audio_accessor, 0.1);
}

spawned:   bool;
despawned: bool;

SPAWN_TIMESTAMP :: 4.965;
LAUNCH_TIMESTAMP :: 5.586;
INTERSECT_TIMESTAMP :: 5.793;
SPAWN_DISTANCE_FACTOR :: 5;
DESPAWN_TIMESTAMP :: 6.413;

update_conductor :: (conductor: *Conductor) {
    song_time := Audio_Player.get_current_position_in_seconds(game.audio_player, conductor.track.audio_accessor);

    if despawned {
        return;
    }

    if !despawned && song_time >= DESPAWN_TIMESTAMP {
        enemy_cube := get_entity(*game.entity_manager, conductor.enemy_cube);
        remove_entity(*game.entity_manager, enemy_cube);
        despawned = true;
    }

    if song_time >= SPAWN_TIMESTAMP && !spawned {
        enemy_cube := spawn_entity(
            *game.entity_manager,
            Enemy_Cube.{
                position = game.grid.cell_centers[0][0],
            },
        );

        conductor.enemy_cube = enemy_cube.token;

        spawned = true;
    }

    if song_time >= LAUNCH_TIMESTAMP {
        enemy_cube := get_entity(*game.entity_manager, conductor.enemy_cube);
        enemy_cube.tint = { 1, 0, 0, 1 };
    }

    if spawned {
        enemy_cube := get_entity(*game.entity_manager, conductor.enemy_cube);

        set_from_axis_and_angle(*enemy_cube.rotation, { 0, 0, 1 }, song_time * 50);

        target := game.grid.cell_centers[0][0];
        start  := game.camera.position + (target - game.camera.position) * SPAWN_DISTANCE_FACTOR;

        progress := clamp((song_time - LAUNCH_TIMESTAMP) / (INTERSECT_TIMESTAMP - LAUNCH_TIMESTAMP), 0, 1);
        enemy_cube.position = lerp(start, target, cast(float, progress));
    }
}



#scope_file

Audio_Player :: #import "Audio_Player";
