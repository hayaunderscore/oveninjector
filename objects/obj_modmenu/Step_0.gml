depth = -400;
scr_menu_getinput();
key_taunt = tdp_input_get("player_taunt").held || tdp_input_get("player_tauntC").held;
key_taunt2 = tdp_input_get("player_taunt").pressed || tdp_input_get("player_tauntC").pressed;
if startbuffer > 0
{
	startbuffer--;
	key_back = false;
	key_jump = false;
	key_jump2 = false;
	key_down2 = false;
	key_up2 = false;
	key_taunt = false;
	key_taunt2 = false;
}
var move = key_down2 - key_up2;

if obj_option.saved_mod_menu_option != -1
{
	move = 0;
	optionselected = obj_option.saved_mod_menu_option;
	obj_option.saved_mod_menu_option = -1;
}

var os = optionselected;
optionselected += move;
optionselected = clamp(optionselected, 0, array_length(mod_list) - 1);
if os != optionselected
	fmod_event_one_shot("event:/sfx/ui/step");
	
for (var i = 0; i < array_length(mod_list); i++)
{
	var select = mod_info[? mod_list[i]];
	select.rnd_x = irandom_range(-1, 1);
	select.rnd_y = irandom_range(-1, 1);
	select.rnd2_x = irandom_range(-1, 1);
	select.rnd2_y = irandom_range(-1, 1);
}
	
var option = mod_list[optionselected];

if (key_jump || -key_left2 || key_right2)
{
	fmod_event_one_shot("event:/sfx/ui/select");
	if ds_list_find_index(mods_on, option) == -1
	{
		trace("Loaded mod!");
		scr_loadmod(option);
		ds_list_add(mods_on, option);
		startbuffer = 5;
	}
	else
	{
		trace("Unloaded mod!");
		scr_unloadmod(option);
		ds_list_delete(mods_on, ds_list_find_index(mods_on, option));
		startbuffer = 5;
	}
}

// TERRIBLE CODE
// TODO: REWORK THIS SHIT
if (key_taunt2)
{
	if ds_list_find_index(mods_on, option) == -1
	{
		instance_destroy(obj_transfotip);
		with (instance_create(0, 0, obj_transfotip))
		{
			text = "Please enable the mod first!"
			yoffset -= 100;
			smalltext = true;
		}
	}
	else
	{
		if mod_info[? option].options == ""
		{
			instance_destroy(obj_transfotip);
			with (instance_create(0, 0, obj_transfotip))
			{
				text = "This mod has no configuration!"
				yoffset -= 100;
				smalltext = true;
			}
		}
		else // the nesting here is gonna make me bleed
		{
			var m = obj_option.menus;
			var i = 0;
			for (i = 0; i < array_length(m); i++)
			{
				if m[i].menu_id == menus.mod_menu
				{
					array_delete(m, i, 1);
					break;
				}
			}
			var mod_options = create_menu_fixed(menus.mod_menu, anchor.left, 150, 40, menus.realmod_menu);
			var select = mod_info[? option];
			var options = string_split(select.options, ",");
			trace(select.options);
			add_option_press(mod_options, 0, "option_back", function()
			{
				obj_option.key_jump = false;
				with (obj_option)
					menu_goto(menus.realmod_menu);
				instance_create(0, 0, obj_modmenu);
			});
			for (i = 0; i < array_length(options); i++)
			{
				if options[i] == "" continue;
				trace("New option: " + options[i]);
				ini_open_from_string(obj_savesystem.ini_str_options);
				var defval = ini_read_real("ModOptions", options[i], 0);
				with (obj_customcontroller)
				{
					if variable_instance_exists(id, options[i])
						defval = ini_read_real("ModOptions", options[i], variable_instance_get(id, options[i]));
				}
				var trueval = add_option_toggle(mod_options, i + 1, string_upper(options[i]), function(val, name)
				{
					name = string_lower(name);
					ini_open_from_string(obj_savesystem.ini_str_options);
					ini_write_real("ModOptions", name, val);
					obj_savesystem.ini_str_options = ini_close();
					instance_activate_object(obj_customcontroller);
					with (obj_customcontroller)
					{
						if variable_instance_exists(id, name)
							variable_instance_set(id, name, val);
						if !runPaused && obj_pause.pause
							instance_deactivate_object(id);
					}
					gamesave_async_save_options();
				}, false);
				trueval.value = bool(defval);
				obj_savesystem.ini_str_options = ini_close();
				with (obj_customcontroller)
				{
					if modname == select.name
					{
						if !variable_instance_exists(id, options[i])
							variable_instance_set(id, options[i], trueval.value);
					}
				}
			}
			array_push(obj_option.menus, mod_options);
			with (obj_option)
			{
				backbuffer = 2;
				key_jump = false;
				menu_goto(menus.mod_menu);
			}
			fmod_event_one_shot("event:/sfx/ui/select");
			obj_option.saved_mod_menu_option = optionselected;
			instance_destroy();
		}
	}
}

if (key_back || keyboard_check_pressed(vk_escape))
{
	fmod_event_one_shot("event:/sfx/ui/back");
	with (obj_option)
	{
		backbuffer = 2;
		menu_goto(menus.options);
	}
	instance_destroy();
}