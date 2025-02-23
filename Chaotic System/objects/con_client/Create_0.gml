draw_set_font(fnt_font);

enum network
{
	player_check_version,
	player_establish,
	player_connect,
	player_joined,
	player_disconnected,
	move0,
	go,
	move1,
	destroy_player,
	create_player,
	inputs,
	change_color,
	next_level,
	lightning,
	dialog,
	kick,
	change_variable,
	vote_action,
	popup,
	add_player,
	goto_menu,
	sync_moving,
	snail,
	fishing,
	rm_event
}

enum dialog_type {
	create,
	complete,
	next,
	destroy
}

port = 58001;
client = network_create_socket(network_socket_tcp);

connected = network_connect(client, global.address, port);
if (connected < 0)
{
	con_main_menu.draw = 2;
	instance_destroy();
	exit;
}

if (instance_exists(con_message))
{
	with (con_message)
		instance_destroy();
}
room_goto(Room1);

client_buffer = buffer_create(1024, buffer_fixed, 1);

socket_to_instanceid = ds_map_create();

global.player_colors[4] = c_white;

player_list[4] = noone;

global.votes[4] = 0;

for (var _i = 0; _i < 4; _i++)
{
	global.player_colors[_i] = c_white;
	
	player_list[_i] = noone;
	
	global.votes[_i] = 0;
}

global.messages = 0;

couleur[9] = c_white;
couleur[0] = c_white;
couleur[1] = c_red;
couleur[2] = c_orange;
couleur[3] = c_yellow;
couleur[4] = c_lime;
couleur[5] = c_aqua;
couleur[6] = c_blue;
couleur[7] = c_fuchsia;
couleur[8] = c_purple;

global.msg[10] = "";

global.last_interact_box = noone;

global.deaths = 0;

global.players = noone;

global.manual_spawn = false;
global.spawn_x = 0;
global.spawn_y = 0;

global.death_id = "other";

global.current_name = "";
global.current_name_width = 0;

global.message_speed = 4;

global.force_top = false;