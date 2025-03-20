if (exploding)
	return;

if (!instance_exists(obj_tank))
	return;

var _distance = point_distance(x, y, parent_tank.x, parent_tank.y);
var _nearest = point_distance(x, y, instance_nearest(x, y, obj_tank).x, instance_nearest(x, y, obj_tank).y);

if (initial_wait && _distance > 135) {
	scr_mine_prime();
}
else if (!initial_wait && _nearest < 120) {
	scr_mine_explode();
}