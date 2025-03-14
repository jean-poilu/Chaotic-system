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
	create_tanks,
	inputs,
	change_color,
	create_bullet,
	create_mine,
	explode_mine,
	destroy_bullet,
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

con_main_menu.add_to_queue("Creating enums.\n", 4);

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

con_main_menu.add_to_queue("Setting port to " + string(port) + ".\n", 2);
con_main_menu.add_to_queue("Setting max clients to " + string(max_clients) + ".\n", 2);

type = "tcp"

con_main_menu.add_to_queue("Setting network socket type to " + string(type) + ".\n", 3);

if (type == "tcp")
	created = network_create_server(network_socket_tcp, port, max_clients);
else if (type == "udp")
	created = network_create_server(network_socket_udp, port, max_clients);
	
con_main_menu.add_to_queue("Creating network server...\n", 15);

if (created < 0) {
	con_main_menu.add_to_queue("[!] Server creation failed, error code: " + string(created) + ".\n", 5);
	instance_destroy();
	exit;
}

con_main_menu.add_to_queue("[!] Network server successfully created.\n", 2);

server_buffer = buffer_create(1024, buffer_fixed, 1);
socket_list = ds_list_create();
socket_to_instanceid = ds_map_create();

con_main_menu.add_to_queue("Creating server buffer...\n", 4);
con_main_menu.add_to_queue("Creating socket list...\n", 4);
con_main_menu.add_to_queue("Creating socket-instance list...\n", 3);

randomize();

con_main_menu.add_to_queue("Randoming the seed...\n", 6);

player_spawn_x = 100;
player_spawn_y = 100;

input_count = 12;
global.inputs[max_clients, input_count] = 0;
global.mouse_coords[max_clients, 2] = 0;


for (var _i = 0; _i < max_clients; _i++)
{
	for (var _j = 0; _j < input_count; _j++)
	{
		global.inputs[_i, _j] = 0;
	}
	global.mouse_coords[_i, 0] = 0;
	global.mouse_coords[_i, 1] = 0;
}

player_list[max_clients] = noone;

con_main_menu.add_to_queue("Creating player list...\n", 3);

for (var _i = 0; _i < max_clients; _i++)
{
	player_list[_i] = noone;
	
	global.player_colors[_i] = c_white;
	
	global.votes[_i] = 0;
}

global.messages = 0;
global.total_bullets = 0;

con_main_menu.add_to_queue("Press TAB to hide/show the terminal.\n", 2);
con_main_menu.add_to_queue("[!] Waiting for players to join.\n", 2);
con_main_menu.add_to_queue("> ", 2);
con_main_menu.taking_inputs = true;