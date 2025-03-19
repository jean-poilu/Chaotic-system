var _args = [network.destroy_player, player_num];
var _buffer_args = [buffer_u8, buffer_u8];
network_send(_args, _buffer_args);

var _index = ds_list_find_index(con_game_updater.tank_list, id);

ds_list_delete(con_game_updater.tank_list, _index);

obj_tank_creator.respawn_tank(id);

with (nozzle)
	instance_destroy();
