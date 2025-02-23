switch (on)
{
	case maction.username:
		modifying_variable = true;
		current_variable = 0;
		keyboard_string = global.username;
		break;
		
	case maction.address:
		modifying_variable = true;
		current_variable = 1;
		keyboard_string = global.address;
		break;
	
	case maction.quit:
		game_end()
		break;
	
	case maction.join:
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
		break;
	
	case maction.back:
		draw = 0;
		break;
	
	default:
		break;
}