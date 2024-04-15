if !has_ended
{
	with (instance_create(x, y, obj_explosioneffect))
	{
		sprite_index = other.sprite_index
		image_index = other.image_index
		image_speed = other.image_speed
		image_xscale = other.image_xscale
	}
}
if (ds_exists(hitlist, ds_type_list) && ds_list_size(hitlist) <= 0)
	notification_push(notifs.player_explosion, [])
