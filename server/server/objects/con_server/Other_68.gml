var _type_event = ds_map_find_value(async_load, "type");

switch (_type_event)
{
	case network_type_connect:
		socket = ds_map_find_value(async_load, "socket");
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.player_check_version);
		buffer_write(server_buffer, buffer_bool, false);
		network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
		
		break;
		
	case network_type_disconnect:
		socket = ds_map_find_value(async_load, "socket");
		ds_list_delete(socket_list, ds_list_find_index(socket_list, socket));
		
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_disconnected);
			buffer_write(server_buffer, buffer_u8, socket);
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
			
			_i++;
		}
		var _player = ds_map_find_value(socket_to_instanceid, socket);
		
		var _index = _player.player_num;
		while (_index < 3)
		{
			if (player_list[_index + 1] != noone) {
				player_list[_index] = player_list[_index + 1];
				player_list[_index].player_num = _index;
				player_list[_index + 1] = noone;
			}
			else
			{
				if (player_list[_index] != noone) {
					player_list[_index] = noone;
				}
				break;
			}
			_index++;
		}
		
		con_main_menu.add_to_queue(keyboard_string + "\n     " + _player.username + " disconnected.\n> ", 3);
		
		with (_player)
			instance_destroy();
		
		ds_map_delete(socket_to_instanceid, socket);
		
		for (var _i = 0; _i < 4; _i++)
		{
			for (var _j = 0; _j < 6; _j++)
				global.inputs[_i, _j] = false;
		}
		
		break;
		
	case network_type_data:
		buffer = ds_map_find_value(async_load, "buffer");
		socket = ds_map_find_value(async_load, "id");
		buffer_seek(buffer, buffer_seek_start, 0);
		received_packet(buffer, socket);
		break;
}