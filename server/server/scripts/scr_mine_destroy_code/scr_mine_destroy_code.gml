// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_mine_destroy_code(){
	instance_create_layer(x, y, "bullets", EXPLOSION_OBJECT);
	
	if (instance_exists(parent_tank))
		parent_tank.mine_count--;

	var _index = ds_list_find_index(obj_mine_parent.mine_id_list, id);
	ds_list_delete(obj_mine_parent.mine_id_list, _index);
}