// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_tank_create_bullet(_obj){
	var _nozzle = nozzle;
	var _bullet_speed = bullet_speed;
	global.temp_player_num = player_num;
	global.temp_acc = nozzle.ang_vel;
	var _bullet = instance_create_layer(x + 32 * dcos(nozzle.image_angle), y - 32 * dsin(nozzle.image_angle), "bullets", _obj,
		{ direction : _nozzle.image_angle, speed : _bullet_speed, image_blend : c_red });
	
	_bullet.parent_tank = id;
	_bullet.acc = nozzle.ang_vel;
	
	bullet_count++;
}