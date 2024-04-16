if global.laps >= 1 {
    var expr = global.spr_tv_slap2;
    if global.laps >= 2
        expr = global.spr_tv_slap3;
    if (obj_player1.isgustavo)
    {
        if variable_global_exists(sprite_get_name(expr) + "G")
            expr = variable_global_get(sprite_get_name(expr) + "G")
    }
    with (obj_tv)
    {
        if (global.panic && (sprite_index == spr_tv_exprpanic || sprite_index == spr_tv_exprheat)) {
            if !global.lap2expression
            {
                state = (250 << 0);
                global.lap2expression = true;
            }
            sprite_index = expr;
            image_index = current_time / 1000 * 60 * 0.35;
        }
    }
} 
else
{
    global.lap2expression = false;
}