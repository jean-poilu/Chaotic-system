nozzle = instance_create_layer(x, y, "tanks", obj_nozzle);


player_num = -1;



nozzle.tank = id;

death_cause = noone;

spd = 2;
acc = 0.3;

rotation_speed = 3;

coins = [instance_create_depth(x - sprite_width / 2, y - sprite_height / 2, 0, Point), 
		 instance_create_depth(x + sprite_width / 2, y - sprite_height / 2, 0, Point),
		 instance_create_depth(x - sprite_width / 2, y + sprite_height / 2, 0, Point),
		 instance_create_depth(x + sprite_width / 2, y + sprite_height / 2, 0, Point)]

dist_point = point_distance(x, y, coins[0].x, coins[0].y);
angles = [point_direction(x, y, coins[0].x, coins[0].y),
		  point_direction(x, y, coins[1].x, coins[1].y),
		  point_direction(x, y, coins[2].x, coins[2].y),
		  point_direction(x, y, coins[3].x, coins[3].y)];


function coll_line(_c1, _c2, _obj) {
	return (collision_line(_c1.x + hspeed, _c1.y + vspeed, _c2.x + hspeed, _c2.y + vspeed, _obj, true, false) != noone);
}

function all_lines(_obj) {
	if (coll_line(coins[0], coins[1], _obj))
		return true;

	if (coll_line(coins[1], coins[3], _obj))
		return true;

	if (coll_line(coins[3], coins[2], _obj))
		return true;

	if (coll_line(coins[2], coins[0], _obj))
		return true;
	
	return false;
}

bullet_count = 0;
bullet_speed = 5;
mine_count = 0;

ang_vel = 0;
last_angles = ds_list_create();
prev_direction = direction;

last_lc = 0;
last_rc = 0;
last_e = 0;