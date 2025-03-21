tank_list = ds_list_create();
list_size = ds_list_size(con_server.socket_list);

function add_tank(_tank) {
	ds_list_add(tank_list, _tank);
}

function send_tank_instances() {
	var _j = 0;
	repeat(ds_list_size(tank_list))
	{
		var _tank = ds_list_find_value(tank_list, _j);
		var _x = _tank.x;
		var _y = _tank.y;
		
		var _args = [network.create_tanks, _j, _x, _y];
		var _buffer_args = [buffer_u8, buffer_u8, buffer_s16, buffer_s16];
		network_send(_args, _buffer_args);
	
		_j++;
	}
}

function send_single_tank_instance(_tank) {
	var _x = _tank.x;
	var _y = _tank.y;
	var _player_num = _tank.player_num;
	
	var _args = [network.create_tanks, _player_num, _x, _y];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_s16, buffer_s16];
	network_send(_args, _buffer_args);
}

function check_round_end() {
	if (ds_list_size(tank_list) == 1) {
		var _args = [network.end_round];
		var _buffer_args = [buffer_u8];
		network_send(_args, _buffer_args);
		
		room_goto(rm_shop);
	}
}