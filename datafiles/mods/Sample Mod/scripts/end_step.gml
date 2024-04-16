if (!instance_exists(obj_player)) exit;
function step_obj(obj, isbaddie) {
	if (instance_exists(obj.id)) return;
	var oi = obj.object_index;
	if !(oi != obj_pepperman && oi != obj_vigilanteboss && oi != obj_noiseboss && oi != obj_pizzafaceboss) return;
	if (oi == obj_noisey && !instance_exists(obj_noiseboss)) return;
	var w = obj.bbox_right - obj.bbox_left;
	if (obj.object_index == obj_pizzaboxunopen)
		w = 48;
	else if (isbaddie)
		w = 0;
	var newobj = instance_create(
		obj.x + w * obj_player.xscale,
		obj.y,
		obj.object_index
	);
	newobj.depth = obj.depth;
	if (isbaddie) {
		with (newobj) {
			hsp = obj.hithsp;
			vsp = obj.hitvsp;
			stunned = 200;
			state = (138 << 0);
		}
	}
	if (obj.object_index == obj_pizzaboxunopen) {
		newobj.content = obj.content;
	}
};

for (var i = 0; i < array_length(obj_arr); i++) {
	step_obj(obj_arr[i][0], obj_arr[i][1]);
}