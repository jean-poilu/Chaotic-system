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
				break;
			}
			global.username = keyboard_string;
			past_string += keyboard_string + "\nUsername accepted.\n> ";
			keyboard_string = "";
			responding = false;
			response_to = "";
			
			break;
		
		case "join-address":
			if (keyboard_string = "") {
				past_string += "\nEnter address: ";
				break;
			}
			global.address = keyboard_string;
			past_string += keyboard_string + "\nAddress accepted.\nEnter username: ";
			keyboard_string = "";
			response_to = "join-username";
			break;
		
		case "join-username":
			if (keyboard_string = "") {
				past_string += "\nEnter username: ";
				break;
			}
			global.username = keyboard_string;
			past_string += keyboard_string + "\nUsername accepted.\nJoining...\n";
			keyboard_string = "";
			responding = false;
			response_to = "";
			taking_inputs = false;
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
			break;
		
		case "host":
			past_string += keyboard_string + "\nEnter username: ";
			keyboard_string = "";
			responding = true;
			response_to = "host-username";
			break;
		
		case "join":
			past_string += keyboard_string + "\nEnter address: ";
			keyboard_string = "";
			responding = true;
			response_to = "join-address";
			break;
	
		case "help":
			past_string += keyboard_string + "\n\nList of available commands:\n\n" +
												"     host - Host a game\n" +
												"     join - Join a game\n" +
												"     quit - Quit game\n\n";
			keyboard_string = "";
			past_string += "> ";
			break;
	
		case "cls":
			past_string = "> ";
			keyboard_string = "";
			break;
	
		case "exit":
		case "q":
		case "quit":
			game_end();
			break;
	
		default:
			past_string += keyboard_string + "\nCommand not understood.\n";
			keyboard_string = "";
			past_string += "> ";
			break;
	
	}

}

