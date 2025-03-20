// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_collision(){
	if (place_meeting(x + hspeed, y, obj_wall)) {
		destroy_type = "x";
		instance_destroy();
	}
	
	if (place_meeting(x, y + vspeed, obj_wall)) {
		destroy_type = "y";
		instance_destroy();
	}

	if (place_meeting(x + hspeed, y, obj_tank)) {
	
		var _tank = instance_place(x + hspeed, y, obj_tank);
	
		if (_tank == parent_tank && !can_hit_parent_tank)
			return;
	
		destroy_type = "x";
		instance_destroy();
	}

	if (place_meeting(x, y + vspeed, obj_tank)) {
	
		var _tank = instance_place(x, y + vspeed, obj_tank);
	
		if (_tank == parent_tank && !can_hit_parent_tank)
			return;
	
		destroy_type = "y";
		instance_destroy();
	}
}