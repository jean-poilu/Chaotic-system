spd = 5;

parent_tank = noone;

can_hit_parent_tank = false;

destroy_type = "n";

ds_list_add(obj_bullet_parent.bullet_id_list, id);

speed = 1;
while (!place_meeting(x, y, obj_wall)) {
	motion_add(direction, speed);
}

laser_pos = [xstart, ystart, x, y];

alarm[1] = 10;

global.total_bullets++;

if (global.total_bullets > 10) {
	instance_destroy();
	exit;
}

var _x = x;
var _y = y;
var _d = direction;
var _s = 0;
var _acc = 0;
var _t = ds_list_find_index(obj_bullet_parent.bullet_list, "obj_default_bullet");
var _player_num = global.temp_player_num;
var _color = scr_get_color(image_blend);

var _args = [network.create_bullet, _x, _y, _d, _s, _acc, _t, _player_num, _color];
var _buffer_args = [buffer_u8, buffer_f16, buffer_f16, buffer_f16, buffer_f16, buffer_f16, buffer_u8, buffer_u8, buffer_string];
network_send(_args, _buffer_args);