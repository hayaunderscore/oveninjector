with (obj_lapportal) {
	if (global.lap && !visible) {
		if (sprite_index != spr_pizzaportal) {
			shader_set(global.Pal_Shader);
			pattern_set(global.Base_Pattern_Color, sprite_index, image_index, image_xscale, image_yscale, global.palettetexture);
			pal_swap_set(obj_player1.spr_palette, obj_player1.paletteselect, 0);
			draw_self();
			pattern_reset();
			shader_reset();
		} else if (global.lap) {
			draw_self();
			draw_sprite(global.spr_tllap3warning, 0, x, (y + Wave(-5, 5, 0.5, 5)));
		} else {
			draw_self();
			draw_sprite(spr_lap2warning, 0, x, (y + Wave(-5, 5, 0.5, 5)));
		}
	}
}
with (obj_startgate_pizza) {
	if (variable_instance_exists(self, "gate") && gate.level != "exit" && state > (0 << 0)) {
		draw_sprite_ext(global.spr_tllap3_hud, lap3 == 2, (x + 60), (y + 58), rank_scale, rank_scale, 0, c_white, 1);
	}
}