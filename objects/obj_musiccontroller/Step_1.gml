/// @description Insert description here
// You can write your code in this editor
if instance_exists(obj_pause)
	paused = obj_pause.pause;
if room != Loadiingroom
{
	key_start = tdp_input_get("menu_start").pressed || tdp_input_get("menu_startC").pressed;
	if ((!paused) && instance_exists(obj_player1) && key_start && room != Mainmenu && room != Finalintro && room != hub_loadingscreen && room != Endingroom && room != Creditsroom && room != Johnresurrectionroom && room != Longintro && room != Realtitlescreen && room != rank_room) {
		paused = true;
	}
	if music != undefined
	{
		if (paused) {
			audio_pause_sound(music);
		} else {
			audio_resume_sound(music);
		}
	}
}