draw_set_font(lang_get_font("creditsfont"));
draw_set_alpha(1);
draw_set_halign(0);
draw_set_valign(0);
draw_set_color(c_white);
var xx = (SCREEN_WIDTH / 2) - 320;
var c = (optionselected == -1) ? c_white : c_gray;
var ks = optionselected;
if ks < 0
	ks = 0;
select_visual = lerp(select_visual, ks, 0.1);
for (var i = 0; i < array_length(mod_list); i++)
{
	tdp_draw_set_font(lang_get_font("creditsfont"));
	tdp_draw_set_halign(fa_left);
	tdp_draw_set_valign(fa_top);
	var yy = 40 + (72 - (select_visual * 72)) + (72 * i);
	var select = mod_info[? mod_list[i]];
	var icon_x = xx; var icon_y = yy + 32;
	if (optionselected == i)
	{
		icon_x += select.rnd_x;
		icon_y += select.rnd_y;
	}
	draw_sprite(select.icon, 1, icon_x, icon_y);
	c = (optionselected == i) ? c_white : c_gray;
	var text_x = xx + 72; var text_y = yy + 6;
	if ds_list_find_index(mods_on, mod_list[i]) != -1
	{
		c = (optionselected == i) ? c_lime : c_green;
		text_x += select.rnd2_x;
		text_y += select.rnd2_y;
	}
	tdp_draw_text_color(text_x, text_y, select.name, c, c, c, c, 1);
	tdp_text_commit(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

var selectedmodinfo = mod_info[? mod_list[optionselected]];
draw_set_color(c_black);
draw_set_alpha(0.25);
draw_rectangle(0, (SCREEN_HEIGHT / 2) + SCREEN_HEIGHT / 4, SCREEN_WIDTH, SCREEN_HEIGHT, false);
var yy = (SCREEN_HEIGHT / 2) + SCREEN_HEIGHT / 4 + 30;
tdp_draw_set_font(lang_get_font("creditsfont"));
tdp_draw_set_halign(fa_left);
tdp_draw_set_valign(fa_top);
tdp_draw_text_color(12, yy - 30, selectedmodinfo.name, c_yellow, c_yellow, c_yellow, c_yellow, 1);
var str_width = string_width(selectedmodinfo.name);
draw_set_font(global.font_small);
tdp_draw_text_color(12 + str_width + 6, yy - 12, selectedmodinfo.version, c_white, c_white, c_white, c_white, 1);
tdp_draw_text_color(12, yy + 9, selectedmodinfo.author, c_white, c_white, c_white, c_white, 1);
draw_set_font(global.font_small);
scr_draw_text_arr(12, yy + 40, selectedmodinfo.description, c_white, 1);
draw_set_color(c_white);
draw_set_alpha(1);
draw_text(4, 4, "Press the taunt key for mod specific options.");
if room != Mainmenu
{
	with obj_transfotip
		event_perform(ev_draw, ev_gui);
}