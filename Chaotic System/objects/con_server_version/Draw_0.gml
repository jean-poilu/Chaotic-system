if (room == Room1)
{
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_text_transformed_color(4, 1040, "version: " + global.server_version, 1.5, 1.5, 0, c_white, c_white, c_white, c_white, 1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
}