draw_set_font(fnt_font);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

// shd_handler = shader_get_uniform(shd_bloom, "intensity");
uTime = shader_get_uniform(shd_combined, "Time");
uTexel = shader_get_uniform(shd_combined, "Texel");
uIntensity = shader_get_uniform(shd_combined, "intensity");

intensity_value = 0.6;

past_string = "";

line_num = -1;
scroll_pos = 0;
overboard = 0;

move_y = false;
move_y_step = 0;
move_y_speed = 0.03;
was_moved = false;

display_terminal = true;

last_commands[10] = "";
for (var _i = 0; _i < 10; _i++)
	last_commands[_i] = "";
last_commands_at = 0;

show_cursor = true;
cursor_freq = 20;
alarm[1] = cursor_freq;

taking_inputs = false;
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


queue = ds_queue_create();
wait_queue = ds_queue_create();

alarm[3] = 1;

function add_to_queue(_str, _time) {
	ds_queue_enqueue(queue, _str);
	ds_queue_enqueue(wait_queue, _time);
	
}

is_drawing = true;

instance_create_depth(0, 0, 0, con_server);