move[0] = keyboard_check(vk_left) || keyboard_check(ord("A"));
move[1] = keyboard_check(vk_right) || keyboard_check(ord("D"));
move[2] = keyboard_check(vk_up) || keyboard_check(ord("W"));
move[3] = keyboard_check(vk_down) || keyboard_check(ord("S"));
move[4] = keyboard_check(vk_enter) || keyboard_check(ord("Z"));
move[5] = keyboard_check(vk_shift) || keyboard_check(ord("X"));
move[6] = keyboard_check(ord("R"));

if (global.number_of_players == 1)
{
	move[0] = keyboard_check(vk_left);
	move[1] = keyboard_check(vk_right);
	move[2] = keyboard_check(vk_up);
	move[3] = keyboard_check(vk_down);
	move[4] = keyboard_check(vk_enter);
	move[5] = keyboard_check(vk_shift);
	move[6] = keyboard_check(ord("R"));
	move[7] = keyboard_check(ord("A"));
	move[8] = keyboard_check(ord("D"));
	move[9] = keyboard_check(ord("W"));
	move[10] = keyboard_check(ord("S"));
	move[11] = keyboard_check(ord("Z"));
	move[12] = keyboard_check(ord("X"));
	move[13] = keyboard_check(ord("R"));
	for (var _i = 7; _i < 14; _i++)
	{
		if (last_move[_i] != move[_i])
		{
			with (con_client)
			{
				buffer_seek(client_buffer, buffer_seek_start, 0);
				buffer_write(client_buffer, buffer_u8, network.inputs);
				buffer_write(client_buffer, buffer_u8, _i - 7);
				buffer_write(client_buffer, buffer_u8, 1);
				network_send_packet(client, client_buffer, buffer_tell(client_buffer));
			}
		}
	}
}

for (var _i = 0; _i < 7; _i++)
{
	if (last_move[_i] != move[_i])
	{
		with (con_client)
		{
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.inputs);
			buffer_write(client_buffer, buffer_u8, _i);
			buffer_write(client_buffer, buffer_u8, obj_player.player_num);
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
}

for (var _i = 0; _i < 14; _i++)
	last_move[_i] = move[_i];