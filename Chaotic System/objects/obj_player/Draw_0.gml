if (room == rm_waiting_room)
{
	draw_self();

	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(x, y - 50, string(player_num) + " " + username, 2, 2, 0);
}