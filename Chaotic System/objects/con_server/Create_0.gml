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

con_main_menu.add_to_queue("Creating enums...\n", 4);

enum dialog_type {
	create,
	complete,
	next,
	destroy
}

socket = 0;
buffer = 0;

port = 58001;
max_clients = 8;

con_main_menu.add_to_queue("Choosing port " + string(port) + ".\n", 2);
con_main_menu.add_to_queue("Max clients set to " + string(max_clients) + ".\n", 2);

type = "tcp"

con_main_menu.add_to_queue("Connection type set to " + string(type) + ".\n", 2);

if (type == "tcp")
	created = network_create_server(network_socket_tcp, port, max_clients);
else if (type == "udp")
	created = network_create_server(network_socket_udp, port, max_clients);
	
con_main_menu.add_to_queue("Creating network server...\n", 15);

if (created < 0) {
	con_main_menu.add_to_queue("Server creation failed, error code: " + string(created) + ".\n", 2);
	con_main_menu.add_to_queue("> ", 1);
	con_main_menu.taking_inputs = true;
	instance_destroy();
	return;
}
else
	con_main_menu.add_to_queue("Created network server successfully.\n", 2);

server_buffer = buffer_create(1024, buffer_fixed, 1);
socket_list = ds_list_create();
socket_to_instanceid = ds_map_create();

con_main_menu.add_to_queue("Creating buffer...\n", 7);
con_main_menu.add_to_queue("Creating socket list...\n", 5);
con_main_menu.add_to_queue("Creating socket-id list...\n", 6);

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

player_list[max_clients] = noone;

con_main_menu.add_to_queue("Creating player list...\n", 9);


for (var _i = 0; _i < 4; _i++)
{
	player_list[_i] = noone;
}

con_main_menu.add_to_queue("Server creation done.\n", 2);

// con_main_menu.add_to_queue("Sending user to lobby...\n", 30 + irandom_range(-10, 10));
// con_main_menu.add_to_queue("GOTO LOBBY", 1);

con_main_menu.add_to_queue("Creating client...\n", 3);
con_main_menu.add_to_queue("CREATE CLIENT", 1);

global.messages = 0;

global.own_server = false;