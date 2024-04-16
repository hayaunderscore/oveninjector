if obj_pause.pause
	return;

if (!global.panic) global.lap = 0;
if (global.lap) {
	with (obj_lapportal) visible = global.lap3;
}
if (global.lap3) {
	with (obj_lapportal) instance_destroy();
}
with (obj_pizzaface) {
	if (room == graveyard_7 || room == graveyard_9b || room == sewer_12 || room == farm_4) {
		maxspeed = 4;
		sprite_index = spr_pizzahead_haywire;
	} else {
		sprite_index = spr_pizzaface;
		maxspeed = 8;		
	}
}
if (room == rank_room && global.lap3) {
	ini_open_from_string(obj_savesystem.ini_str);
	ini_write_real("Game", (string(global.leveltosave) + "6"), 2);
	obj_savesystem.ini_str = ini_close();	
}
if (global.levelreset) {
	live_snippet_call(reset_lap3);
}