if (place_meeting(x, y, obj_mine_parent)) {
	var _mine = instance_place(x, y, obj_mine_parent);
	
	_mine.explode();
	
	var _bullet_num = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
}