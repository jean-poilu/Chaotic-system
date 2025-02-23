// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function network_player_connect(_username){
	var _player = instance_create_layer(room_width / 2, room_height / 2, "Instances", obj_player);
	_player.username = _username;
	
	var _index = 0;
	for (_index = 0; _index < 4; _index++)
	{
		if (player_list[_index] == noone) {
			player_list[_index] = _player;
			break;
		}
	}
	_player.player_num = _index;
	ds_map_add(socket_to_instanceid, socket, _player);
		
	buffer_seek(server_buffer, buffer_seek_start, 0);
	buffer_write(server_buffer, buffer_u8, network.player_connect);
	buffer_write(server_buffer, buffer_u8, socket);
	buffer_write(server_buffer, buffer_u16, _player.x);
	buffer_write(server_buffer, buffer_u16, _player.y);
	buffer_write(server_buffer, buffer_string, _player.username);
	buffer_write(server_buffer, buffer_u8, _player.player_num);
	buffer_write(server_buffer, buffer_u8, _player.color_num);
	network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
	
	var _j = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _j);
		if (_sock != socket)
		{
			var _child = ds_map_find_value(socket_to_instanceid, _sock);
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_joined);
			buffer_write(server_buffer, buffer_u8, _sock);
			buffer_write(server_buffer, buffer_u16, _child.x);
			buffer_write(server_buffer, buffer_u16, _child.y);
			buffer_write(server_buffer, buffer_string, _child.username);
			buffer_write(server_buffer, buffer_u8, _child.player_num);
			buffer_write(server_buffer, buffer_u8, _child.color_num);
			buffer_write(server_buffer, buffer_bool, false);
			network_send_packet(socket, server_buffer, buffer_tell(server_buffer));
		}
		_j++;
	}
		
	var _i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _i);
		if (_sock != socket)
		{
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.player_joined);
			buffer_write(server_buffer, buffer_u8, socket);
			buffer_write(server_buffer, buffer_u16, _player.x);
			buffer_write(server_buffer, buffer_u16, _player.y);
			buffer_write(server_buffer, buffer_string, _player.username);
			buffer_write(server_buffer, buffer_u8, _player.player_num);
			buffer_write(server_buffer, buffer_u8, _player.color_num);
			buffer_write(server_buffer, buffer_bool, true);
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
		}
		_i++;
	}
	
	return _player;
}