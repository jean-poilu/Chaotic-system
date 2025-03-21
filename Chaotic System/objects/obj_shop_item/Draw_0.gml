draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if (place_meeting(x, y, obj_shop_menu.mouse) && !cant_zoom) {
	if (image_xscale < 6) {
		image_xscale += (6 - image_xscale) / 10;
		image_yscale += (6 - image_yscale) / 10;
		if (image_xscale > 6) {
			image_xscale = 6;
			image_yscale = 6;
		}
	}
	
	if (mouse_check_button_pressed(mb_left) && !sold && obj_player.money >= price) {
		obj_player.money -= price;
		sold = true;
		image_blend = c_dkgrey;
	}
	else if (mouse_check_button_pressed(mb_left) && !sold && obj_player.money < price) {
		obj_shop_menu.shake_money();
	}
	
}
else if (image_xscale > 4) {
	if (sold)
		cant_zoom = true;
	image_xscale -= (1 / ((image_xscale - 4) * 10));
	image_yscale -= (1 / ((image_yscale - 4) * 10));
	if (image_xscale < 4) {
		image_xscale = 4;
		image_yscale = 4;
	}
}

if (!sold) {
	draw_set_color(c_lime);
	draw_text_transformed(x + 2, y + 100, "$" + string(price), 2, 2, 0);
} else {
	draw_set_color(c_red);
	draw_text_transformed(x + 2, y + 100, "SOLD", 2, 2, 0);
}

if (sold)
	draw_set_color(c_yellow);
else
	draw_set_color(c_white);

draw_text_transformed(x + 2, y - 100, string(title), 1.5, 1.5, 0);

draw_self();

draw_set_color(c_white);