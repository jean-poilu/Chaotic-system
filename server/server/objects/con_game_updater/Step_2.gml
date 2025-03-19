var _args = [network.move1];
var _buffer_args = [buffer_u8];

for (var _j = 0; _j < ds_list_size(tank_list); _j++) {
	var _tank = ds_list_find_value(tank_list, _j);
	
	array_push(_args, _tank.x, _tank.y, _tank.direction, _tank.nozzle.image_angle, _tank.player_num);
	
	array_push(_buffer_args, buffer_f16, buffer_f16, buffer_s16, buffer_s16, buffer_u8);
}

network_send(_args, _buffer_args);