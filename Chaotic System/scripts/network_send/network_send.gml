// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function network_send(_args, _buffer_args){
	with (con_client) 
	{
		buffer_seek(client_buffer, buffer_seek_start, 0);
		for (var _i = 0; _i < array_length(_args); _i++)
			buffer_write(client_buffer, _buffer_args[_i], _args[_i]);
		network_send_packet(client, client_buffer, buffer_tell(client_buffer));
	}
}