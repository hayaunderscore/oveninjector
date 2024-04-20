// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_oven_splittext(text, font = global.font_small)
{
	var p = 1;
	var l = string_length(text);
	var old_text = text;
	text = "";
	draw_set_font(font);
	trace("Separating text: ", old_text);
	while p <= l
	{
		text = string_insert(string_char_at(old_text, p), text, p + 1);
		text = scr_separate_text(text, -4, SCREEN_WIDTH - 16);
		p++;
	}
	trace("Separated text: ", text);
	return text;
}