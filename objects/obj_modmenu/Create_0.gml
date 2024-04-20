mod_list = [];
mods_on = ds_list_create();
mod_info = ds_map_create();
optionselected = 0;
select_visual = 0;
startbuffer = 5;
// Look, I dont't want to always chuck shit in obj_player, ok?
if !variable_global_exists("stored_mod_icons")
	global.stored_mod_icons = ds_map_create();
file = file_find_first(working_directory + "mods/*", fa_directory);
while (file != "")
{
	var file_dir = working_directory + "mods/" + file + "/";
	var modini = file_dir + "mod.ini"
	if !file_exists(modini)
	{
		file = file_find_next();
		continue;
	}
	ini_open_from_string(get_string_from_file(modini, false));
	var _modname = ini_read_string("meta", "name", "");
	if _modname == ""
	{
		file = file_find_next();
		ini_close();
		continue;
	}
	with (obj_customcontroller)
	{
		if modname == _modname
			ds_list_add(other.mods_on, other.file);
	}
	var icon = spr_defaulticon;
	var icon_path = ini_read_string("meta", "icon", "");
	var icon_base64 = ini_read_string("meta", "icon_base64", "")
	if icon_path != "" || icon_base64 != ""
		icon = global.stored_mod_icons[? (icon_base64 == "") ? icon_path : icon_base64];
	// could not find icon
	if icon == undefined
	{
		// icon is encoded in base 64
		if icon_base64 != ""
		{
			var decoded = buffer_base64_decode(icon_base64);
			buffer_save(decoded, working_directory + "temp_sprite.png");
			buffer_delete(decoded);
			icon = sprite_add(working_directory + "temp_sprite.png", 1, false, false, 32, 32);
			ds_map_add(global.stored_mod_icons, icon_base64, icon);
			file_delete(working_directory + "temp_sprite.png");
		}
		// not encoded in base64, is a path to an icon
		else if icon_path != ""
		{
			icon = sprite_add(file_dir + icon_path, 1, false, false, 32, 32);
			ds_map_add(global.stored_mod_icons, icon_path, icon);
		}
	}
		
	show_debug_message("Added " + file + " to mod list");
	array_push(mod_list, file);
	var desc = string_replace_all(ini_read_string("meta", "description", ""), "$", "\"");
	desc = string_replace_all(desc, "\\n", "\n");
	var text = scr_oven_splittext(desc);
	ds_map_add(mod_info, file, {
		icon: icon,
		name: ini_read_string("meta", "name", ""),
		description: scr_compile_icon_text(text),
		author: ini_read_string("meta", "author", ""),
		version: ini_read_string("meta", "version", ""),
		rnd_x: 0,
		rnd_y: 0,
		rnd2_x: 0,
		rnd2_y: 0
	});
	file = file_find_next();
	ini_close();
}