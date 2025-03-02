if (!is_drawing && display_terminal)
{
	audio_play_sound(snd_bong_001, 0, 0);
	if (keyboard_string != "" && !responding) {
		for (var _i = 8; _i > 0; _i--)
		{
			last_commands[_i + 1] = last_commands[_i];
		}
		last_commands[1] = keyboard_string;
		last_commands_at = 0;
	}


	if (responding)
	{
		switch (response_to)
		{
			case "kicking":
				
				past_string += keyboard_string + "\n";
				
				var _found_player = false;
				for (var _i = 0; _i < 4; _i++) {
					if (con_server.player_list[_i] == noone)
						break;
					if (keyboard_string == con_server.player_list[_i].username) {
						_found_player = true;
						
						with (con_server)
						{
							var _j = 0;
							repeat(ds_list_size(socket_list))
							{
								var _sock = ds_list_find_value(socket_list, _j);
				
								buffer_seek(server_buffer, buffer_seek_start, 0);
								buffer_write(server_buffer, buffer_u8, network.kick);
								buffer_write(server_buffer, buffer_u8, _i);
								network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
								_j++;
							}
						}
						
						
					}
				}
				
				if (_found_player) {
					past_string += keyboard_string + " has been disconnected.\n"
					line_num += 1;
				}
				else
					past_string += keyboard_string + " not found in player list.\n"
				
				past_string += "> ";
					
				response_to = "";
				responding = false;
				
				keyboard_string = "";
				
				line_num += 2;
				
				break;
			
			default:
				break;
		}
	}
	else
	{

		switch (keyboard_string)
		{
			case "":
				past_string += "\n> ";
			
				line_num += 1;
			
				break;
	
			case "help":
				past_string += keyboard_string + "\n";
				
				add_to_queue("\n", 2);
				add_to_queue("List of available commands:\n", 2);
				add_to_queue("     kick - Kick a player\n", 1);
				add_to_queue("     list - Lists connected players\n", 1);
				add_to_queue("     cls - Clear screen\n", 1);
				add_to_queue("     quit - Quit game\n", 1);
				add_to_queue("\n", 1);
				add_to_queue("> ", 1);
				
				keyboard_string = "";
			
				break;
			
			case "kick":
				past_string += keyboard_string + "\nEnter username: ";
				
				keyboard_string = "";
				
				responding = true;
				response_to = "kicking";
				
				line_num += 1;
				
				break;
			
			case "list":
				past_string += keyboard_string + "\n";
				
				add_to_queue("\n", 2);
				add_to_queue("List of connected players:\n", 2);
				add_to_queue("\n", 2);
				for (var _i = 0; _i < 4; _i++) {
					if (con_server.player_list[_i] == noone) {
						if (_i == 0)
							add_to_queue("     (player list is empty)\n", 2);
						break;
					}
					add_to_queue("     Player " + string(_i) + ": " + con_server.player_list[_i].username + "\n", 2);
				}
				
				add_to_queue("\n", 2);
				add_to_queue("> ", 1);
				
				keyboard_string = "";
				
				break;
	
			case "cls":
				past_string = "> ";
				keyboard_string = "";
			
				line_num = 0;
				scroll_pos = 0;
			
				break;
	
			case "exit":
			case "q":
			case "quit":
				past_string += keyboard_string + "\nQuitting...";
				keyboard_string = "";
				taking_inputs = false;
				alarm[2] = 5;
			
				line_num += 1;
			
				break;
	
			default:
				past_string += keyboard_string + "\nCommand not understood. Use `help` to see a list of available commands.";
				keyboard_string = "";
				past_string += "\n> ";
			
				line_num += 2;
			
				break;
	
		}

	}

}