if (music != undefined && audio_is_playing(music)) {
	audio_sound_gain(music, global.option_master_volume * global.option_music_volume, 0);
	if (global.option_unfocus_mute && !window_has_focus()) {
		audio_sound_gain(music, 0, 0);
	}
}