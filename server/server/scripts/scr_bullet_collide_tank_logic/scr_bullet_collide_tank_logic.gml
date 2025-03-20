// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_collide_tank_logic(_type){
	var _tank = instance_place(x + hspeed, y, obj_tank);
	
	if (_tank == parent_tank && !can_hit_parent_tank)
		return;
	
	_tank.death_cause = id;
	with (_tank) {
		instance_destroy();
	}
	
	
	if (_tank != parent_tank)
		player_list[parent_tank.player_num].add_money(100 - bullet_power);
	
	
	destroy_type = _type;
	instance_destroy();
}