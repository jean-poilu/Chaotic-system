if (place_meeting(x + hspeed, y, obj_wall)) {
	destroy_type = "x";
	instance_destroy();
}
if (place_meeting(x, y + vspeed, obj_wall)) {
	destroy_type = "y";
	instance_destroy();
}

if (place_meeting(x + hspeed, y, obj_tank)) {
	
	var _tank = instance_place(x + hspeed, y, obj_tank);
	
	if (_tank == parent_tank && !can_hit_parent_tank)
		return;
	
	_tank.death_cause = id;
	with (_tank) {
		instance_destroy();
	}
	
	
	if (_tank != parent_tank)
		player_list[parent_tank.player_num].add_money(100);
	
	
	destroy_type = "x";
	instance_destroy();
}

if (place_meeting(x, y + vspeed, obj_tank)) {
	
	var _tank = instance_place(x, y + vspeed, obj_tank);
	
	if (_tank == parent_tank && !can_hit_parent_tank)
		return;
	
	_tank.death_cause = id;
	with (_tank) {
		instance_destroy();
	}
	
	
	if (_tank != parent_tank)
		player_list[parent_tank.player_num].money += 100;
	
	destroy_type = "y";
	instance_destroy();
}

if (place_meeting(x, y, obj_mine_parent)) {
	var _mine = instance_place(x, y, obj_mine_parent);
	
	_mine.explode();
	
	var _bullet_num = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
	
	var _args = [network.destroy_bullet, _bullet_num, "n"];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_string];
	network_send(_args, _buffer_args);
	
	destroy_type = "n";
	instance_destroy();
}