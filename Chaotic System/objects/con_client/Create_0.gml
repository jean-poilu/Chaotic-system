draw_set_font(fnt_font);

port = 58001;
client = network_create_socket(network_socket_tcp);

con_main_menu.add_to_queue("Choosing port " + string(port) + ".\n", 2);
con_main_menu.add_to_queue("Creating client socket...\n", 8);

connected = network_connect(client, global.address, port);
if (connected < 0)
{
	con_main_menu.add_to_queue("Socket creation failed, error code: " + string(connected) + ".\n", 2);
	con_main_menu.add_to_queue("> ", 2);
	con_main_menu.taking_inputs = true;
	instance_destroy();
	exit;
}

con_main_menu.add_to_queue("Socket created successfully.\n", 2);

if (instance_exists(con_message))
{
	with (con_message)
		instance_destroy();
}

client_buffer = buffer_create(1024, buffer_fixed, 1);

con_main_menu.add_to_queue("Creating buffer...\n", 7);

socket_to_instanceid = ds_map_create();

con_main_menu.add_to_queue("Creating socket-id list...\n", 4);

player_list[8] = noone;

con_main_menu.add_to_queue("Creating player list...\n", 6);

for (var _i = 0; _i < 8; _i++)
{
	player_list[_i] = noone;
}

con_main_menu.add_to_queue("Sending player to lobby...\n", 30 + irandom_range(-10, 10));
con_main_menu.add_to_queue("GOTO LOBBY", 30 + irandom_range(-10, 10));