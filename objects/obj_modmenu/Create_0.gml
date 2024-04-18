mod_list = [];
mods_on = ds_list_create();
mod_icons = ds_map_create();
mod_info = ds_map_create();
optionselected = 0;
select_visual = 0;
startbuffer = 5;
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
	// icon is encoded in base 64
	if icon_base64 != ""
	{
		// has not been cached yet
		if global.stored_mod_icons[? icon_base64] == undefined
		{
			var decoded = buffer_base64_decode(icon_base64);
			buffer_save(decoded, working_directory + "temp_sprite.png");
			buffer_delete(decoded);
			icon = sprite_add(working_directory + "temp_sprite.png", 1, false, false, 32, 32);
			ds_map_add(global.stored_mod_icons, icon_base64, icon);
			file_delete(working_directory + "temp_sprite.png");
		}
		else
		{
			icon = global.stored_mod_icons[? icon_base64];
		}
	}
	// not encoded in base64, is a path to an icon
	else if icon_path != ""
	{
		// has not been cached yet
		if global.stored_mod_icons[? icon_path] == undefined
		{
			icon = sprite_add(file_dir + icon_path, 1, false, false, 32, 32);
			ds_map_add(global.stored_mod_icons, icon_path, icon);
		}
		else
		{
			icon = global.stored_mod_icons[? icon_path];
		}
	}
		
	show_debug_message("Added " + file + " to mod list");
	array_push(mod_list, file);
	ds_map_add(mod_icons, file, icon);
	var text = ini_read_string("meta", "description", "");
	var p = 1;
	var l = string_length(text);
	var old_text = text;
	text = "";
	draw_set_font(global.font_small);
	trace("Separating text: ", old_text);
	while p <= l
	{
		text = string_insert(string_char_at(old_text, p), text, p + 1);
		text = scr_separate_text(text, -4, (96*((SCREEN_WIDTH - 64) / 96)) - (16 * 2));
		p++;
	}
	trace("Separated text: ", text);
	ds_map_add(mod_info, file, {
		icon: icon,
		name: ini_read_string("meta", "name", ""),
		description: scr_compile_icon_text(text),
		author: ini_read_string("meta", "author", ""),
		version: ini_read_string("meta", "version", "")
	});
	file = file_find_next();
	ini_close();
}