// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mine_prime(){
	initial_wait = false;
	
	var _mine_num = ds_list_find_index(obj_mine_parent.mine_id_list, id);
	
	var _args = [network.explode_mine, 0, _mine_num];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_u8];
	network_send(_args, _buffer_args);
	
	sprite_index = PRIMED_SPRITE;
}