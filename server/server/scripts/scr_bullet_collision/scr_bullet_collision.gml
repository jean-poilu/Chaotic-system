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

	scr_bullet_collide_tank();

	scr_bullet_collide_mine();
}