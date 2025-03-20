// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_destroy_code(){
	var _index = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
	ds_list_delete(obj_bullet_parent.bullet_id_list, _index);

	if (destroy_type == "n")
		return;

	scr_bullet_particle_code();
}