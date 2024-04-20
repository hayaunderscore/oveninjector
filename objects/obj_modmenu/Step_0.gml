depth = -400;
scr_menu_getinput();
if startbuffer > 0
{
	startbuffer--;
	key_back = false;
	key_jump = false;
	key_jump2 = false;
}
var move = key_down2 - key_up2;

var os = optionselected;
optionselected += move;
optionselected = clamp(optionselected, 0, array_length(mod_list) - 1);
if os != optionselected
	fmod_event_one_shot("event:/sfx/ui/step");
	
for (var i = 0; i < array_length(mod_list); i++)
{
	var select = mod_info[? mod_list[i]];;
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

if (key_back || keyboard_check_pressed(vk_escape))
{
	fmod_event_one_shot("event:/sfx/ui/back");
	if (instance_exists(obj_option))
		obj_option.backbuffer = 2;
	instance_destroy();
}