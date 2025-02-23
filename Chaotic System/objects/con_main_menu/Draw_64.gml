
if (draw == 0)
{

	on = maction.anything_else;

	var _x = camera_get_view_width(view_camera[0]) / 2;
	draw_text_transformed_color(_x, 100, "Join a game", 4, 4, 0,
		c_white, c_white, c_white, c_white, 1);

	draw_text_transformed_color(_x, 260, "Username", 3, 3, 0,
		c_white, c_white, c_white, c_white, 1);
	
	draw_text_transformed_color(_x, 460, "Server address", 3, 3, 0,
		c_white, c_white, c_white, c_white, 1);
	

	draw_option(_x, 300, 400, global.username, maction.username,,,,,,, !modifying_variable);
	draw_option(_x, 500, 600, global.address, maction.address,,,,,,, !modifying_variable);
	draw_option(_x, 650, 750, "Join server", maction.join,,,,,,, !modifying_variable);
	draw_option(_x, 850, 950, "Quit game", maction.quit,,,,,,, !modifying_variable);

	if (modifying_variable)
	{
		if (string_length(keyboard_string) > 15)
			keyboard_string = string_delete(keyboard_string, 16, 1);
		if (current_variable == 0)
			draw_option(_x, 300, 400, keyboard_string, maction.username,, c_yellow,,,,, !modifying_variable);
		else if (current_variable == 1)
			draw_option(_x, 500, 600, keyboard_string, maction.address,, c_yellow,,,,, !modifying_variable);
	}
}
else if (draw == 1)
{
	var _x = camera_get_view_width(view_camera[0]) / 2;
	draw_text_transformed_color(_x, 500, "Joining game...", 3, 3, 0,
		c_white, c_white, c_white, c_white, 1);
}
else if (draw == 2)
{
	var _x = camera_get_view_width(view_camera[0]) / 2;
	draw_text_transformed_color(_x, 500, "Failed to connect to server " + global.address + ".", 3, 3, 0,
		c_white, c_white, c_white, c_white, 1);
		
	draw_option(_x, 600, 700, "Back", maction.back);
}
else if (draw == 3)
{
	if (!instance_exists(con_other_popup))
		draw = 0;
	var _x = camera_get_view_width(view_camera[0]) / 2;
	draw_text_transformed_color(_x, 100, "Failed to connect to server " + global.address + ".", 3, 3, 0,
		c_white, c_white, c_white, c_white, 1);
}