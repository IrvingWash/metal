Audio_Player :: struct {
    engine: *ma_engine;

    sounds: Bucket_Array(ma_sound, 32);
}

Audio_Accessor :: struct {
    sound_locator: Bucket_Locator;
}

init :: () -> error: string, Audio_Player {
    player: Audio_Player;

    player.engine = New(ma_engine);

    result := ma_engine_init(null, player.engine);
    if result != .SUCCESS {
        return
            tprint("Failed to initialize Audio_Player engine: %", result),
            player;
    }

    return "", player;
}

deinit :: (player: *Audio_Player) {
    for *sound: player.sounds {
        ma_sound_uninit(sound);
    }
    bucket_array_reset(*player.sounds);

    ma_engine_uninit(player.engine);
    free(player.engine);

    player.* = {};
}

upload_audio :: (player: *Audio_Player, path: string) -> error: string, Audio_Accessor {
    audio_accessor: Audio_Accessor;

    locator, sound := bucket_array_add(*player.sounds, .{});

    result := ma_sound_init_from_file(
        player.engine,
        temp_c_string(path),
        cast(u32, ma_sound_flags.DECODE),
        null,
        null,
        sound,
    );
    if result != .SUCCESS {
        bucket_array_remove(*player.sounds, locator);

        return
            tprint("Failed to initialize sound at %: %", path, result),
            {};
    }

    audio_accessor.sound_locator = locator;

    return "", audio_accessor;
}

play_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor) {
    sound := bucket_array_find_pointer(*player.sounds, audio_accessor.sound_locator);

    ma_sound_start(sound);
}

stop_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor) {
    sound := *player.sounds[audio_accessor.sound_locator];

    ma_sound_stop(sound);
    ma_sound_seek_to_pcm_frame(sound, 0);
}

pause_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor) {
    sound := bucket_array_find_pointer(*player.sounds, audio_accessor.sound_locator);

    ma_sound_stop(sound);
}

set_volume_for_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor, volume: float) {
    sound := bucket_array_find_pointer(*player.sounds, audio_accessor.sound_locator);

    ma_sound_set_volume(sound, volume);
}

get_current_position_in_seconds :: (player: Audio_Player, audio_accessor: Audio_Accessor) -> float {
    result: float;
    sound := bucket_array_find_pointer(*player.sounds, audio_accessor.sound_locator);

    ma_sound_get_cursor_in_seconds(sound, *result);

    return result;
}



#scope_file

#import "Basic";
#import "Mini_Audio";
#import "Bucket_Array";
