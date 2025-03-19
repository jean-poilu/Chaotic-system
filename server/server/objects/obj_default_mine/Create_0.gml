initial_wait = true;
exploding = false;

parent_tank = noone;

var _x = x;
var _y = y;
var _t = ds_list_find_index(obj_mine_parent.mine_list, "obj_default_mine");
var _color = scr_get_color(image_blend);

var _args = [network.create_mine, _x, _y, _t, _color];
var _buffer_args = [buffer_u8, buffer_f16, buffer_f16, buffer_u8, buffer_string];
network_send(_args, _buffer_args);

ds_list_add(obj_mine_parent.mine_id_list, id);

function explode() {
	sprite_index = spr_mine_explode;
	
	alarm[0] = 20;
	exploding = true;
	
	var _mine_num = ds_list_find_index(obj_mine_parent.mine_id_list, id);
	
	var _args = [network.explode_mine, 1, _mine_num];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_u8];
	network_send(_args, _buffer_args);
}