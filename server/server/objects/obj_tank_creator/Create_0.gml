instance_create_depth(0, 0, 0, con_game_updater);

tank_spawn_points[4, 2] = 0;

tank_spawn_points[0, 0] = 160;
tank_spawn_points[0, 1] = 608;

tank_spawn_points[1, 0] = 1088;
tank_spawn_points[1, 1] = 160;

tank_spawn_points[2, 0] = 288;
tank_spawn_points[2, 1] = 128;

tank_spawn_points[3, 0] = 736;
tank_spawn_points[3, 1] = 384;

for (var _i = 0; _i < ds_list_size(con_server.socket_list); _i++) {
	var _tank = instance_create_layer(tank_spawn_points[_i, 0], tank_spawn_points[_i, 1], "tanks", obj_tank);
	_tank.player_num = _i;
	
	con_game_updater.add_tank(_tank);
}

alarm[0] = 2;

function respawn_tank(_respawn_tank) {
	var _random_spawn = irandom(3);
	
	var _tank = instance_create_layer(tank_spawn_points[_random_spawn, 0], tank_spawn_points[_random_spawn, 1], "tanks", obj_tank);
	_tank.player_num = _respawn_tank.player_num;
	
	con_game_updater.add_tank(_tank);
	
	con_game_updater.send_single_tank_instance(_tank);
}