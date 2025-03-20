draw_set_halign(fa_left);
draw_set_valign(fa_top);

draw_set_color(c_lime);

var _tank_over = collision_rectangle(0, camera_get_view_height(view_camera[0]), 260, camera_get_view_height(view_camera[0]) - 150, obj_tank, false, true);
// draw_rectangle(0, camera_get_view_height(view_camera[0]), 260, camera_get_view_height(view_camera[0]) - 150, true);

if (progress == 3) {
	alpha -= 0.05;
	
	if (alpha <= 0)
		instance_destroy();
}
else {
	if (_tank_over != noone && alpha > 0.3)
		alpha -= 0.1;
	else if (alpha < 1)
		alpha += 0.1;
}

draw_set_alpha(alpha);

draw_text_transformed(125, camera_get_view_height(view_camera[0]) - money_y, "$" + string(money), 2, 2, 0);
if (progress < 2)
	draw_text_transformed(70, camera_get_view_height(view_camera[0]) - add_y, "+ $" + string(addition), 2, 2, 0);

if (progress == 1) {
	acc += 0.5;
	add_y -= acc;
	
	if (add_y <= money_y) {
		progress = 2;
		money += addition;
		alarm[0] = 90;
	}
}

draw_set_color(c_white);
draw_set_alpha(1);