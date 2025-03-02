with (con_client) 
{
	buffer_seek(client_buffer, buffer_seek_start, 0);
	buffer_write(client_buffer, buffer_u8, network.move0);
	buffer_write(client_buffer, buffer_u16, mouse_x);
	buffer_write(client_buffer, buffer_u16, mouse_y);
	network_send_packet(client, client_buffer, buffer_tell(client_buffer));
}