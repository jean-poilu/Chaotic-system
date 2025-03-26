draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_line_width(x - 16 * 4 - 2, y - 16 * 4 - 40 - 4, x - 16 * 4 - 2, y + 16 * 4, 4); // |o
draw_line_width(x + 16 * 4, y - 16 * 4 - 40 - 4, x + 16 * 4, y + 16 * 4, 4); // o|
draw_line_width(x - 16 * 4 - 4, y - 16 * 4 - 40 - 4, x + 16 * 4 + 2, y - 16 * 4 - 40 - 4, 4); // ^o
draw_line_width(x - 16 * 4 - 4, y - 16 * 4 - 2, x + 16 * 4 + 2, y - 16 * 4 - 2, 4); // -o
draw_line_width(x - 16 * 4 - 4, y + 16 * 4, x + 16 * 4 + 2, y + 16 * 4, 4); // _o
draw_text_transformed(x + 3, y - 88 + 3, "Primary", 1.2, 1.2, 0);

draw_self();

if (place_meeting(x, y, obj_shop_menu.mouse)) {
	if (!instance_exists(tool_tip)) {
		tool_tip = instance_create_layer(0, 0, "tool_tip", obj_shop_item_name);
		tool_tip.title = title;
	}
	
	if (mouse_check_button_pressed(mb_left)) {
		if (!instance_exists(selector_window)) {
			selector_window = instance_create_layer(camera_get_view_width(view_camera[0]) / 2, 
				camera_get_view_height(view_camera[0]) / 2, "selector", obj_shop_item_selector);
			selector_window.pors = "Primary";
		}
	}
}
else {
	if (instance_exists(tool_tip)) {
		with (tool_tip)
			instance_destroy();
	}
}