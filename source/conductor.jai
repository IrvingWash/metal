Conductor :: struct {
    track: Audio_Asset;
    enemy_cube: *Enemy_Cube;
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

update_conductor :: (conductor: *Conductor) {
    song_time := Audio_Player.get_current_position_in_seconds(game.audio_player, conductor.track.audio_accessor);

    if song_time >= SPAWN_TIMESTAMP && !spawned {
        conductor.enemy_cube = spawn_entity(
            *game.entity_manager,
            Enemy_Cube.{
                position = game.grid.cell_centers[1][1],
            },
        );
        spawned = true;
    }

    if song_time >= LAUNCH_TIMESTAMP {
        conductor.enemy_cube.tint = { 1, 0, 0, 1 };
    }

    if spawned {
        set_from_axis_and_angle(*conductor.enemy_cube.rotation, { 0, 0, 1 }, song_time * 100);

        target := game.grid.cell_centers[1][1];
        start  := game.camera.position + (target - game.camera.position) * SPAWN_DISTANCE_FACTOR;

        progress := clamp((song_time - LAUNCH_TIMESTAMP) / (INTERSECT_TIMESTAMP - LAUNCH_TIMESTAMP), 0, 1);
        conductor.enemy_cube.position = lerp(start, target, cast(float, progress));
    }
}



#scope_file

Audio_Player :: #import "Audio_Player";
