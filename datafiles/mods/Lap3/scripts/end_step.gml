if obj_pause.pause
	return;

if (obj_player1.targetDoor == "HUB" || room == rank_room || room == timesuproom) {
	live_snippet_call(reset_lap3);
}
		
with (obj_lap2visual) {
	if (global.lap3) sprite_index = global.spr_tllap3;
}
		
with (obj_lapportal) {
	if (sprite_index == spr_pizzaportalend && image_index <= image_speed) {
		if (global.lap && !global.lap3) {
			with (playerid) {
				global.collect += 3000;
				global.combotime = 60;
				number = "6000";
				with (obj_smallnumber) {
					if (number == "3000") number = "6000";
				}
			}
			global.laps += 1;
			global.lap3 = 2;
			scr_play_external_music(global.mu_tllap3);
		} else if (!global.lap) {
			var ind = ds_list_find_index(global.saveroom, id);
			if (ind != -1) ds_list_delete(global.saveroom, ind);			
		}
	}
}
		
with (obj_lapportalentrance) {
	if (global.lap3 && !active) {
		global.fill = 0;
		if (room == war_lap && !instance_exists(obj_pizzaface))
		{
			instance_create_unique(obj_player1.x, obj_player1.y, obj_pizzaface)
			fmod_event_one_shot("event:/sfx/pizzaface/laugh")
		}
	}
}
		
with (obj_tv) {
	if (global.panic && global.lap3 && sprite_index == spr_tv_exprpanic) {
		sprite_index = spr_tv_exprheat;
		image_index = current_time / 1000 * 60 * 0.35;
	}
}
		
with (obj_rank) {
	if (global.rank == "p" || global.rank == "s") && global.lap3 {
		sprite_index = global.spr_tlrankLAPPED;
	}
}
		
with (obj_startgate) {
	if (pizza) {
		with (obj_startgate_pizza) {
			if (x == other.x && abs(y_to - (other.y - 125)) < 3) {
				gate = other.id;
				other.pizza = 2;
				ini_open_from_string(obj_savesystem.ini_str);
				lap3 = ini_read_real("Game", (string(other.level) + "6"), 0);
				ini_close();
			}
		}
	}
}