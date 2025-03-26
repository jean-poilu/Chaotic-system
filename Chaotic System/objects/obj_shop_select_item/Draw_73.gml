draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_self();

if (place_meeting(x, y, obj_shop_menu.mouse)) {
	if (current_col_val < 255) {
		if (alpha > 0)
			alpha -= 0.1;
		current_col_val += 6;
		if (current_col_val > 255)
			current_col_val = 255;
		assign_color();
	}
	
	if (mouse_check_button(mb_left)) {
		if (obj_shop_item_selector.pors == "Primary") {
			if (!is_primary) {
				if (is_second)
					obj_player.set_secondary(obj_player.primary);
				obj_player.set_primary(sprite_index);
				with (obj_shop_select_item)
					update_pors();
			}
		}
		else if (obj_shop_item_selector.pors == "Secondary") {
			if (!is_second) {
				if (is_primary)
					obj_player.set_primary(obj_player.secondary);
				obj_player.set_secondary(sprite_index);
				with (obj_shop_select_item)
					update_pors();
			}
		}
	}
}
else if ((is_primary || is_second) && current_col_val > 64) {
	if (alpha < 1)
			alpha += 0.1;
	current_col_val -= 6;
	if (current_col_val < 64)
		current_col_val = 64;
	assign_color();
}

draw_set_alpha(alpha);

if (is_primary) {
	draw_text_transformed(x + 3, y + 3, "#1", 1, 1, 0);
}
else if (is_second) {
	draw_text_transformed(x + 3, y + 3, "#2", 1, 1, 0);
}

draw_set_alpha(1);

if (is_primary && obj_shop_item_selector.pors == "Primary" || is_second && obj_shop_item_selector.pors == "Secondary")
	draw_set_color(c_yellow);

draw_text_transformed(x + 3, y - 60 + 3, title, 0.8, 0.8, 0);

draw_set_color(c_white);