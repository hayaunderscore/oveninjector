draw_sprite(spr_noiseunlocked_bg, 0, x, y);
draw_self();
draw_set_alpha(fade);
draw_rectangle_color(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
