audio_play_sound(snd_bong_001, 0, 0);

if (!is_drawing)
{

	if (keyboard_string != "" && !responding) {
		for (var _i = 8; _i > 0; _i--)
		{
			last_commands[_i + 1] = last_commands[_i];
		}
		last_commands[1] = keyboard_string;
		last_commands_at = 0;
	}

	if (line_num >= 20) {
		if (!responding) {
			past_string = "> ";
			if (keyboard_string == "") {
				past_string = "> ";
				exit;
			}
		}
		else
			past_string = "";
		line_num = 0;
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
				past_string += keyboard_string + "\nUsername accepted.\nCreating session...\n";
				keyboard_string = "";
				responding = false;
				response_to = "";
				taking_inputs = false;
				
				show_cursor = false;
				
				instance_create_depth(0, 0, 0, con_server);
			
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

		switch (keyboard_string)
		{
			case "":
				past_string += "\n> ";
			
				line_num += 1;
			
				break;
		
			case "host":
				if (line_num >= 15) {
					past_string = "> host\nEnter username: ";
					line_num = 0;
				}
				else
					past_string += keyboard_string + "\nEnter username: ";
			
				keyboard_string = "";
				responding = true;
				response_to = "host-username";
			
				line_num += 1;
			
				break;
		
			case "join":
				if (line_num >= 15) {
					past_string = "> join\nEnter address: ";
					line_num = 0;
				}
				else
					past_string += keyboard_string + "\nEnter address: ";
				keyboard_string = "";
				responding = true;
				response_to = "join-address";
			
				line_num += 1;
			
				break;
	
			case "help":
				if (line_num >= 12) {
					past_string = "> ";
					line_num = 0;
				}
				past_string += keyboard_string + "\n";
				
				add_to_queue("\n", 2);
				add_to_queue("List of available commands:\n", 2);
				add_to_queue("     host - Host a game\n", 1);
				add_to_queue("     join - Join a game\n", 2);
				add_to_queue("     quit - Quit game\n", 1);
				add_to_queue("\n", 1);
				add_to_queue("> ", 1);
				
				keyboard_string = "";
			
				line_num += 1;
			
				break;
	
			case "cls":
				past_string = "> ";
				keyboard_string = "";
			
				line_num = 0;
			
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