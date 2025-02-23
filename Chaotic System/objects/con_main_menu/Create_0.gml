draw_set_font(fnt_font);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

enum maction
{
	anything_else,
	username,
	address,
	join,
	quit,
	back
}

global.address = "127.0.0.1";
global.username = "";

if (file_exists("save"))
{
	var _save = ini_open("save");
	global.address = ini_read_string("Info", "address", "127.0.0.1");
	global.username = ini_read_string("Info", "username", "");
	ini_close();
}

modifying_variable = false;
current_variable = 0;
on = maction.anything_else;
draw = 0;

if (instance_exists(con_other_popup))
	draw = 3;
