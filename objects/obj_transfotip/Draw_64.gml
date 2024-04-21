if !global.option_hud
	exit;

draw_set_font(lang_get_font("creditsfont"));
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(fade);
draw_set_color(c_white);

var xx = SCREEN_WIDTH / 2;
var yy = (SCREEN_HEIGHT - 50) + yoffset;
if global.panic && !instance_exists(obj_ghostcollectibles) && yoffset == 0
	yy -= 60;

var s = text_size;
xx -= (s[0] / 2);
yy -= s[1];
xx = floor(xx);
yy = floor(yy);

global.tdp_text_try_outline = true;
if smalltext
{
	draw_set_font(global.font_small);
	draw_set_alpha(fade * 0.5);
	draw_rectangle_color(xx - 6, yy - 6, xx + s[0] + 6, yy + s[1], c_black, c_black, c_black, c_black, false);
	draw_set_alpha(fade);
}
scr_draw_text_arr(xx, yy, text_arr, c_white, fade);
global.tdp_text_try_outline = false;
tdp_text_commit(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);

draw_set_alpha(1);
