if (place_meeting(x + hspeed, y, obj_wall)) {
	destroy_type = "x";
	instance_destroy();
}
if (place_meeting(x, y + vspeed, obj_wall)) {
	destroy_type = "y";
	instance_destroy();
}

if (place_meeting(x, y, obj_tank)) {
	
	var _tank = instance_place(x, y, obj_tank);
	
	if (_tank == parent_tank && !can_hit_parent_tank)
		return;
	
	
	
	
	
	
	
	instance_destroy();
}