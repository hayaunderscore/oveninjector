// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_play_external_music(sound) {
	stop_music();
	// dont play two music ids at once, idiot.
	if obj_musiccontroller.music != undefined
		audio_stop_sound(obj_musiccontroller.music);
	obj_musiccontroller.music = sound;
	audio_play_sound(obj_musiccontroller.music, 0, true);
}
function scr_stop_external_music() {
	if obj_musiccontroller.music != undefined
		audio_stop_sound(obj_musiccontroller.music);
	obj_musiccontroller.music = undefined;
}