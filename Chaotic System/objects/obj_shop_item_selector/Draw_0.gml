draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_self();
draw_text_transformed(x + 3, y - 150 + 3, "Choose " + pors, 2, 2, 0);

// draw_rectangle_color(x + 270, y + 145, x + 355, y + 200, c_aqua, c_aqua, c_aqua, c_aqua, false);
if (collision_rectangle(x + 270, y + 145, x + 355, y + 200, obj_shop_menu.mouse, false, true)) {
	draw_rectangle(x + 270, y + 145, x + 355, y + 200, false);
	draw_set_color(c_dkgrey);
	
	if (mouse_check_button_pressed(mb_left)) {
		instance_destroy();
	}
}

draw_text_transformed(x + 315 + 3, y + 172 + 3, "OK", 2, 2, 0);

draw_set_color(c_white);