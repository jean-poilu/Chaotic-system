if (instance_exists(parent_tank))
	parent_tank.bullet_count--;
global.total_bullets--;

var _index = ds_list_find_index(obj_bullet_parent.bullet_id_list, id);
ds_list_delete(obj_bullet_parent.bullet_id_list, _index);

if (destroy_type == "n")
	return;

repeat (irandom_range(3, 5)) {
	var _part = instance_create_layer(x + irandom_range(-5, 5), y + irandom_range(-5, 5), "bullets", obj_default_bullet_particle);

	_part.image_blend = image_blend;

	_part.speed = speed / 2;

	if (destroy_type == "y")
		_part.direction = - direction + random_range(-15, 15);
	else if (destroy_type = "x") {
		_part.direction = 180 - direction + random_range(-15, 15);
	}
	_part.lifespan = 60 + irandom_range(-30, 30);
	
	var _scale = irandom_range(2, 5);
	_part.image_xscale = _scale;
	_part.image_yscale = _scale;
}