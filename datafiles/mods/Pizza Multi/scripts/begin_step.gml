if (!instance_exists(obj_player)) exit;
function add_obj(obj) {
	with (obj)
		array_push(other.obj_arr, [self, (obj == obj_baddie)])
}

obj_arr = [];
for (var i = 0; i < array_length(objects); i++) {
	add_obj(objects[i]);
}