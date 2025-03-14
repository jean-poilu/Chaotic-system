var _lc = global.inputs[player_num, 4];
var _rc = global.inputs[player_num, 5];


if (_lc && !last_lc && bullet_count < 3) {
	var _nozzle = nozzle;
	var _bullet_speed = bullet_speed;
	global.temp_player_num = player_num;
	var _bullet = instance_create_layer(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), "bullets", obj_default_bullet,
		{ direction : _nozzle.image_angle, speed : _bullet_speed, image_blend : c_red });
	
	_bullet.parent_tank = id;
	
	bullet_count++;
}



if (_rc && !last_rc && bullet_count < 3) {
	var _nozzle = nozzle;
	var _bullet_speed = bullet_speed;
	global.temp_player_num = player_num;
	global.temp_acc = nozzle.ang_vel;
	var _bullet = instance_create_layer(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), "bullets", obj_curved_bullet,
		{ direction : _nozzle.image_angle, speed : _bullet_speed, image_blend : c_red });
	
	_bullet.parent_tank = id;
	_bullet.acc = nozzle.ang_vel;
	
	bullet_count++;
}


/*
if (_lc && !last_lc && bullet_count < 1) {
	var _nozzle = nozzle;
	global.temp_player_num = player_num;
	var _bullet = instance_create_layer(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), "bullets", obj_laser_bullet,
		{ direction : _nozzle.image_angle, image_blend : c_blue });
	
	_bullet.parent_tank = id;
	
	bullet_count++;
}
*/


speed = 0;

var _ini_x = x;
var _ini_y = y;

var _w = global.inputs[player_num, 0];
var _a = global.inputs[player_num, 1];
var _s = global.inputs[player_num, 2];
var _d = global.inputs[player_num, 3];
var _q = global.inputs[player_num, 6];
var _e = global.inputs[player_num, 7];
var _shift = global.inputs[player_num, 8];
var _space = global.inputs[player_num, 9];

if (_w) {
	if (!_s) {		
		speed = spd;
	}
}

if (_s) {
	if (!_w) {
		speed = -spd;
	}
}

if (_a) {
	if (!_d) {
		image_angle += 3;
		
		direction = image_angle;
		
		for (var _i = 0; _i < 4; _i++) {
		    coins[_i].x = x + dist_point * dcos(direction + angles[_i]) + hspeed;
			coins[_i].y = y - dist_point * dsin(direction + angles[_i]) + vspeed;
		}
		
		if (all_lines(obj_wall)) {
			image_angle -= 3;
		}
	}
}

if (_d) {
	if (!_a) {
		image_angle -= 3;
		
		direction = image_angle;
		
		for (var _i = 0; _i < 4; _i++) {
		    coins[_i].x = x + dist_point * dcos(direction + angles[_i]) + hspeed;
			coins[_i].y = y - dist_point * dsin(direction + angles[_i]) + vspeed;
		}
		
		if (all_lines(obj_wall)) {
			image_angle += 3;
		}
	}
}

direction = image_angle;

if (all_lines(obj_wall)) {
	speed = 0;
}

for (var _i = 0; _i < 4; _i++) {
    coins[_i].x = x + dist_point * dcos(direction + angles[_i]) + hspeed;
	coins[_i].y = y - dist_point * dsin(direction + angles[_i]) + vspeed;
}

if (_e && !last_e && mine_count < 2) {
	var _mine = instance_create_layer(x, y, "mines", obj_default_mine);
	
	_mine.parent_tank = id;
	
	mine_count++;
}

nozzle.x = x + hspeed;
nozzle.y = y + vspeed;

last_lc = _lc;
last_rc = _rc;
last_e = _e;