// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function move_everything(_type = "parts") {
	var _i = 0;
	repeat(ds_list_size(socket_list))
	{
		var _sock = ds_list_find_value(socket_list, _i);
				
		buffer_seek(server_buffer, buffer_seek_start, 0);
		buffer_write(server_buffer, buffer_u8, network.move1);
		
		buffer_write(server_buffer, buffer_string, _type);
		
		if (_type == "parts")
		{
			var _part_amount = 4;
			if (global.players == obj_player_3)
				_part_amount = 3;
		
			for (var _j = 0; _j < _part_amount; _j++)
			{
				buffer_write(server_buffer, buffer_s16, global.part[_j].x);
				buffer_write(server_buffer, buffer_s16, global.part[_j].y);
			}
		}
		else if (_type == "fish")
		{
			var _player_amount = 2;
			if (global.players == obj_player_4)
				_player_amount = 4;
			
			if (_player_amount == 2)
			{
				buffer_write(server_buffer, buffer_s16, obj_fish_game.fish[0].x);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.fish[0].y);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.rods[0].hook.x);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.rods[0].hook.y);
			}
			else if (_player_amount == 4)
			{
				buffer_write(server_buffer, buffer_s16, obj_fish_game.fish[0].x);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.fish[0].y);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.rods[0].hook.x);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.rods[0].hook.y);
				
				buffer_write(server_buffer, buffer_s16, obj_fish_game.fish[1].x);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.fish[1].y);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.rods[1].hook.x);
				buffer_write(server_buffer, buffer_s16, obj_fish_game.rods[1].hook.y);
			}
		}
		network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
		_i++;
	}
}