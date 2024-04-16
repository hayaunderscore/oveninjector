function get_bool(str)
{
	if str == "true"
	{
		str = true;
		return str;
	}
	else if str == "false"
	{
		str = false;
		return str;
	}
	else if (is_real(real(string_digits(str))))
	{
		str = bool(real(string_digits(str)));
		return str;
	}
	return undefined;
}

function get_number_string(str)
{
	var n = str;
	if (is_string(str))
	{
		n = real(string_digits(str));
		if (string_char_at(str, 1) == "-")
			n = -real(string_digits(str));
	}
	return n;
}

function sh_set_game_speed(args)
{
	game_set_speed(floor(real(args[1])), gamespeed_fps);
}

function meta_set_game_speed()
{
	return {
		description: "Sets the current game speed.",
		arguments: ["speed"]
	}
}

function sh_test_p_rank(args)
{
	if !variable_global_exists("leveltosave")
		return "You must be in a level to do this."
	global.collect = global.srank + 5000;
	global.lap = true;
	global.treasure = true;
	global.secretfound = 3;
	global.combodropped = false;
	global.prank_enemykilled = true;
	global.combotime = 60;
	global.combo = 99;
	global.panic = true;
}

function meta_test_p_rank()
{
	return {
		description: "Gives you a valid p-rank."
	}
}

function sh_kill_boss(args)
{
	instance_destroy(obj_baddie);
}

function sh_set_boss_hp(args)
{
	with obj_baddie
		elitehit = real(args[1]);
}

function sh_switch_char(args)
{
	if !instance_exists(obj_player)
		return "Player does not currently exist!"
		
	with obj_player
	{
		character = "P";
		ispeppino = !ispeppino;
		scr_characterspr();
	}
}

function meta_switch_char()
{
	return {
		description: "Switches you between Peppino and The Noise."
	}
}

function sh_gateswitchmax(args)
{
	global.gateswitch = global.gateswitchmax;
}

function sh_roomcheck(args)
{
	instance_create_unique(0, 0, obj_roomcheck);
}

function sh_unlock_toppins(args)
{
	if (array_length(args) <= 1)
		return "You have not defined a level!"
	var level_name_ini = args[1]
	ini_open_from_string(obj_savesystem.ini_str);
	ini_write_real("Toppin", concat(level_name_ini, 1), true);
	ini_write_real("Toppin", concat(level_name_ini, 2), true);
	ini_write_real("Toppin", concat(level_name_ini, 3), true);
	ini_write_real("Toppin", concat(level_name_ini, 4), true);
	ini_write_real("Toppin", concat(level_name_ini, 5), true);
	obj_savesystem.ini_str = ini_close();
	gamesave_async_save();
}

function sh_unlock_boss_key(args)
{
	if (array_length(args) <= 1)
		return "No floor number provided!"
	var number = real(args[1]);
	ini_open_from_string(obj_savesystem.ini_str);
	var n = concat("w", number, "stick");
	ini_write_real(n, "bosskey", true);
	obj_savesystem.ini_str = ini_close();
	gamesave_async_save();
}

function sh_lock_cam(args)
{
	with obj_camera
		lock = !lock;
}

function sh_bossinv(args)
{
	global.boss_invincible = !global.boss_invincible;
}

function meta_bossinv()
{
	return {
		description: "Damage is not applied to your health nor your rank."
	}
}

function sh_hidetiles(args)
{
	if (array_length(args) <= 1)
		global.hidetiles = !global.hidetiles;
	else
		global.hidetiles = args[1];
	layer_set_visible("Tiles_BG", !global.hidetiles);
	layer_set_visible("Tiles_BG2", !global.hidetiles);
	layer_set_visible("Tiles_BG3", !global.hidetiles);
	layer_set_visible("Tiles_1", !global.hidetiles);
	layer_set_visible("Tiles_2", !global.hidetiles);
	layer_set_visible("Tiles_3", !global.hidetiles);
	layer_set_visible("Tiles_4", !global.hidetiles);
	layer_set_visible("Tiles_Foreground1", !global.hidetiles);
	layer_set_visible("Tiles_Foreground2", !global.hidetiles);
	layer_set_visible("Tiles_Foreground3", !global.hidetiles);
}

function sh_noclip(args)
{
	with obj_player1
		state = states.debugstate;
}

function meta_noclip()
{
	return {
		description: "I feel like this is self-explanatory."
	}
}

function sh_givekey(args)
{
	global.key_inv = true;
}

function meta_givekey()
{
	return {
		description: "Gives you a boss key to use to unlock the next floor."
	}
}

function sh_set_combo(args)
{
	var combo = args[1]
	var combotime = args[2]
	
	if combo == undefined
		return "What combo?"
	if combotime == undefined
		combotime = 60;
		
	global.combo = real(combo);
	global.combotime = real(combotime);
	with obj_player
		supercharge = 10;
}

function meta_set_combo()
{
	return {
		description: "Sets your combo to a specific number and remaining time.",
		arguments: ["combo", "combotime"],
		argumentDescriptions: [
			"Desired combo",
			"Amount of time before combo runs out"
		]
	}
}

function sh_alltoppins(args)
{
	if (!instance_exists(obj_pizzakincheese))
		instance_create(obj_player1.x, obj_player1.y, obj_pizzakincheese);
	if (!instance_exists(obj_pizzakintomato))
		instance_create(obj_player1.x, obj_player1.y, obj_pizzakintomato);
	if (!instance_exists(obj_pizzakinsausage))
		instance_create(obj_player1.x, obj_player1.y, obj_pizzakinsausage);
	if (!instance_exists(obj_pizzakinpineapple))
		instance_create(obj_player1.x, obj_player1.y, obj_pizzakinpineapple);
	if (!instance_exists(obj_pizzakinshroom))
		instance_create(obj_player1.x, obj_player1.y, obj_pizzakinshroom);
	global.cheesefollow = true;
	global.tomatofollow = true;
	global.sausagefollow = true;
	global.pineapplefollow = true;
	global.shroomfollow = true;
}

