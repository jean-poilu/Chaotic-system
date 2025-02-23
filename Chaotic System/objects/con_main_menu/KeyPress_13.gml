if (modifying_variable)
{
	modifying_variable = false;
	if (current_variable == 0)
		global.username = keyboard_string;
	else if (current_variable == 1)
		global.address = keyboard_string;
	
}
else if (draw == 0)
{
	if (global.username == "")
	{
		var _message = instance_create_layer(camera_get_view_width(view_camera[0]) / 2,
												420, "Instances", con_message);
		_message.clr = c_red;
		_message.alarm[0] = 240;
		_message.msg = "Invalid name, cannot be empty!";
		_message.msg_type = "other";
		_message.center = true;
	}
	else if (global.address == "")
	{
		var _message = instance_create_layer(camera_get_view_width(view_camera[0]) / 2,
												620, "Instances", con_message);
		_message.clr = c_red;
		_message.alarm[0] = 240;
		_message.msg = "Invalid address, cannot be empty!";
		_message.msg_type = "other";
		_message.center = true;
	}
	else
	{
		draw = 1;
		alarm[0] = 10;
	}
}
else if (draw == 2)
{
	draw = 0;
}