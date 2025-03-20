money = 0;
addition = 0;

money_y = 70;

ini_add_y = money_y + 50;
add_y = ini_add_y;
acc = 0;

alarm[0] = 60;
progress = 0;

alpha = 1;

var _tank_over = collision_rectangle(0, camera_get_view_height(view_camera[0]), 260, camera_get_view_height(view_camera[0]) - 150, obj_tank, false, true);

if (_tank_over != noone)
	alpha = 0.3;