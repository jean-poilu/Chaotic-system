image_angle = point_direction(x, y,
	global.mouse_coords[tank.player_num, 0], global.mouse_coords[tank.player_num, 1]);

ang_vel = image_angle - prev_ia;

prev_ia = image_angle;