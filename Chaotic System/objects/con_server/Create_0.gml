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

socket = 0;
buffer = 0;

port = 58001;
max_clients = 4;

type = "tcp"

if (type == "tcp")
	created = network_create_server(network_socket_tcp, port, max_clients);
else if (type == "udp")
	created = network_create_server(network_socket_udp, port, max_clients);

if (created < 0)
	show_message("Server did not create successfully. (type: "
	+ type + ", port: " + string(port) + ", max_clients: " + string(max_clients));

server_buffer = buffer_create(1024, buffer_fixed, 1);
socket_list = ds_list_create();
socket_to_instanceid = ds_map_create();

player_spawn_x = 100;
player_spawn_y = 100;

global.inputs[4, 7] = 0;
for (var _i = 0; _i < 4; _i++)
{
	for (var _j = 0; _j < 7; _j++)
	{
		global.inputs[_i, _j] = 0;
	}
}

couleur[9] = 0;
couleur[0] = c_white;
couleur[1] = c_red;
couleur[2] = c_orange;
couleur[3] = c_yellow;
couleur[4] = c_lime;
couleur[5] = c_aqua;
couleur[6] = c_blue;
couleur[7] = c_fuchsia;
couleur[8] = c_purple;

global.player_colors[4] = c_white;

player_list[4] = noone;

global.votes[4] = 0;

for (var _i = 0; _i < 4; _i++)
{
	player_list[_i] = noone;
	
	global.player_colors[_i] = c_white;
	
	global.votes[_i] = 0;
}

global.messages = 0;

global.saved_room = room_1;

global.deaths = 0;

global.dont_respawn = false;

global.players = noone;

global.death_id = "other";

global.current_name = "";
global.current_name_width = 0;

global.message_speed = 4;

global.force_top = false;