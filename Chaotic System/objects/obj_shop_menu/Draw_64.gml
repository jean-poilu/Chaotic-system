// Draw shop title
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(camera_get_view_width(view_camera[0]) / 2 + 3, 60 + 3, "Shop", 3, 3, 0);


// Draw money
draw_set_halign(fa_right);
draw_set_valign(fa_top);

draw_set_color(c_lime);

if (shake) {
	
	draw_set_color(c_red);
	
	shmx = random_range(- strength / 10, strength / 10);
	shmy = random_range(- strength / 10, strength / 10);
	
	strength--;
	if (strength <= 0) {
		shake = false;
		strength = 0;
		shmx = 0;
		shmy = 0;
	}
}



draw_text_transformed(camera_get_view_width(view_camera[0]) - 10 + shmx, 10 + shmy, "$" + string(obj_player.money), 2, 2, 0);

draw_set_color(c_white);

mouse.x = mouse_x;
mouse.y = mouse_y;