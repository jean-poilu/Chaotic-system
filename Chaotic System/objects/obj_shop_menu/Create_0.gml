randomize();

instance_create_depth(0, 0, 0, obj_shop_item_parent);

mouse = instance_create_depth(0, 0, 0, Point);

var _player = instance_create_depth(0, 0, 0, obj_player);
_player.money = 1000;

draw_set_font(fnt_font);

item_list = ds_list_create();
power_list = ds_list_create();
name_list = ds_list_create();

function add_to_lists(_spr, _pow) {
	ds_list_add(item_list, _spr);
	ds_list_add(power_list, _pow);
	ds_list_add(name_list, ds_map_find_value(obj_shop_item_parent.item_map, _spr));
}

add_to_lists(spr_item_big_ball, 20);
add_to_lists(spr_item_bouncy, 30);
add_to_lists(spr_item_random, 50);
add_to_lists(spr_item_split, 50);
add_to_lists(spr_item_laser, 90);

available_list = ds_list_create();
available_power_list = ds_list_create();
available_name_list = ds_list_create();

current_item = ds_list_find_value(item_list, 0);
current_power = ds_list_find_value(power_list, 0);
current_name = ds_list_find_value(name_list, 0);
next_power = current_power;

var _i = 0;

while (next_power <= obj_player.money / 10 && _i < ds_list_size(item_list)) {
	
	current_item = ds_list_find_value(item_list, _i);
	current_power = ds_list_find_value(power_list, _i);
	current_name = ds_list_find_value(name_list, _i);
	
	ds_list_add(available_list, current_item);
	ds_list_add(available_power_list, current_power);
	ds_list_add(available_name_list, current_name);
	
	next_power = ds_list_find_value(power_list, _i + 1);
	
	_i++;
}


var _x_forth = camera_get_view_width(view_camera[0]) / 4;

var _item_count = 3;

if (ds_list_size(available_list) < 3)
	_item_count = ds_list_size(available_list);

for (_i = 0; _i < _item_count; _i++) {
	var _rand_val = irandom(ds_list_size(available_list) - 1);
	
	var _item = instance_create_layer(_x_forth * (_i + 1), 290, "HUD", obj_shop_item);
	
	_item.item_power = ds_list_find_value(available_power_list, _rand_val);
	_item.price = _item.item_power * irandom_range(5, 10);
	_item.sprite_index = ds_list_find_value(available_list, _rand_val);
	_item.title = ds_list_find_value(available_name_list, _rand_val);
	_item.image_xscale = 4;
	_item.image_yscale = 4;
	
	
	ds_list_delete(available_list, _rand_val);
	ds_list_delete(available_power_list, _rand_val);
	ds_list_delete(available_name_list, _rand_val);
}

shake = false;
strength = 0;
shmx = 0;
shmy = 0;

function shake_money() {
	shake = true;
	strength = 50;
}