function meta_alltoppins()
{
	return {
		description: "Gives you all of the toppins."
	}
}

function sh_panic(args)
{
	var fill = 4000
	if (array_length(args) > 1)
		fill = args[1]
		
	if fill != ""
		fill = get_number_string(fill);
	else
		fill = 4000;
		
	global.panic = !global.panic;
	global.fill = fill;
	if global.panic
		obj_camera.alarm[1] = 60;
	obj_tv.chunkmax = global.fill;
}

function meta_panic()
{
	return {
		description: "Toggles pizza time.",
		arguments: ["time"],
		argumentDescriptions: [
			"The time to set to the panic timer."
		]
	}
}

function sh_showcollisions(args)
{
	obj_debugcontroller.showcollisions = !obj_debugcontroller.showcollisions;
	event_perform(ev_other, ev_room_start);
}

function meta_showcollisions()
{
	return {
		description: "Show collision objects."
	}
}

function sh_showhud(args)
{
	var toggle = args[1]
	if toggle == undefined
		return "nah"
	toggle = get_bool(toggle);
	show_debug_message(!toggle);
	if toggle != undefined
	{
		obj_debugcontroller.showhud = toggle;
		with obj_tv
		{
			visible = toggle;
			show_debug_message(visible);
		}
		with obj_camera
		{
			visible = toggle;
			show_debug_message(visible);
		}
		with obj_roomname
		{
			visible = toggle;
			show_debug_message(visible);
		}
		with obj_pigtotal
		{
			visible = toggle;
			show_debug_message(visible);
		}
	}
}

function sh_player_room(args)
{
	var _room = args[1]
	var _door = args[2]
	if _room == undefined
		exit;
	if _door == undefined
		exit;
		
	_room = asset_get_index(_room);
	if _room == -1
		exit;
	with obj_player
	{
		targetRoom = _room;
		targetDoor = _door;
	}
	instance_create(x, y, obj_fadeout);
}

function sh_camera_zoom(args)
{
	var zoom = args[1]
	var spd = args[2]
	if zoom == undefined
		return "No zoom provided!"
	if spd != undefined
		spd = get_number_string(spd);
		
	with obj_camera
	{
		targetzoom = zoom;
		targetzoom = clamp(targetzoom, 0, max_zoom);
		if spd != undefined
			zoomspd = abs(spd);
	}
}

// EXPERIMENTAL
function sh_loadgml(args)
{
	if args[1] == undefined
		return "Please input a path to a gml file."
	var file_buffer = buffer_load(working_directory + args[1]);
	var s = buffer_read(file_buffer, buffer_string);
	buffer_delete(file_buffer);
	if !live_execute_string(s)
		trace("WHOOPSIES! AN ERROR! " + string(live_result));
}

function meta_loadgml()
{
	return {
		description: "Loads and executes a gml file from the game directory.",
		arguments: ["path"],
		argumentDescriptions: [
			"The path to the gml file."
		],
		hidden: false,
		deferred: false
	}
}

// EXPERIMENTAL EVEN MORE
function sh_loadmod(args)
{
	if args[1] == undefined
		return "Please input a path to a mod folder. (Without \"mods/\".)";
	
	var fullpath = working_directory + "mods/" + args[1];
	if !string_ends_with(fullpath, "/")
		fullpath = fullpath + "/";
		
	if !directory_exists(fullpath)
		return "Mod folder does not exist.";
		
	var coolinfo = scr_mod_info(fullpath + "mod.ini");
	var initsnipper = live_snippet_create(get_string_from_file(fullpath + coolinfo.init));
	if initsnipper == undefined
	{
		if live_result == 0
			return "A mod must have a valid init script!";
		return "Compile error! " + string(live_result);
	}
	
	if coolinfo.name == ""
		return "PLEASE name your mod via the mod.ini."
	
	with (instance_create(0, 0, obj_customcontroller))
	{
		// by default, mods are persistent
		// for mods that dont control much you can set persistent to false on init.gml
		persistent = true;
		// mod identifier
		modname = coolinfo.name;
		modid = id;
		// you'd want this
		mod_dir = fullpath;
		// by default, custom objects get paused on well, the pause screen
		// this variable toggles that
		runPaused = false;
		// call init script from within this custom object
		live_snippet_call(initsnipper);
		// all event stuff
		events.destroy = live_snippet_create(get_string_from_file(fullpath + coolinfo.destroy));
		events.begin_step = live_snippet_create(get_string_from_file(fullpath + coolinfo.begin_step));
		events.step = live_snippet_create(get_string_from_file(fullpath + coolinfo.step));
		events.end_step = live_snippet_create(get_string_from_file(fullpath + coolinfo.end_step));
		events.begin_draw = live_snippet_create(get_string_from_file(fullpath + coolinfo.begin_draw));
		events.draw = live_snippet_create(get_string_from_file(fullpath + coolinfo.draw));
		events.end_draw = live_snippet_create(get_string_from_file(fullpath + coolinfo.end_draw));
		events.begin_gui = live_snippet_create(get_string_from_file(fullpath + coolinfo.begin_draw_gui));
		events.gui = live_snippet_create(get_string_from_file(fullpath + coolinfo.draw_gui));
		events.end_gui = live_snippet_create(get_string_from_file(fullpath + coolinfo.end_draw_gui));
		events.room_start = live_snippet_create(get_string_from_file(fullpath + coolinfo.room_start));
		events.room_end = live_snippet_create(get_string_from_file(fullpath + coolinfo.room_end));
	}
}