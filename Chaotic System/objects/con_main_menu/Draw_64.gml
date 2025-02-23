if (taking_inputs = false)
	keyboard_string = "";

draw_set_color(c_lime);
if (show_cursor)
	total_string = past_string + keyboard_string + "l";
else
	total_string = past_string + keyboard_string;
draw_text(50, 50, total_string);

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
	audio_play_sound(snd_drop_003, 0, 0);
	if (responding) {
		responding = false;
		response_to = "";
		past_string += keyboard_string + "\n> ";
		keyboard_string = "";
	}
	else {
		past_string += keyboard_string + "\n> ";
		keyboard_string = "";
	}
	if (!taking_inputs) {
		taking_inputs = true;
		
	}
}

if (keyboard_check_pressed(vk_up)) {
	if (last_commands_at < 9 && last_commands[last_commands_at + 1] != "") {
		last_commands_at++;
		keyboard_string = last_commands[last_commands_at];
	}
}

if (keyboard_check_pressed(vk_down)) {
	if (last_commands_at > 0) {
		last_commands_at--;
		keyboard_string = last_commands[last_commands_at];
	}
}

if (last_commands_at == 0)
{
	last_commands[0] = keyboard_string;
}