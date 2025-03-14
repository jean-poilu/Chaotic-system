/* if (mouse_check_button_pressed(mb_left) && bullet_count < 3) {
	var _bullet = instance_create_layer(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), "bullets", obj_default_bullet);
	
	_bullet.image_blend = c_red;
	_bullet.direction = nozzle.image_angle;
	_bullet.speed = bullet_speed;
	
	_bullet.parent_tank = id;
	bullet_count++;
}

speed = 0;

var _ini_x = x;
var _ini_y = y;

var _w = keyboard_check(ord("W"));
var _a = keyboard_check(ord("A"));
var _s = keyboard_check(ord("S"));
var _d = keyboard_check(ord("D"));

if (_w) {
	if (!_s) {		
		// x -= spd*sin(pi/180*image_angle);
		// y -= spd*cos(pi/180*image_angle);
		speed = spd;
	}
}

if (_s) {
	if (!_w) {
		// x += spd*sin(pi/180*image_angle);
		// y += spd*cos(pi/180*image_angle);
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
		
		if (all_lines()) {
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
		
		if (all_lines()) {
			image_angle += 3;
		}
	}
}

direction = image_angle;

if (all_lines()) {
	speed = 0;
}

for (var _i = 0; _i < 4; _i++) {
    coins[_i].x = x + dist_point * dcos(direction + angles[_i]) + hspeed;
	coins[_i].y = y - dist_point * dsin(direction + angles[_i]) + vspeed;
}

nozzle.x = x + hspeed;
nozzle.y = y + vspeed;

