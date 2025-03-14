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
	
	
	
	
	destroy_type = "y";
	instance_destroy();
}

if (place_meeting(x, y, obj_mine_parent)) {
	var _mine = instance_place(x, y, obj_mine_parent);
	
	_mine.explode();
	
	var _bullet_num = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
	
	with (con_server)
	{
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.destroy_bullet);
			buffer_write(server_buffer, buffer_u8, _bullet_num);
			buffer_write(server_buffer, buffer_string, "n");
		
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
			_i++;
		}
	}
	
	destroy_type = "n";
	instance_destroy();
}