// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mine_create_code(){
	var _x = x;
	var _y = y;
	var _t = ds_list_find_index(obj_mine_parent.mine_list, MINE_TYPE);
	var _color = scr_get_color(image_blend);

	var _args = [network.create_mine, _x, _y, _t, _color];
	var _buffer_args = [buffer_u8, buffer_f16, buffer_f16, buffer_u8, buffer_string];
	network_send(_args, _buffer_args);

	ds_list_add(obj_mine_parent.mine_id_list, id);
}