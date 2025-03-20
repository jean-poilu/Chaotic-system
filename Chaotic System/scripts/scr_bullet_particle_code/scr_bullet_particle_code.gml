// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_bullet_particle_code(){
	switch (PARTICLE_OBJECT) {
		case obj_default_bullet_particle:
			repeat (irandom_range(3, 5)) {
				var _part = instance_create_layer(x + irandom_range(-5, 5), y + irandom_range(-5, 5), "bullets", obj_default_bullet_particle);

				_part.image_blend = image_blend;

				_part.speed = speed / 2;

				if (destroy_type == "y")
					_part.direction = - direction + random_range(-15, 15);
				else if (destroy_type = "x") {
					_part.direction = 180 - direction + random_range(-15, 15);
				}
	
				var _scale = irandom_range(2, 5);
				_part.image_xscale = _scale;
				_part.image_yscale = _scale;
			}
			
			break;
			
		default:
			break;
	}
}