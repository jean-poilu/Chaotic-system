// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_collide_tank(){
	if (place_meeting(x + hspeed, y, obj_tank)) {
		scr_bullet_collide_tank_logic("x");
	}
	
	if (place_meeting(x, y + vspeed, obj_tank)) {
		scr_bullet_collide_tank_logic("y");
	}
}