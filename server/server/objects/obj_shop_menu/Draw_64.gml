draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_transformed(room_width / 2 + 3, room_height / 2 + 3, "Players in shop\n"
	+ string(readys) + "/" + string(ds_list_size(con_server.socket_list)) + " ready", 3, 3, 0);