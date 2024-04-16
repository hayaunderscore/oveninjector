// This is a gml file.
persistent = true;

// assets
var assetpath = mod_dir + "assets/";
if (!directory_exists(assetpath)) {
	show_message("Lap 3 assets directory does not seem to exist. Make sure to extract the zip into your Toppinloader folder!");
	exit;
}
global.spr_tllap3 =
	sprite_add(assetpath + "spr_lap3.png", 1, false, false, 123, 0);
global.spr_tllap3warning =
	sprite_add(assetpath + "spr_lap3warning.png", 1, false, false, 50, 50);
global.spr_tlrankLAPPED =
	sprite_add(assetpath + "spr_rankLAPPED.png", 10, false, false, 480, 270);
sprite_set_speed(global.spr_tlrankLAPPED, 1, spritespeed_framespergameframe)
global.spr_tllap3_hud =
	sprite_add(assetpath + "spr_lap3_hud.png", 2, false, false, 34, 32);
global.mu_tllap3 = audio_create_stream(assetpath + "mu_lap3.ogg");

global.lap3 = 0;
runPaused = true;

reset_lap3 = live_snippet_create(@'
	if (room != rank_room || global.levelreset) global.lap3 = 0;
	scr_stop_external_music();
');

live_snippet_call(reset_lap3);

with (obj_player1) other.depth = depth + 1;