with (global.pepctop)
{
	// handle collect
	if (room_get_name(room) == "tower_5" && global.panic)
	{
		if (obj_player.x > 1570 && obj_player.x < 1800 && obj_player.y < 1880 && obj_player.y > 1730 && global.yougotpep == 0)
		{
			with (instance_create(obj_player.x, obj_player.y, obj_exitfollower))
			{
				walkspr = global.spr_CTOPpep_run
				idlespr = global.spr_CTOPpep_panic
				image_speed = 0.7
			}
			audio_play_sound(global.pepcollect, 4, false)
			global.yougotpep = 1
			visible = 0
		}
	}
}

with (obj_player1) 
{
    if (ratmount_movespeed >= 12 && obj_tv.expressionsprite == -4)
        tv_do_expression(global.spr_tv_exprmach3G);
}
if (string_pos("secret", room_get_name(room)) && obj_player1.isgustavo == 0) 
{
    if (obj_tv.expressionsprite == -4) 
    {
        obj_tv.state = (250 << 0);
		tv_do_expression(global.spr_tv_secret);
	}
}

with (obj_tv) {
    if (expressionsprite == global.spr_tv_exprmach3G) {
        with (obj_player1) {
            if (ratmount_movespeed < 12) {
                other.state = (250 << 0);
                other.expressionsprite = -4;
            }
        }
    }
    
    if (expressionsprite == global.spr_tv_secret) {
        if !string_pos("secret", room_get_name(room))
        {
            tv_do_expression(-4);
            state = (250 << 0);
            expressionsprite = -4;
        }
    }
}
with (obj_player) {
    if (sprite_index == spr_taunt && non_set) { 
        image_index = random_range(0, image_number);
    }
    if (state == 84)
        non_set = 0;
    else
        non_set = 1;
}
