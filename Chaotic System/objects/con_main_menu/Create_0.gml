draw_set_font(fnt_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

past_string = "> ";

last_commands[10] = "";
for (var _i = 0; _i < 10; _i++)
	last_commands[_i] = "";
last_commands_at = 0;

show_cursor = true;
alarm[1] = 30;

taking_inputs = true;
total_string = "";
responding = false;
response_to = "";

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
