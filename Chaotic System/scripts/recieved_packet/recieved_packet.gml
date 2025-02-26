// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function recieved_packet(_buffer){
	var _msgid = buffer_read(_buffer, buffer_u8);
	
	switch (_msgid)
	{
		case network.player_check_version:
			var _disconnect = buffer_read(_buffer, buffer_bool);
			if (_disconnect)
			{
				network_send_packet(client, client_buffer, buffer_tell(client_buffer));
				room_goto(rm_main_menu);
			}
			else
			{
				buffer_seek(client_buffer, buffer_seek_start, 0);
				buffer_write(client_buffer, buffer_u8, network.player_check_version);
				buffer_write(client_buffer, buffer_string, global.client_version);
				network_send_packet(client, client_buffer, buffer_tell(client_buffer));
			}
			break;
		
		case network.player_establish:
			var _socket = buffer_read(_buffer, buffer_u8);
			
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.player_establish);
			buffer_write(client_buffer, buffer_string, global.username);
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
			
			break;
		
		case network.player_connect:
			var _socket = buffer_read(_buffer, buffer_u8);
			var _x = buffer_read(_buffer, buffer_u16);
			var _y = buffer_read(_buffer, buffer_u16);
			var _username = buffer_read(_buffer, buffer_string);
			var _player_num = buffer_read(_buffer, buffer_u8);
			var _color_num = buffer_read(_buffer, buffer_u8);
			
			var _player = instance_create_layer(_x, _y, "Instances", obj_player);
			_player.socket = _socket;
			_player.username = _username;
			_player.player_num = _player_num;
			_player.color_num = _color_num;
			player_list[_player_num] = _player;
			
			ds_map_add(socket_to_instanceid, _socket, _player);
			break;
			
		case network.player_joined:
			_socket = buffer_read(_buffer, buffer_u8);
			_x = buffer_read(_buffer, buffer_u16);
			_y = buffer_read(_buffer, buffer_u16);
			_username = buffer_read(_buffer, buffer_string);
			var _player_num = buffer_read(_buffer, buffer_u8);
			var _color_num = buffer_read(_buffer, buffer_u8);
			var _show_join_message = buffer_read(_buffer, buffer_bool);
			
			var _child = instance_create_layer(_x, _y, "Instances", obj_child);
			_child.socket = _socket;
			_child.username = _username;
			_child.player_num = _player_num;
			_child.color_num = _color_num;
			_child.image_blend = con_client.couleur[_color_num];
			global.player_colors[_child.player_num] = con_client.couleur[_child.color_num];
			player_list[_player_num] = _child;
			
			if (_show_join_message)
			{
				var _message = instance_create_layer(200, 200 + global.messages * 60, "Instances", con_message);
				_message.msg = _child.username + " joined the game";
				_message.alarm[0] = 120;
				_message.clr = c_yellow;
				_message.xscale = 1.5;
				_message.yscale = 1.5;
				_message.msg_type = "join/dc";
			}
			
			ds_map_add(socket_to_instanceid, _socket, _child);
			break;
			
		case network.player_disconnected:
			var _socket = buffer_read(_buffer, buffer_u8);
			var _child = ds_map_find_value(socket_to_instanceid, _socket);

			var _message = instance_create_layer(200, 200 + global.messages * 60, "Instances", con_message);
			_message.msg = _child.username + " disconnected";
			_message.alarm[0] = 120;
			_message.clr = c_yellow;
			_message.xscale = 1.5;
			_message.yscale = 1.5;
			_message.msg_type = "join/dc";
			global.messages++;
			
			var _index = _child.player_num;
							
			while (_index < 3)
			{
				if (player_list[_index + 1] != noone) {
					player_list[_index] = player_list[_index + 1];
					player_list[_index].player_num = _index;
					player_list[_index + 1] = noone;
					global.player_colors[_index] = con_client.couleur[player_list[_index].color_num];
					global.player_colors[_index + 1] = con_client.couleur[0];
				}
				else
				{
					if (player_list[_index] != noone) {
						player_list[_index] = noone;
						global.player_colors[_index] = con_client.couleur[0];
					}
					break;
				}
				_index++;
			}
			
			with (_child)
				instance_destroy();
				
			ds_map_delete(socket_to_instanceid, _socket);
			
			room_goto(Room1);
			
			break;
		
		case network.move0:
			var _sock = buffer_read(_buffer, buffer_u8);
			var move_x = buffer_read(_buffer, buffer_u16);
			var move_y = buffer_read(_buffer, buffer_u16);
			
			_player = ds_map_find_value(socket_to_instanceid, _sock);
			if (_player != noone)
			{
				_player.x = move_x;
				_player.y = move_y;
			}
			break;
			
		case network.go:
			var _player_type = buffer_read(_buffer, buffer_u8);
			var _room_nbr = buffer_read(_buffer, buffer_string);
			global.number_of_players = _player_type;
			
			switch (_player_type)
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
					global.players = obj_player_2;
					break;
			}
			if (audio_is_playing(mus_menu))
				audio_stop_sound(mus_menu);
			room_goto(asset_get_index(_room_nbr));
			break;
			
		case network.move1:
			
			var _type = buffer_read(_buffer, buffer_string);
			
			if (_type == "parts")
			{
				if (!instance_exists(global.players))
					break;
				var _part_amount = 4;
				if (global.players == obj_player_3)
					_part_amount = 3;
			
				for (var _i = 0; _i < _part_amount; _i++)
				{
					global.part[_i].x = buffer_read(_buffer, buffer_s16);
					global.part[_i].y = buffer_read(_buffer, buffer_s16);
				}
			
				with (global.players)
				{
					var _pos_x = 0;
					var _pos_y = 0;
					for (var _i = 0; _i < _part_amount; _i++)
					{
						_pos_x += global.part[_i].x;
						_pos_y += global.part[_i].y;
					}
					x = _pos_x / _part_amount;
					y = _pos_y / _part_amount;
				}
			}
			else if (_type == "fish")
			{
				var _player_amount = 2;
				if (global.players == 4)
					_player_amount = 4;
				
				if (!instance_exists(obj_fish_game))
					break;
				if (!instance_exists(obj_fish_game.fish[0]))
					break;
				
				if (_player_amount == 2)
				{
					obj_fish_game.fish[0].x = buffer_read(_buffer, buffer_s16);
					obj_fish_game.fish[0].y = buffer_read(_buffer, buffer_s16);
					obj_fish_game.rods[0].hook.x = buffer_read(_buffer, buffer_s16);
					obj_fish_game.rods[0].hook.y = buffer_read(_buffer, buffer_s16);
				}
				else if (_player_amount == 4)
				{
					obj_fish_game.fish[0].x = buffer_read(_buffer, buffer_s16);
					obj_fish_game.fish[0].y = buffer_read(_buffer, buffer_s16);
					obj_fish_game.rods[0].hook.x = buffer_read(_buffer, buffer_s16);
					obj_fish_game.rods[0].hook.y = buffer_read(_buffer, buffer_s16);
					
					obj_fish_game.fish[1].x = buffer_read(_buffer, buffer_s16);
					obj_fish_game.fish[1].y = buffer_read(_buffer, buffer_s16);
					obj_fish_game.rods[1].hook.x = buffer_read(_buffer, buffer_s16);
					obj_fish_game.rods[1].hook.y = buffer_read(_buffer, buffer_s16);
				}
			}
			break;
			
		case network.destroy_player:
			global.death_id = buffer_read(_buffer, buffer_string);
			die();
			
			break;
			
		case network.create_player:
			if (global.number_of_players == 2)
				global.players = obj_player_2;
			else if (global.number_of_players == 3)
				global.players = obj_player_3;
			else if (global.number_of_players == 4)
				global.players = obj_player_4;
			instance_create_layer(global.spawn_x, global.spawn_y, "Instances", global.players);
			if (instance_exists(obj_dropper))
			{
				obj_dropper.sprite_index = spr_dropper_spawn;
			}
			break;
			
		case network.change_color:
			var _num = buffer_read(_buffer, buffer_u8);
			var _player_num = buffer_read(_buffer, buffer_u8);
			
			
			if (player_list[_player_num] != noone)
			{
				player_list[_player_num].image_blend = con_client.couleur[_num];
				player_list[_player_num].color_num = _num;
				global.player_colors[_player_num] = con_client.couleur[_num];
				if (instance_exists(global.players))
					global.players.update_color();
			}
			break;
			
		case network.next_level:
			room_goto_next();
			break;
		
		case network.lightning:
			obj_lightning.alpha = 0;
			break;
		
		case network.dialog:
			var _action = buffer_read(_buffer, buffer_u8);
			switch (_action)
			{
				case dialog_type.create:
					if (global.last_interact_box != noone)
						global.last_interact_box.interact_event();
					else
					{
						global.last_interact_box = instance_nearest(global.players.x, global.players.y, obj_interact_box);
						global.last_interact_box.interact_event();
						show_debug_message("desync on dialog create??");
					}
					break;
				
				case dialog_type.complete:
					obj_dialog.complete_text();
					break;
				
				case dialog_type.next:
					obj_dialog.next_text();
					break;
				
				default:
					break;
			}
			break;
			
		case network.kick:
			var _num = buffer_read(_buffer, buffer_u8);
			
			if (_num == obj_player.player_num)
			{
				show_message("You were kicked.");
				game_end();
			}
			break;
			
		case network.vote_action:
			var _player_num = buffer_read(_buffer, buffer_u8);
			var _action = buffer_read(_buffer, buffer_u8);
			
			var _part_amount = 2;
			if (global.players == obj_player_3)
				_part_amount = 3;
			else if (global.players == obj_player_4)
				_part_amount = 4;
			
			
			var _previous_priority = 3;
			
			if (_action == 0)
			{
				if (global.vote_part[_player_num].pos == 1)
				{
					obj_dialog.vote_right--;
					_previous_priority = global.vote_part[_player_num].priority;
				}
				with (global.vote_part[_player_num])
				{
					y = obj_dialog._y + 150;
					pos = -1;
					x = (camera_get_view_width(view_camera[0]) / 3) + (obj_dialog.vote_left * 32) - 50;
					priority = obj_dialog.vote_left;
				}
				
				for (var _i = 0; _i < _part_amount; _i++)
				{
					with (global.vote_part[_i])
					{
						if (pos == 1)
						{
							if (priority > _previous_priority)
							{
								priority--;
							}
							x = (2 * camera_get_view_width(view_camera[0]) / 3) + (priority * 32) - 50;
						}
					}
				}
				
				obj_dialog.vote_left++;
			}
			else if (_action == 1)
			{
				if (global.vote_part[_player_num].pos == -1)
				{
					obj_dialog.vote_left--;
					_previous_priority = global.vote_part[_player_num].priority;
				}
				with (global.vote_part[_player_num])
				{
					y = obj_dialog._y + 150;
					pos = 1;
					x = (2 * camera_get_view_width(view_camera[0]) / 3) + (obj_dialog.vote_right * 32) - 50;
					priority = obj_dialog.vote_right;
				}
				
				for (var _i = 0; _i < _part_amount; _i++)
				{
					with (global.vote_part[_i])
					{
						if (pos == -1)
						{
							if (priority > _previous_priority)
							{
								priority--;
							}
							x = (camera_get_view_width(view_camera[0]) / 3) + (priority * 32) - 50;
						}
						
					}
				}
				
				obj_dialog.vote_right++;
			}
			else if (_action == 2)
			{
				obj_dialog.lock_ins++;
				with (global.vote_part[_player_num])
				{
					locked_in = true;
					visible = true;
				}
			}
			else if (_action == 3)
			{
				obj_dialog.lock_ins--;
				global.vote_part[_player_num].locked_in = false
			}
			else if (_action == 4)
			{
				var _player_amount = global.number_of_players;
				_player_amount = clamp(_player_amount, 2, 4);
				for (var _i = 0; _i < _player_amount; _i++)
					global.votes[_i] = global.vote_part[_i].pos;
				obj_dialog.alarm[2] = 60;
				obj_dialog.draw_winner = true;
				obj_dialog.choice = _player_num;
				obj_dialog.get_results();
				obj_dialog.draw_choices = false;
			}
			
			break;
			
		case network.popup:
			if (!instance_exists(con_popup))
			{
				if (obj_player.player_num == 0)
					instance_create_layer(0, 0, "Instances", con_popup);
			}
			
			break;
		
		case network.add_player:
			var _player_type = buffer_read(_buffer, buffer_u8);
			var _room_nbr = buffer_read(_buffer, buffer_string);
			global.number_of_players = _player_type;
			
			if (audio_is_playing(mus_menu))
				audio_stop_sound(mus_menu);
			
			if (room == Room1)
			{
				room_goto(asset_get_index(_room_nbr));
				global.manual_spawn = true;
			}
			
			break;
			
		case network.goto_menu:
			if (instance_exists(con_menu))
			{
				with (con_menu)
					instance_destroy();
			}
			room_goto(Room1);
			
			break;
		
		case network.sync_moving:
			with (obj_wall_moving)
			{
				if (abs(y - ystart) > 15)
				{
					var _message = instance_create_layer(200, 200 + global.messages * 60, "Instances", con_message);
					_message.msg = "Moving platforms resynced";
					_message.alarm[0] = 120;
					_message.clr = c_yellow;
					_message.xscale = 1.5;
					_message.yscale = 1.5;
				}
				y = ystart;
				step = 0;
				boost = true;
			}
			
			break;
			
		case network.snail:
			if (!instance_exists(obj_snail))
				break;
			
			var snail_type = buffer_read(_buffer, buffer_u8);
			switch (snail_type)
			{
				case snail_action.move:
					var _turn = buffer_read(_buffer, buffer_bool);
					obj_snail.move_snail(_turn);
					break;
				
				case snail_action.detect_player:
					var _dist = buffer_read(_buffer, buffer_f16);
					var _player_num = buffer_read(_buffer, buffer_u8);
					var _ajout = buffer_read(_buffer, buffer_u8);
					obj_snail.detect(_dist, _player_num);
					obj_snail.exposed_frames += _ajout;
					break;
					
				case snail_action.shoot:
					var _x = buffer_read(_buffer, buffer_f16);
					var _y = buffer_read(_buffer, buffer_f16);
					var _exposed_frames = buffer_read(_buffer, buffer_u8);
					
					obj_snail.shoot_snail(_x, _y, _exposed_frames);
					break;
				
				case snail_action.reset:
					obj_snail.reset_state();
					break;
					
				default:
					break;
			}
			
			break;
		
		case network.fishing:
			var _action_id = buffer_read(_buffer, buffer_u8);
			switch (_action_id)
			{
				case fish_action.make_teams:
					var _team_size = buffer_read(_buffer, buffer_u8);
					var _team_string = buffer_read(_buffer, buffer_string);
					var _fishers = buffer_read(_buffer, buffer_u8);
					
					obj_fish_game.team_0[0] = real(string_char_at(_team_string, 1));
					if (_team_size == 1)
						obj_fish_game.team_1[0] = string_char_at(_team_string, 2);
					else if (_team_size == 2)
					{
						obj_fish_game.team_0[1] = string_char_at(_team_string, 2);
						obj_fish_game.team_1[0] = string_char_at(_team_string, 3);
						obj_fish_game.team_1[1] = string_char_at(_team_string, 4);
					}
					
					obj_fish_game.create_players(_fishers);
					break;
					
				case fish_action.battle:
					
					var _fisher_num = buffer_read(_buffer, buffer_u8);
					var _fish_num = buffer_read(_buffer, buffer_u8);
					
					with (obj_fish_game)
					{
						controllers[_fish_num].cant_grab = true;
						controllers[_fisher_num].cant_grab = true;
						
						controllers[_fisher_num].rod.sprite_index = spr_fishing_rod;
					}
					
					break;
				
				case fish_action.catch_fish:
					var _fisher_num = buffer_read(_buffer, buffer_u8);
					var _fish_num = buffer_read(_buffer, buffer_u8);
					
					with (obj_fish_game)
					{
						controllers[_fish_num].cant_grab = false;
						controllers[_fisher_num].cant_grab = false;
					}
					break;
					
				case fish_action.release:
					var _fisher_num = buffer_read(_buffer, buffer_u8);
					var _fish_num = buffer_read(_buffer, buffer_u8);
					
					with (obj_fish_game)
					{
						controllers[_fish_num].cant_grab = false;
						controllers[_fish_num].temp_cant_grab = true;
						controllers[_fish_num].alarm[0] = 15;
						controllers[_fish_num].alarm[1] = 120;
						controllers[_fisher_num].cant_grab = false;
						
						controllers[_fisher_num].rod.sprite_index = spr_fishing_rod_tension;
					}
					break;
				
				case fish_action.finish_fish:
					
					room_goto(test_room);
					global.winner = buffer_read(_buffer, buffer_u8);
					break;
				
				case fish_action.reel_action:
					
					var _reel_action = buffer_read(_buffer, buffer_u8);
					var _fisher_num = buffer_read(_buffer, buffer_u8);
					
					if (_reel_action == 0) // change reel pos
					{
						var _new_pos = buffer_read(_buffer , buffer_u8);
						obj_fish_game.controllers[_fisher_num].reeling_pos = _new_pos;
					}
				
				default:
					break;
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
			break;
		
		case network.rm_event:
			var _talk = buffer_read(_buffer, buffer_u8);
			
			if (room == room_1)
				obj_event_rm1.get_messages(_talk);
			
			break;
		
		default:
			break;
	}
}