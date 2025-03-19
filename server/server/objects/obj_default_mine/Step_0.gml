if (exploding)
	return;

if (!instance_exists(obj_tank))
	return;


var _nearest = point_distance(x, y, instance_nearest(x, y, obj_tank).x, instance_nearest(x, y, obj_tank).y);

if (initial_wait && _nearest > 135) {
	
	initial_wait = false;
	
	var _mine_num = ds_list_find_index(obj_mine_parent.mine_id_list, id);
	
	var _args = [network.explode_mine, 0, _mine_num];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_u8];
	network_send(_args, _buffer_args);
	
	sprite_index = spr_mine_primed;
	
}
else if (!initial_wait && _nearest < 120) {
	explode();
}