if (!is_drawing)
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
			case "host-username":
				if (keyboard_string = "") {
					past_string += "\nEnter username: ";
				
					line_num += 1;
				
					break;
				}
				global.username = keyboard_string;
				past_string += keyboard_string + "\nUsername accepted.\nLaunching server...\n";
				keyboard_string = "";
				responding = false;
				response_to = "";
				taking_inputs = false;
				
				show_cursor = false;
				
				instance_create_depth(0, 0, 0, con_server_init);
				global.host = true;
				
				global.address = "127.0.0.1";
				instance_create_depth(0, 0, 0, con_client);
				
			
				line_num += 2;
			
				break;
		
			case "join-address":
				if (keyboard_string = "") {
					past_string += "\nEnter address: ";
				
					line_num += 1;
				
					break;
				}
				global.address = keyboard_string;
				past_string += keyboard_string + "\nAddress accepted.\nEnter username: ";
				keyboard_string = "";
				response_to = "join-username";
			
				line_num += 2;
			
				break;
		
			case "join-username":
				if (keyboard_string = "") {
					past_string += "\nEnter username: ";
				
					line_num += 1;
				
					break;
				}
				global.username = keyboard_string;
				past_string += keyboard_string + "\nUsername accepted.\nJoining...\n";
				keyboard_string = "";
				responding = false;
				response_to = "";
				taking_inputs = false;
				
				show_cursor = false;
				
				alarm[4] = 1; // instance create con_client
			
				line_num += 3;
			
				break;
		
			default:
				break;
		}
	}
	else
	{

		switch (string_lower(keyboard_string))
		{
			case "":
				past_string += "\n> ";
			
				line_num += 1;
			
				return;
		
			case "host":
				past_string += keyboard_string + "\nEnter username: ";
			
				keyboard_string = "";
				responding = true;
				response_to = "host-username";
			
				line_num += 1;
			
				break;
		
			case "join":
				past_string += keyboard_string + "\nEnter address: ";
				keyboard_string = "";
				responding = true;
				response_to = "join-address";
			
				line_num += 1;
			
				break;
			
			case "join last":
				past_string += keyboard_string + "\n";
				
				keyboard_string = "";
				
				ini_open("save");
				global.address = ini_read_string("Info", "address", "127.0.0.1");
				global.username = ini_read_string("Info", "username", "username");
				ini_close();
				
				add_to_queue("Joining address " + string(global.address) + 
					", with username " + string(global.username) + "...\n", 1);
				
				alarm[4] = 3;
			
				break;
	
			case "help":
				past_string += keyboard_string + "\n";
				
				add_to_queue("\n", 2);
				add_to_queue("List of available commands:\n", 2);
				add_to_queue("     host - Host a game\n", 1);
				add_to_queue("     join - Join a game\n", 2);
				add_to_queue("     download - Download latest version\n", 2);
				add_to_queue("     cls - Clear screen\n", 2);
				add_to_queue("     quit - Quit game\n", 1);
				add_to_queue("\n", 1);
				add_to_queue("> ", 1);
				
				keyboard_string = "";
			
				break;
			
			case "download":
				past_string += keyboard_string + "\n";
				
				add_to_queue("Opening https://github.com/jean-poilu/Chaotic-system/releases/latest.\n", 2);
				add_to_queue("> ", 1);
				url_open("https://github.com/jean-poilu/Chaotic-system/releases/latest");
				
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

