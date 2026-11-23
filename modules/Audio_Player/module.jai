Audio_Player :: struct {
    engine: *ma_engine;
}

Audio_Accessor :: struct {
    sound: *ma_sound;
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
    ma_engine_uninit(player.engine);
    free(player.engine);

    player.* = {};
}

upload_audio :: (player: *Audio_Player, path: string) -> error: string, Audio_Accessor {
    audio_accessor: Audio_Accessor;
    audio_accessor.sound = New(ma_sound);

    result := ma_sound_init_from_file(
        player.engine,
        temp_c_string(path),
        cast(u32, ma_sound_flags.DECODE),
        null,
        null,
        audio_accessor.sound,
    );
    if result != .SUCCESS {
        return
            tprint("Failed to initialize sound at %: %", path, result),
            {};
    }

    return "", audio_accessor;
}

destroy_audio :: (audio_asset: *Audio_Accessor) {
    ma_sound_uninit(audio_asset.sound);
    free(audio_asset.sound);
}

play_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor) {
    ma_sound_start(audio_accessor.sound);
}

stop_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor) {
    ma_sound_stop(audio_accessor.sound);
    ma_sound_seek_to_pcm_frame(audio_accessor.sound, 0);
}

pause_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor) {
    ma_sound_stop(audio_accessor.sound);
}

set_volume_for_audio :: (player: *Audio_Player, audio_accessor: Audio_Accessor, volume: float) {
    ma_sound_set_volume(audio_accessor.sound, volume);
}

get_current_position_in_seconds :: (player: Audio_Player, audio_accessor: Audio_Accessor) -> float {
    result: float;
    ma_sound_get_cursor_in_seconds(audio_accessor.sound, *result);

    return result;
}



#scope_file

#import "Basic";
#import "Mini_Audio";
