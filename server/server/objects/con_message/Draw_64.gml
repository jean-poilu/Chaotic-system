if (!center)
	draw_set_halign(fa_left);
draw_text_transformed_color(camera_get_view_x(view_camera[0]) + x,camera_get_view_y(view_camera[0]) + y, msg, xscale, yscale, angle, clr, clr, clr, clr, alpha);
draw_set_halign(fa_center);
if (start_fading)
	alpha -= fade_rate;

if (alpha <= 0)
	instance_destroy();