move[0] = keyboard_check(ord("W"));
move[1] = keyboard_check(ord("A"));
move[2] = keyboard_check(ord("S"));
move[3] = keyboard_check(ord("D"));
move[4] = mouse_check_button(mb_left);
move[5] = mouse_check_button(mb_right);
move[6] = keyboard_check(ord("Q"));
move[7] = keyboard_check(ord("E"));
move[8] = keyboard_check(vk_shift);
move[9] = keyboard_check(vk_space);

/*
if (global.number_of_players == 1)
{
	move[0] = keyboard_check(ord("T"));		// pires inputs jamais vu dans l'histoire du game dev
	move[1] = keyboard_check(ord("F"));
	move[2] = keyboard_check(ord("G"));
	move[3] = keyboard_check(ord("H"));
	move[4] = keyboard_check(ord("K"));
	move[5] = keyboard_check(ord("L"));
	move[6] = keyboard_check(ord("R"));
	move[7] = keyboard_check(ord("Y"));
	move[8] = keyboard_check(ord("C"));
	move[9] = keyboard_check(ord("B"));
	
	move[10] = keyboard_check(ord("W"));
	move[11] = keyboard_check(ord("A"));
	move[12] = keyboard_check(ord("S"));
	move[13] = keyboard_check(ord("D"));
	move[14] = keyboard_check(mouse_check_button(mb_left));
	move[15] = keyboard_check(mouse_check_button(mb_right));
	move[16] = keyboard_check(ord("Q"));
	move[17] = keyboard_check(ord("E"));
	move[18] = keyboard_check(vk_shift);
	move[19] = keyboard_check(vk_space);
	
	for (var _i = input_count; _i < input_count * 2; _i++)
	{
		if (last_move[_i] != move[_i])
		{
			with (con_client)
			{
				buffer_seek(client_buffer, buffer_seek_start, 0);
				buffer_write(client_buffer, buffer_u8, network.inputs);
				buffer_write(client_buffer, buffer_u8, 0);
				buffer_write(client_buffer, buffer_u8, _i - con_input_handler.input_count);
				buffer_write(client_buffer, buffer_u8, 1);
				network_send_packet(client, client_buffer, buffer_tell(client_buffer));
			}
		}
	}
}
*/

for (var _i = 0; _i < input_count; _i++)
{
	if (last_move[_i] != move[_i])
	{
		with (con_client)
		{
			buffer_seek(client_buffer, buffer_seek_start, 0);
			buffer_write(client_buffer, buffer_u8, network.inputs);
			buffer_write(client_buffer, buffer_u8, 0);
			buffer_write(client_buffer, buffer_u8, _i);
			buffer_write(client_buffer, buffer_u8, obj_player.player_num);
			network_send_packet(client, client_buffer, buffer_tell(client_buffer));
		}
	}
}

for (var _i = 0; _i < input_count * 2; _i++)
	last_move[_i] = move[_i];

with (con_client)
{
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.inputs);
	buffer_write(client_buffer, buffer_u8, 1);
	buffer_write(client_buffer, buffer_s16, mouse_x);
	buffer_write(client_buffer, buffer_s16, mouse_y);
	buffer_write(client_buffer, buffer_u8, obj_player.player_num);
	network_send_packet(client, client_buffer, buffer_tell(client_buffer));
}