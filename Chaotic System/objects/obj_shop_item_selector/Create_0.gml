pors = "null";


function create_items(_page_num) {
	
	var _limit = _page_num * 4 + 4;
	if (_page_num * 4 + 4 > ds_list_size(obj_player.item_list))
		_limit = ds_list_size(obj_player.item_list);
	
	for (var _i = _page_num * 4; _i < _page_num * 4 + 4; _i++) {
	
		var _sel = instance_create_layer(x - 230 + _i * 150, y, "selector", obj_shop_select_item);
		_sel.sprite_index = ds_list_find_value(obj_player.item_list, _i);
		var _str = string_split(ds_map_find_value(obj_shop_item_parent.item_map, _sel.sprite_index), " ", false, 2);
		_sel.title = _str[0];
		_sel.update_pors();
		if (ds_list_size(obj_player.item_list) > 4)
			_sel.scroll_bar = string(_page_num) + "/" + "";
	}
}