with (con_server)
{
	var _i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _i);
				
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.move1);
		
		for (var _j = 0; _j < ds_list_size(con_game_updater.tank_list); _j++) {
			var _tank = ds_list_find_value(con_game_updater.tank_list, _j);
			
			buffer_write(server_buffer, buffer_f16, _tank.x);
			buffer_write(server_buffer, buffer_f16, _tank.y);
			buffer_write(server_buffer, buffer_s16, _tank.direction);
			buffer_write(server_buffer, buffer_s16, _tank.nozzle.image_angle);
			buffer_write(server_buffer, buffer_u8, _tank.player_num);
			
		}
		
		network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
		_i++;
	}
}