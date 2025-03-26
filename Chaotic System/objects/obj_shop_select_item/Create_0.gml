title = "";
image_xscale = 3;
image_yscale = 3;
is_primary = false;
is_second = false;

color = c_white;

current_col_val = 255;

alpha = 1;

function update_pors() {
	is_primary = sprite_index == obj_player.primary;
	is_second = sprite_index == obj_player.secondary;
	if (is_primary || is_second) {
		if (place_meeting(x, y, obj_shop_menu.mouse)) {
			current_col_val = 255;
			assign_color();
			alpha = 0;
		}
		else {
			current_col_val = 64;
			assign_color();
		}
	}
	else {
		current_col_val = 255;
		assign_color();
	}
}

function assign_color() {
	var _hex = scr_dec_to_hex(current_col_val);
	var _str = _hex + _hex + _hex;
	var _col = scr_string_to_color(_str);
	image_blend	= _col;
}