username = "";
player_num = 0;
color_num = 0;
socket = 0;

money = 1000;

function add_money(_amount) {
	money += 100;
	
	var _args = [network.give_money, player_num, _amount];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_u16];
	network_send(_args, _buffer_args);
}