function live_snippet_create_wrapper(gml_code, name = "snippet")
{
	var snippet = live_snippet_create(gml_code, name);
	if snippet == undefined
	{
		with (obj_transfotip)
		{
			text = "Compile error! " + string(live_result);
			yoffset -= 100;
			smalltext = true;
		}
	}
	return snippet;
}

function scr_loadmod(path)
{
	var fullpath = working_directory + "mods/" + path;
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
		
	// get mod-related options
	var mod_conf = string_split(coolinfo.options, ",");
	var i = 0;
	
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
		// This is stupid.
		ini_open_from_string(get_string_from_file(fullpath + "mod.ini"))
		for (i = 0; i < array_length(mod_conf); i++)
		{
			if mod_conf[i] == "" continue;
			variable_instance_set(id, mod_conf[i], ini_read_real("options", mod_conf[i], 0));
		}
		ini_close();
		// This is stupid (again).
		ini_open_from_string(obj_savesystem.ini_str_options)
		for (i = 0; i < array_length(mod_conf); i++)
		{
			if mod_conf[i] == "" continue;
			if ini_key_exists("ModOptions", mod_conf[i])
				variable_instance_set(id, mod_conf[i], ini_read_real("ModOptions", mod_conf[i], 0));
		}
		obj_savesystem.ini_str_options = ini_close();
		// call init script from within this custom object
		live_snippet_call(initsnipper);
		// all event stuff
		events.destroy = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.destroy));
		events.begin_step = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.begin_step));
		events.step = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.step));
		events.end_step = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.end_step));
		events.begin_draw = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.begin_draw));
		events.draw = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.draw));
		events.end_draw = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.end_draw));
		events.begin_gui = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.begin_draw_gui));
		events.gui = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.draw_gui));
		events.end_gui = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.end_draw_gui));
		events.room_start = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.room_start));
		events.room_end = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.room_end));
	}
}

function scr_unloadmod(path)
{
	var fullpath = working_directory + "mods/" + path;
	if !string_ends_with(fullpath, "/")
		fullpath = fullpath + "/";
		
	if !directory_exists(fullpath)
		return "Mod folder does not exist.";
		
	var coolinfo = scr_mod_info(fullpath + "mod.ini");
	
	instance_activate_object(obj_customcontroller);
	with (obj_customcontroller)
	{
		if coolinfo.name == modname
			instance_destroy();
		else if !runPaused && obj_pause.pause
			instance_deactivate_object(id);
	}
}

function instance_custom(x, y, script_path)
{
	trace(mod_dir);
	var fullpath = mod_dir;
	var coolinfo = {
		name: modname,
		init: "scripts/" + script_path + "/init.gml",
		destroy: "scripts/" + script_path + "/destroy.gml",
		begin_step: "scripts/" + script_path + "/begin_step.gml",
		step: "scripts/" + script_path + "/step.gml",
		end_step: "scripts/" + script_path + "/end_step.gml",
		begin_draw: "scripts/" + script_path + "/begin_draw.gml",
		draw: "scripts/" + script_path + "/draw.gml",
		end_draw: "scripts/" + script_path + "/end_draw.gml",
		begin_draw_gui: "scripts/" + script_path + "/begin_gui.gml",
		draw_gui: "scripts/" + script_path + "/gui.gml",
		end_draw_gui: "scripts/" + script_path + "/end_gui.gml",
		room_start: "scripts/" + script_path + "/room_start.gml",
		room_end: "scripts/" + script_path + "/room_end.gml",
	}
	var initsnipper = live_snippet_create(get_string_from_file(fullpath + coolinfo.init));
	if initsnipper == undefined
	{
		if live_result == 0
			live_trace("A mod must have a valid init script!");
		live_trace("Compile error! " + string(live_result));
		trace("hi undefined");
		return;
	}
	var _c = instance_create(x, y, obj_customcontroller);
	trace("hi");
	with (_c)
	{
		// by default, mods are persistent
		// for mods that dont control much you can set persistent to false on init.gml
		persistent = true;
		modname = coolinfo.name;
		// by default, custom objects get paused on well, the pause screen
		// this variable toggles that
		runPaused = false;
		// call init script from within this custom object
		live_snippet_call(initsnipper);
		// all event stuff
		events.destroy = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.destroy));
		events.begin_step = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.begin_step));
		events.step = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.step));
		events.end_step = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.end_step));
		events.begin_draw = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.begin_draw));
		events.draw = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.draw));
		events.end_draw = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.end_draw));
		events.begin_gui = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.begin_draw_gui));
		events.gui = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.draw_gui));
		events.end_gui = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.end_draw_gui));
		events.room_start = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.room_start));
		events.room_end = live_snippet_create_wrapper(get_string_from_file(fullpath + coolinfo.room_end));
	}
	return _c;
}