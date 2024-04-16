// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

// mod info related stuff
function scr_mod_info(path) 
{
	// open up
	ini_open_from_string(get_string_from_file(path))
	
	// all of the data related to the mod is stored here lmaoao
	var st = {
		// metadata
		name: ini_read_string("meta", "name", ""),						// name of mod
		desc: ini_read_string("meta", "description", ""),				// basic description
		author: ini_read_string("meta", "author", ""),					// author(s)
		version: ini_read_string("meta", "version", "1.0"),				// version
		// path to gml scripts
		init: ini_read_string("gml", "init", "scripts/init.gml"),						// runs on creation of the obj_custom object
		destroy: ini_read_string("gml", "destroy", "scripts/destroy.gml"),					// runs on destruction of the object
		begin_step: ini_read_string("gml", "begin_step", "scripts/begin_step.gml"),			// runs on the frame before step is called
		step: ini_read_string("gml", "step", "scripts/step.gml"),						// runs on every frame
		end_step: ini_read_string("gml", "end_step", "scripts/end_step.gml"),				// runs after every step is called and before the game draws to the screen
		begin_draw: ini_read_string("gml", "begin_draw", "scripts/begin_draw.gml"),			// runs before draw
		draw: ini_read_string("gml", "draw", "scripts/draw.gml"),						// runs when drawing to the screen
		end_draw: ini_read_string("gml", "end_draw", "scripts/end_draw.gml"),				// runs after draw
		// ? no i will not put in predraw and postdraw as they see no use for now
		begin_draw_gui: ini_read_string("gml", "begin_draw_gui", "scripts/begin_gui.gml"),	// runs before draw gui
		draw_gui: ini_read_string("gml", "draw_gui", "scripts/gui.gml"),				// runs when drawing to the screen without being affected by a camera
		end_draw_gui: ini_read_string("gml", "end_draw_gui", "scripts/end_gui.gml"),		// runs after draw gui
		// these should be self explanatory
		room_start: ini_read_string("gml", "room_start", "scripts/room_start.gml"),
		room_end: ini_read_string("gml", "room_end", "scripts/room_end.gml"),
	}
	
	ini_close()
	return st
}