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
				global.player_colors[_index] = con_server.couleur[player_list[_index].color_num];
				global.player_colors[_index + 1] = con_server.couleur[0];
			}
			else
			{
				if (player_list[_index] != noone) {
					player_list[_index] = noone;
					global.player_colors[_index] = con_server.couleur[0];
				}
				break;
			}
			_index++;
		}
		
		var _message = instance_create_layer(100, 200 + global.messages * 60, "Instances", con_message);
		_message.msg = _player.username + " disconnected";
		_message.alarm[0] = 120;
		_message.clr = c_yellow;
		_message.xscale = 1.5;
		_message.yscale = 1.5;
		_message.msg_type = "join/dc";
		global.messages++;
		
		with (_player)
			instance_destroy();
		
		ds_map_delete(socket_to_instanceid, socket);
		
		for (var _i = 0; _i < 4; _i++)
		{
			for (var _j = 0; _j < 6; _j++)
				global.inputs[_i, _j] = false;
		}
		
		room_goto(Room1);
		
		break;
		
	case network_type_data:
		buffer = ds_map_find_value(async_load, "buffer");
		socket = ds_map_find_value(async_load, "id");
		buffer_seek(buffer, buffer_seek_start, 0);
		received_packet(buffer, socket);
		break;
}