// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_create_code(){
	alarm[0] = 3;
	
	ds_list_add(obj_bullet_parent.bullet_id_list, id);
	
	global.total_bullets++;

	if (global.total_bullets > 10) {
		instance_destroy();
		exit;
	}

	var _x = x;
	var _y = y;
	var _d = direction;
	var _s = speed;
	var _acc = global.temp_acc;
	var _t = ds_list_find_index(obj_bullet_parent.bullet_list, BULLET_TYPE);
	var _player_num = global.temp_player_num;
	var _color = scr_get_color(image_blend);

	var _args = [network.create_bullet, _x, _y, _d, _s, _acc, _t, _player_num, _color];
	var _buffer_args = [buffer_u8, buffer_f16, buffer_f16, buffer_f16, buffer_f16, buffer_f16, buffer_u8, buffer_u8, buffer_string];
	network_send(_args, _buffer_args);
}