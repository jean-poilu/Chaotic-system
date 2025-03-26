draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_self();

if (place_meeting(x, y, obj_shop_menu.mouse)) {
	
	
	draw_rectangle(x - 100, y - 50, x + 100, y + 50, false);
	if (mouse_check_button_pressed(mb_left)) {
		ready = !ready;
		if (ready) {
			image_blend = c_lime;
			with (obj_shop_item) {
				if (!sold) {
					image_blend = c_grey;
					cant_zoom = true;
				}
			}
		}
		else {
			image_blend = c_white;
			with (obj_shop_item) {
				if (!sold) {
					image_blend = c_white;
					cant_zoom = false;
				}
			}
		}
		send_ready();
		
	}
	if (ready) {
		draw_set_color(c_lime);
		draw_rectangle(x - 100, y - 50, x + 100, y + 50, false);
	}
	draw_set_color(c_black);
	
	

}
else {
	if (ready)
		draw_set_color(c_lime);
	else
		draw_set_color(c_white);
}


draw_text_transformed(x + 3, y + 3, "READY", 2, 2, 0);

draw_set_color(c_white);