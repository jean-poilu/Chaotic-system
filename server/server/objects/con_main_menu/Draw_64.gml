if (!display_terminal) {
	keyboard_string = "";
	
	if (move_y) {
		y = scr_easeExpoOut(0, - camera_get_view_height(view_camera[0]) + 100, move_y_step);
		move_y_step += move_y_speed;
		if (move_y_step >= 1) {
			move_y = false;
			move_y_step = 0;
			was_moved = true;
		}
	}
	else if (!was_moved) {
		y = camera_get_view_height(view_camera[0]) + 100;
		was_moved = true;
	}
}
else if (move_y) {
	y = scr_easeExpoOut(- camera_get_view_height(view_camera[0]), 0, move_y_step);
	move_y_step += move_y_speed;
	if (move_y_step >= 1) {
		move_y = false;
		move_y_step = 0;
		was_moved = true;
	}
}

draw_set_halign(fa_left);
draw_set_valign(fa_top);

// if (room != rm_main_menu)
{
	var _alpha = 0.4;
	if (display_terminal && move_y)
		_alpha = scr_easeExpoOut(0, 0.4, move_y_step);
	else if (!display_terminal && move_y)
		_alpha = scr_easeExpoOut(0.4, 0.0, move_y_step);
	else if (display_terminal && !move_y)
		_alpha = 0.4;
	else if (!display_terminal && !move_y)
		_alpha = 0;
	
	draw_set_alpha(_alpha);
	
	draw_set_color(c_black);
	draw_rectangle(0, 0, camera_get_view_width(view_camera[0]), camera_get_view_height(view_camera[0]), false);
	draw_set_color(c_white);
	
	draw_set_alpha(1);
}

shader_set(shd_combined);

shader_set_uniform_f(uTime, current_time);
shader_set_uniform_f(uIntensity, intensity_value);
var tex = sprite_get_texture(spr_player_waiting, 0);
shader_set_uniform_f(uTexel, texture_get_texel_width(tex), texture_get_texel_height(tex));

if (line_num >= 20)
	overboard = line_num - 20;
else
	overboard = 0;

if (!taking_inputs || is_drawing)
	keyboard_string = "";

draw_set_color(c_lime);
if (show_cursor && !is_drawing)
	total_string = past_string + keyboard_string + "l";
else
	total_string = past_string + keyboard_string;
draw_text(50, y + 50 - ((overboard - scroll_pos) * 27), total_string);

draw_set_color(c_white);

if (keyboard_check(vk_control) && keyboard_check_pressed(ord("C"))) {
	audio_play_sound(snd_drop_003, 0, 0);
	if (!taking_inputs) {
		taking_inputs = true;
		past_string += keyboard_string + "Canceled.\n> ";
		keyboard_string = "";
		
		line_num += 1;
		
	}
	else
	{
		if (responding) {
			responding = false;
			response_to = "";
			past_string += keyboard_string + "\n> ";
			keyboard_string = "";
		
			line_num += 1;
		
		}
		else {
			past_string += keyboard_string + "\n> ";
			keyboard_string = "";
		
			line_num += 1;
		
		}
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

if (mouse_wheel_up()) {
	if (scroll_pos < overboard)
		scroll_pos++;
}

if (mouse_wheel_down()) {
	if (scroll_pos > 0)
		scroll_pos--;
}

if (last_commands_at == 0)
{
	last_commands[0] = keyboard_string;
}

shader_reset();