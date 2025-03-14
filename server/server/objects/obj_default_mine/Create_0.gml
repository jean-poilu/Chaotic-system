initial_wait = true;
exploding = false;

parent_tank = noone;

var _x = x;
var _y = y;
var _t = ds_list_find_index(obj_mine_parent.mine_list, "obj_default_mine");
var _color = scr_get_color(image_blend);

with (con_server)
{
	var _i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _i);
		
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.create_mine);
		buffer_write(server_buffer, buffer_f16, _x);
		buffer_write(server_buffer, buffer_f16, _y);
		buffer_write(server_buffer, buffer_u8, _t);
		buffer_write(server_buffer, buffer_string, _color);
		
		network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
		_i++;
	}
}

ds_list_add(obj_mine_parent.mine_id_list, id);

function explode() {
	sprite_index = spr_mine_explode;
	
	alarm[0] = 20;
	exploding = true;
	
	var _mine_num = ds_list_find_index(obj_mine_parent.mine_id_list, id);
	
	with (con_server)
	{
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			buffer_write(server_buffer, buffer_u8, network.explode_mine);
			buffer_write(server_buffer, buffer_u8, 1);
			buffer_write(server_buffer, buffer_u8, _mine_num);
		
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
			_i++;
		}
	}
}