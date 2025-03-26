item_power = 0;

title = "";

sold = false;
cant_zoom = false;
price = 0;

function client_buy_item() {
	obj_player.money -= price;
	sold = true;
	image_blend = c_dkgrey;
	
	obj_player.give_item(sprite_index);
	
	var _args = [network.buy_item, obj_player.player_num, title];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_string];
	network_send(_args, _buffer_args);
}