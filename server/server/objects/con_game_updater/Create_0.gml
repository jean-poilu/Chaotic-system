tank_list = ds_list_create();
list_size = ds_list_size(con_server.socket_list);

function add_tank(_tank) {
	ds_list_add(tank_list, _tank);
}

function send_tank_instances() {
	with (con_server)
	{
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
			
			var _j = 0;
			
			repeat(ds_list_size(socket_list))
			{
			
				var _tank = ds_list_find_value(con_game_updater.tank_list, _j);
				var _x = _tank.x;
				var _y = _tank.y;
			
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.create_tanks);
				buffer_write(server_buffer, buffer_u8, _j);
				buffer_write(server_buffer, buffer_s16, _x);
				buffer_write(server_buffer, buffer_s16, _y);
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_j++;
			}
			
			_i++;
		}
		
	}
}

function send_single_tank_instance(_tank) {
	with (con_server)
	{
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
			
			var _x = _tank.x;
			var _y = _tank.y;
			var _player_num = _tank.player_num;
			
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.create_tanks);
			buffer_write(server_buffer, buffer_u8, _player_num);
			buffer_write(server_buffer, buffer_s16, _x);
			buffer_write(server_buffer, buffer_s16, _y);
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
			
			_i++;
		}
		
	}
}