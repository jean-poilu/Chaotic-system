ready = false;

function send_ready() {
	var _args = [network.player_ready, ready];
	var _buffer_args = [buffer_u8, buffer_bool];
	network_send(_args, _buffer_args);
}