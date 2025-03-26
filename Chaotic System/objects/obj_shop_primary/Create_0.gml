sprite_index = obj_player.primary;
image_xscale = 4;
image_yscale = 4;

title = ds_map_find_value(obj_shop_item_parent.item_map, sprite_index);

tool_tip = noone;

selector_window = noone;

function update_sprite() {
	sprite_index = obj_player.primary;
}