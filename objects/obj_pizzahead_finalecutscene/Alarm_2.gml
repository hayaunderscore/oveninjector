layer_set_visible("Backgrounds_tower1", false);
layer_set_visible("Backgrounds_tower2", false);
layer_set_visible("Backgrounds_tower3", false);
layer_set_visible("Backgrounds_tower4", false);
layer_set_visible("Backgrounds_tower5", false);
layer_set_visible("Backgrounds_towermeteor", false);
layer_vspeed("Backgrounds_towermeteor", 0);
sprite_index = bg_piledrivercloseshot;
image_speed = 1;
x = 0;
y = 0;
fmod_event_instance_set_parameter(snd, "state", 2, true);
piledrivershot = true;
alarm[1] = 200;