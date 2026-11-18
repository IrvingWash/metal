Conductor :: struct {
    track: Audio_Asset;
    cube: *Cube;
}

start_conductor :: (conductor: *Conductor) {
    Audio_Player.play_audio(*game.audio_player, conductor.track.audio_accessor);
    Audio_Player.set_volume_for_audio(*game.audio_player, conductor.track.audio_accessor, 0.1);
}

spawned: bool;

SPAWN_TIMESTAMP     :: 17.135;
INTERSECT_TIMESTAMP :: 22.135;
SPAWN_DISTANCE_FACTOR :: 10.0;

update_conductor :: (conductor: *Conductor) {
    song_time := Audio_Player.get_current_position_in_seconds(game.audio_player, conductor.track.audio_accessor);

    if song_time >= SPAWN_TIMESTAMP && !spawned {
        conductor.cube = spawn_entity(
            *game.entity_manager,
            Cube.{
                tint = { 1, 0, 0, 1 },
            },
        );
        spawned = true;
    }

    if spawned {
        target := game.grid.cell_centers[1][1];
        start  := game.camera.position + (target - game.camera.position) * SPAWN_DISTANCE_FACTOR;

        progress := (song_time - SPAWN_TIMESTAMP) / (INTERSECT_TIMESTAMP - SPAWN_TIMESTAMP);
        conductor.cube.position = lerp(start, target, cast(float, progress));
    }
}



#scope_file

Audio_Player :: #import "Audio_Player";
