spd = 5;

acc = 0;

parent_tank = noone;
can_hit_parent_tank = false;
alarm[0] = 3;

destroy_type = "n";

ds_list_add(obj_bullet_parent.bullet_id_list, id);

global.total_bullets++;

if (global.total_bullets > 10) {
	instance_destroy();
	exit;
}

var _x = x;
var _y = y;
var _d = direction;
var _s = speed;
var _acc = global.temp_acc;
var _t = ds_list_find_index(obj_bullet_parent.bullet_list, "obj_curved_bullet");
var _player_num = global.temp_player_num;
var _color = scr_get_color(image_blend);

with (con_server)
{
	var _i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _i);
		
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.create_bullet);
		buffer_write(server_buffer, buffer_f16, _x);
		buffer_write(server_buffer, buffer_f16, _y);
		buffer_write(server_buffer, buffer_f16, _d);
		buffer_write(server_buffer, buffer_f16, _s);
		buffer_write(server_buffer, buffer_f16, _acc);
		buffer_write(server_buffer, buffer_u8, _t);
		buffer_write(server_buffer, buffer_u8, _player_num);
		buffer_write(server_buffer, buffer_string, _color);
		
		network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
		_i++;
	}
}