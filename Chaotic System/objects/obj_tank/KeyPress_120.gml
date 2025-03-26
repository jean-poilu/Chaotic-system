with (con_client) 
{
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.give_money);
	buffer_write(client_buffer, buffer_u8, obj_player.player_num);
	buffer_write(client_buffer, buffer_u16, 100);
	network_send_packet(client, client_buffer, buffer_tell(client_buffer));
}