// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function received_packet(_buffer, _socket){
	var _msgid = buffer_read(_buffer, buffer_u8);
	
	switch(_msgid)
	{
		case network.player_check_version:
			var _client_version = buffer_read(_buffer, buffer_string);
			if (_client_version == global.server_version)
			{
				ds_list_add(socket_list, _socket);
		
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.player_establish);
				buffer_write(server_buffer, buffer_u8, _socket);
				network_send_packet(_socket, server_buffer, buffer_tell(server_buffer));
		
				var _map = ds_map_create();
				ds_map_add_list(_map, "socket list", socket_list);
				show_debug_message(json_encode(_map));
			}
			else
			{
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.player_check_version);
				buffer_write(server_buffer, buffer_bool, true);
				buffer_write(server_buffer, buffer_string, global.server_version);
				network_send_packet(_socket, server_buffer, buffer_tell(server_buffer));
				network_destroy(_socket);
			}
			break;
			
		case network.player_establish:
			var _username = buffer_read(_buffer, buffer_string);
			var _player = network_player_connect(_username);
			_player.socket = _socket;
			
			con_main_menu.add_to_queue(keyboard_string + "\n     " + _username + " joined the lobby.\n> ", 3);
			
			keyboard_string = "";
			
			con_main_menu.line_num += 2;
			
			con_main_menu.add_to_queue("GOTO LOBBY", 1);
			
			break;
			
		case network.move0:
			var move_x = buffer_read(_buffer, buffer_u16);
			var move_y = buffer_read(_buffer, buffer_u16);
			
			var _player = ds_map_find_value(socket_to_instanceid, _socket);
			_player.x = move_x;
			_player.y = move_y;
			
			var _i = 0;
			repeat(ds_list_size(socket_list))
			{
				var _sock = ds_list_find_value(socket_list, _i);
				
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.move0);
				buffer_write(server_buffer, buffer_u8, _socket);
				buffer_write(server_buffer, buffer_u16, move_x);
				buffer_write(server_buffer, buffer_u16, move_y);
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_i++;
			}
			break;
			
		case network.go:
			if (ds_list_size(socket_list) > 1)
			{
				switch (ds_list_size(socket_list))
				{
					case 2:
						global.players = obj_player_2;
						break;
					case 3:
						global.players = obj_player_3;
						break;
					case 4:
						global.players = obj_player_4;
						break;
					default:
						break;
				}
				var _i = 0;
				repeat(ds_list_size(socket_list))
				{
					var _sock = ds_list_find_value(socket_list, _i);
				
					buffer_seek(server_buffer, buffer_seek_start, 0);
					buffer_write(server_buffer, buffer_u8, network.go);
					buffer_write(server_buffer, buffer_u8, ds_list_size(socket_list));
					buffer_write(server_buffer, buffer_string, room_get_name(global.saved_room));
					
					network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
					_i++;
				}
				room_goto(global.saved_room);
			}
			else
			{
				var _message = instance_create_layer(room_width / 2, 100, "Instances", con_message);
				_message.msg = "Not enough players to start the game!";
				_message.clr = c_red;
				_message.alarm[0] = 60;
				_message.xscale = 2;
				_message.yscale = 2;
				_message.msg_type = "other";
				_message.center = true;
				
				if (ds_list_size(socket_list) == 1)
				{
					global.players = obj_player_2;
					var _i = 0;
					repeat(ds_list_size(socket_list))
					{
						var _sock = ds_list_find_value(socket_list, _i);
				
						buffer_seek(server_buffer, buffer_seek_start, 0);
						buffer_write(server_buffer, buffer_u8, network.go);
						buffer_write(server_buffer, buffer_u8, ds_list_size(socket_list));
						buffer_write(server_buffer, buffer_string, room_get_name(global.saved_room));
						network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
						_i++;
					}
					room_goto(global.saved_room);
				}
			}
			break;
			
		case network.inputs:
			var _move = buffer_read(_buffer, buffer_u8);
			var _player_num = buffer_read(_buffer, buffer_u8);
			global.inputs[_player_num, _move] = !global.inputs[_player_num, _move];
			
			break;
			
		case network.change_color:
			var _num = buffer_read(_buffer, buffer_u8);
			var _player_num = buffer_read(_buffer, buffer_u8);
			
			player_list[_player_num].image_blend = con_server.couleur[_num];
			player_list[_player_num].color_num = _num;
			global.player_colors[_player_num] = con_server.couleur[_num];
			
			var _i = 0;
			repeat(ds_list_size(socket_list))
			{
				var _sock = ds_list_find_value(socket_list, _i);
				
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.change_color);
				buffer_write(server_buffer, buffer_u8, _num);
				buffer_write(server_buffer, buffer_u8, _player_num);
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_i++;
			}
			if (instance_exists(global.players))
				global.players.update_color();
			
			break;
			
		case network.kick:
			var _num = buffer_read(_buffer, buffer_u8);
			
			var _i = 0;
			repeat(ds_list_size(socket_list))
			{
				var _sock = ds_list_find_value(socket_list, _i);
				
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.kick);
				buffer_write(server_buffer, buffer_u8, _num);
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_i++;
			}
			break;
			
		case network.change_variable:
			var _variable = buffer_read(_buffer, buffer_string);
			var _value = buffer_read(_buffer, buffer_f16);
			
			switch (_variable)
			{
				case 0:
					global.gravity_speed = _value;
					break;
				
				case 1:
					global.elasticity = _value;
					break;
					
				case 2:
					global.jump_speed = _value;
					break;
					
				case 3:
					global.energy_loss = _value;
					break;
					
				case 4:
					global.movement_speed = _value;
					break;
				
				case 5:
					global.top_speed = _value;
					break;
				
				case 6:
					global.trampoline_value = _value;
					break;
				
				case 7:
					global.deaths = _value;
					break;
				
				case 8:
					global.gravity_speed = global.default_grav;
					global.elasticity = global.default_elas;
					global.jump_speed = global.default_j_s;
					global.energy_loss = global.default_e_l;
					global.top_speed = global.default_t_s;
					global.movement_speed = global.default_m_s;
					global.trampoline_value = global.default_t_v;
					global.deaths = 0;
					break;
				
				default:
					break;
			}
			
			var _i = 0;
			repeat(ds_list_size(socket_list))
			{
				var _sock = ds_list_find_value(socket_list, _i);
				
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.change_variable);
				buffer_write(server_buffer, buffer_string, _variable);
				buffer_write(server_buffer, buffer_f16, _value);
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_i++;
			}
			
			break;
		
		case network.add_player:
			var _x = global.players.x;
			var _y = global.players.y;
			
			var _i = 0;
			repeat(ds_list_size(socket_list))
			{
				var _sock = ds_list_find_value(socket_list, _i);
				
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.add_player);
				buffer_write(server_buffer, buffer_u8, ds_list_size(socket_list));
				buffer_write(server_buffer, buffer_string, room_get_name(global.saved_room));
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_i++;
			}
			
			die();
			
			if (ds_list_size(socket_list) == 2)
				global.players = obj_player_2;
			else if (ds_list_size(socket_list) == 3)
				global.players = obj_player_3;
			else if (ds_list_size(socket_list) == 4)
				global.players = obj_player_4;
			
			obj_death.die_at = 4;
			if (global.players == 3)
				obj_death.die_at = 3;
			
			break;
		
		case network.goto_menu:
			room_goto(Room1);
			
			var _i = 0;
			repeat(ds_list_size(socket_list))
			{
				var _sock = ds_list_find_value(socket_list, _i);
				
				buffer_seek(server_buffer, buffer_seek_start, 0);
				buffer_write(server_buffer, buffer_u8, network.goto_menu);
				network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
				_i++;
			}
			
			break;
			
		default:
			break;
	}
	
}

