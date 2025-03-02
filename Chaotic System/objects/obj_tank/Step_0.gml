if (mouse_check_button_pressed(mb_left)) {
	var _bullet = instance_create_layer(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), "bullets", obj_default_bullet);
	
	_bullet.image_blend = c_red;
	_bullet.hspeed = _bullet.spd * dcos(point_direction(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), mouse_x, mouse_y));
	_bullet.vspeed = - _bullet.spd * dsin(point_direction(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), mouse_x, mouse_y));
}

var _w = keyboard_check(ord("W"));
var _a = keyboard_check(ord("A"));
var _s = keyboard_check(ord("S"));
var _d = keyboard_check(ord("D"));

if (_w) {
	if (!_s) {		
		x -= spd*sin(pi/180*image_angle);
		y -= spd*cos(pi/180*image_angle);
	}
}

if (_s) {
	if (!_w) {
		x += spd*sin(pi/180*image_angle);
		y += spd*cos(pi/180*image_angle);
		
	}
}

if (_a) {
	if (!_d) {
		image_angle += 2;
	}
}

if (_d) {
	if (!_a) {
		image_angle -= 2;
	}
}

show_debug_message(vspeed);

if (abs(vspeed) > spd)
	vspeed = sign(vspeed) * spd;
	
if (abs(hspeed) > spd)
	hspeed = sign(hspeed) * spd;

nozzle.x = x + hspeed;
nozzle.y = y + vspeed;