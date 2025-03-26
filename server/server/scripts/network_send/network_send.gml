// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
/**
 * function to send packets over the network
*/
function network_send(_args, _buffer_args){
	
	with (con_server)
	{
		var _i = 0;
		repeat(ds_list_size(socket_list))
		{
			var _sock = ds_list_find_value(socket_list, _i);
		
			buffer_seek(server_buffer, buffer_seek_start, 0);
			
			var _array_length = array_length(_args);
			
			for (var _j = 0; _j < _array_length; _j++)
				buffer_write(server_buffer, _buffer_args[_j], _args[_j]);
			
			network_send_packet(_sock, server_buffer, buffer_tell(server_buffer));
				
			_i++;
		}
	}
	
}