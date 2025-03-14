if (exploding)
	return;

if (!instance_exists(obj_tank))
	return;


var _nearest = point_distance(x, y, instance_nearest(x, y, obj_tank).x, instance_nearest(x, y, obj_tank).y);

if (initial_wait && _nearest > 135) {
	
	initial_wait = false;
	
	var _mine_num = ds_list_find_index(obj_mine_parent.mine_id_list, id);
	
	with (con_server)
	{
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.explode_mine);
			buffer_write(server_buffer, buffer_u8, 0);
			buffer_write(server_buffer, buffer_u8, _mine_num);
		
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
			_i++;
		}
	}
	
	sprite_index = spr_mine_primed;
	
}
else if (!initial_wait && _nearest < 120) {
	explode();
}