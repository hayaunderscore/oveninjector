// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_play_external_music(sound) 
{
	// stop_music();
	// dont play two music ids at once, idiot.
	with (obj_musiccontroller)
	{
		if music != undefined
			audio_stop_sound(music);
		music = sound;
		audio_play_sound(music, 0, true);
	}
}
function scr_pause_external_music(toggle) 
{
	with (obj_musiccontroller)
	{
		if music != undefined
			return;
		if toggle == undefined
			toggle = !ignoreNaturalPause;
		ignoreNaturalPause = toggle;
		real_paused = toggle;
		if (real_paused) {
			audio_pause_sound(music);
		} else {
			audio_resume_sound(music);
		}
	}
	
}
function scr_stop_external_music() 
{
	with (obj_musiccontroller)
	{
		if music != undefined
			audio_stop_sound(music);
		music = undefined;
	}
}