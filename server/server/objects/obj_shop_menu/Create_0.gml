readys = 0;

function start_if_ready() {
	if (readys == ds_list_size(con_server.socket_list)) {
		var _args = [network.go, ds_list_size(con_server.socket_list)];
		var _buffer_args = [buffer_u8, buffer_u8];
		network_send(_args, _buffer_args);
		
		room_goto(rm_fight);
	}
}