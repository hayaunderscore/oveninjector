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
	draw_sprite(mod_info[? mod_list[i]].icon, 1, xx, yy + 32);
	c = (optionselected == i) ? c_white : c_gray;
	if ds_list_find_index(mods_on, mod_list[i]) != -1
		c = (optionselected == i) ? c_lime : c_green;
	tdp_draw_text_color(xx + 72, yy, mod_info[? mod_list[i]].name, c, c, c, c, 1);
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
tdp_draw_text_color(12, yy - 30, selectedmodinfo.name, c_white, c_white, c_white, c_white, 1);
draw_set_font(global.font_small);
scr_draw_text_arr(12, yy + 20, selectedmodinfo.description, c_white, 1);