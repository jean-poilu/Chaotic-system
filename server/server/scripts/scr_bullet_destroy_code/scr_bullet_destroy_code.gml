// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_destroy_code(){
	if (instance_exists(parent_tank))
		parent_tank.bullet_count--;
	global.total_bullets--;
	
	if (destroy_type == "n")
		return;
	
	var _bullet_num = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
	
	// show_message("sending destroy code to clients: " + string(_bullet_num) + " " + destroy_type);

	var _args = [network.destroy_bullet, _bullet_num, destroy_type];
	var _buffer_args = [buffer_u8, buffer_u8, buffer_string];
	network_send(_args, _buffer_args);
	
	ds_list_delete(obj_bullet_parent.bullet_id_list, _bullet_num);

	scr_bullet_particle_code();
}

