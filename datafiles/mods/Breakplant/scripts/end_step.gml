with (obj_player) {
    // sprites
    var _spr_breakdanceattack = variable_instance_exists(self.id, "spr_breakdanceattack") ? spr_breakdanceattack : spr_player_breakdance;

    var _spr_breakdanceattackstart = spr_player_breakdancestart;
    var _spr_buttattackstart = spr_player_buttattackstart;
    var _spr_buttattack = spr_player_buttattack;
    var _spr_buttattackend = spr_player_buttattackend;
    var _spr_faceplant = spr_player_faceplant;

    // breakdance trigger
    var bd_state = "breakdance";
    if (character != "V") {
        if (state == player_normal || state == player_jump || state == player_mach2 || state == player_mach3) && key_shoot2 && other.enable_breakdance {
            state = bd_state;
            grounded = false;
            sprite_index = _spr_breakdanceattackstart;
            with (instance_create(x, y, obj_dashcloud2)) image_xscale = other.xscale;
            
            breakdance = 35;
            image_index = 0;
            instance_create(x, y, obj_swingdinghitbox);
            
            fmod_event_one_shot_3d("event:/sfx/misc/breakdance", obj_player1.x, obj_player1.y);
        }
    }
    
    // breakdance state
    if (state == bd_state && (sprite_index == spr_breakdancesuper || sprite_index == _spr_breakdanceattack || sprite_index == _spr_breakdanceattackstart || sprite_index == _spr_buttattackstart || sprite_index == _spr_buttattack || sprite_index == _spr_buttattackend)) {
        // afterimages
        boxxeddash = 1;
        
        hsp = (xscale * movespeed);
        move = (key_left + key_right);
        jumpstop = 0;
        if (sprite_index == spr_breakdancesuper && key_shoot2)
            movespeed = 14;
        
        if (movespeed < 9 && (sprite_index == _spr_breakdanceattack || sprite_index == _spr_breakdanceattackstart)) movespeed = Approach(movespeed, 9, 4);
        if (movespeed > 0 && sprite_index == spr_breakdancesuper)
            movespeed -= 0.25;
        
        if (floor(image_index) == (image_number - 1) && sprite_index == _spr_breakdanceattackstart) sprite_index = _spr_breakdanceattack;
        
        if (key_shoot2 && (sprite_index == _spr_breakdanceattack || sprite_index == _spr_breakdanceattackstart)) {
            image_index = 0;
            sprite_index = _spr_buttattackstart;
            movespeed = max(movespeed, 16);
            vsp = -5;
            if (!instance_exists(crazyruneffectid)) {
                with (instance_create(x, y, obj_crazyrunothereffect)) {
                    playerid = other.object_index;
                    other.crazyruneffectid = id;
                }
            }
        }
        if (floor(image_index) == (image_number - 1) && sprite_index == _spr_buttattackstart) sprite_index = _spr_buttattack;
        
        if (grounded && sprite_index == _spr_buttattack)
            sprite_index = _spr_buttattackend;
        
        if (sprite_index == _spr_buttattackend)
            movespeed -= 0.25;
        
        if (key_down2 && (sprite_index == _spr_breakdanceattack || sprite_index == _spr_breakdanceattackstart)) {
            sprite_index = spr_breakdancesuper;
            movespeed = 12;
        }
        if (breakdance > 0)
            breakdance--;
        
        landAnim = 0;
        if (movespeed <= 0 && (sprite_index == spr_breakdancesuper || sprite_index == _spr_buttattackend)) state = player_normal;
        
        if (breakdance <= 0 && sprite_index == _spr_breakdanceattack)
            state = player_normal;
        
        if (place_meeting((x + xscale), y, obj_solid) && sprite_index == spr_breakdancesuper) xscale *= -1;
        
        if (sprite_index == spr_breakdancesuper)
            image_speed = (movespeed / 24);
        else
            image_speed = 0.4;
        if (sprite_index == _spr_buttattack || sprite_index == _spr_buttattackstart || sprite_index == _spr_buttattackend) {
            if (scr_solid((x + 1), y) && xscale == 1 && (!(place_meeting((x + sign(hsp)), y, obj_slope))) && (!(place_meeting((x + xscale), y, obj_destructibles)))) {
                vsp = -4;
                sprite_index = spr_player_kungfujump;
                image_index = 0;
                state = player_punch;
                movespeed = -6;
                instance_create((x + 10), (y + 10), obj_bumpeffect);
            }
            if (scr_solid((x - 1), y) && xscale == -1 && (!(place_meeting((x + sign(hsp)), y, obj_slope))) && (!(place_meeting((x + xscale), y, obj_destructibles)))) {
                vsp = -4;
                sprite_index = spr_player_kungfujump;
                image_index = 0;
                state = player_punch;
                movespeed = -6;
                instance_create((x - 10), (y + 10), obj_bumpeffect);
            }
        }
        if (key_attack2) {
            state = player_mach2;
            if (grounded)
                sprite_index = spr_mach;
            else
                sprite_index = spr_secondjump2;
            image_index = 0;
            jumpstop = 1;
        }
        if ((!instance_exists(obj_dashcloud2)) && grounded && movespeed > 5) {
            with (instance_create(x, y, obj_dashcloud2)) image_xscale = other.xscale;
        }
        if (place_meeting(x + xscale, y, obj_solid) && !place_meeting(x + xscale, y, obj_destructibles) && (sprite_index == _spr_breakdanceattackstart || sprite_index == _spr_breakdanceattack)) {
            movespeed = 0;
            sprite_index = spr_player_wallsplat;
            vsp = 0;
            hsp = 0;
            state = player_bump;
            image_index = 0;
        }
        // enemy killing/block destroying
        ghostdash = 1;
    }
    if (state != bd_state && breakplant_prevstate == bd_state) ghostdash = 0;
    
    // faceplant trigger
    var fp_state = "faceplant";
    if (state == player_handstandjump && key_slap2 && other.enable_faceplant && breakplant_prevstate == player_handstandjump) {
        state = fp_state;
        sprite_index = _spr_faceplant;
        image_index = 0;
        
        movespeed += 2;
        if (!grounded) {
            vsp = -5;
        }
    }
    
    // faceplant state
    if (state == fp_state) {
        hsp = xscale * movespeed;
        move = key_right + key_left;
        
        if (movespeed < 5) movespeed = 5;
        
        if (place_meeting((x + hsp), y, obj_solid) && (!(place_meeting((x + hsp), y, obj_slope))) && (!(place_meeting((x + hsp), y, obj_destructibles)))) {
            var _bump = ledge_bump(vsp >= 0 ? 25 : 16);
            if (_bump) {
                sprite_index = spr_hitwall;
                with (obj_camera) {
                    shake_mag = 10;
                    shake_mag_acc = 20 / room_speed;
                }
                hsp = 0;
                image_speed = 0.35;
                with (obj_baddie) {
                    if (shakestun && point_in_camera(x, y, view_camera[0]) && grounded) {
                        stun = 1;
                        alarm[0] = 200;
                        ministun = 0;
                        vsp = -5;
                        hsp = 0;
                    }
                }
                sprite_index = spr_hitwall;
                fmod_event_one_shot_3d("event:/sfx/pep/groundpound", x, y);
                fmod_event_one_shot_3d("event:/sfx/pep/bumpwall", x, y);
                hsp = 0;
                flash = 0;
                state = player_bump;
                hsp = clamp(movespeed / 3, 3, 15) * -xscale;
                vsp = -3;
                mach2 = 0;
                image_index = 0;
                instance_create(x + xscale * 15, y + 10, obj_bumpeffect);
            }
        }
        if (floor(image_index) == (image_number - 1) && (!key_attack)) {
            image_speed = 0.35;
            state = player_normal;
        }
        if (floor(image_index) == (image_number - 1) && key_attack) {
            image_speed = 0.35;
            state = player_mach2;
        }
        if (!instance_exists(obj_dashcloud2) && grounded && movespeed > 5) {
            with (instance_create(x, y, obj_dashcloud2)) image_xscale = other.xscale;
        }
        image_speed = 0.5;
        ghostdash = 1;
    }
    if (state != fp_state && breakplant_prevstate == fp_state) ghostdash = 0;
    
    breakplant_prevstate = state;
}
