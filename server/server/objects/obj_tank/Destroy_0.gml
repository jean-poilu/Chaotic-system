var _player_num = player_num;

with (con_server)
{
	var _i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _i);
				
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.destroy_player);
		buffer_write(server_buffer, buffer_u8, _player_num);
		
		
		network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
		_i++;
	}
}

var _index = ds_list_find_index(con_game_updater.tank_list, id);

ds_list_delete(con_game_updater.tank_list, _index);

obj_tank_creator.respawn_tank(id);

with (nozzle)
	instance_destroy();
