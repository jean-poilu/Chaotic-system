instance_create_layer(x, y, "bullets", obj_default_explosion);

if (instance_exists(parent_tank))
	parent_tank.mine_count--;

var _index = ds_list_find_index(obj_mine_parent.mine_id_list, id);
ds_list_delete(obj_mine_parent.mine_id_list, _index);