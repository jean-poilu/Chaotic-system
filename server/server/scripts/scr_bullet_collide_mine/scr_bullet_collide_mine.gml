// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_collide_mine(){
	if (place_meeting(x, y, obj_mine_parent)) {
		var _mine = instance_place(x, y, obj_mine_parent);
	
		_mine.explode();
	
		var _bullet_num = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
	
		var _args = [network.destroy_bullet, _bullet_num, "n"];
		var _buffer_args = [buffer_u8, buffer_u8, buffer_string];
		network_send(_args, _buffer_args);
	
		destroy_type = "n";
		instance_destroy();
	}
}