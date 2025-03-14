// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_string_to_color(_str){
	var _red = string_char_at(_str, 1);
	_red += string_char_at(_str, 2);
	_red = scr_hex_to_dec(_red);
	
	var _green = string_char_at(_str, 3);
	_green += string_char_at(_str, 4);
	_green = scr_hex_to_dec(_green);
	
	var _blue = string_char_at(_str, 5);
	_blue += string_char_at(_str, 6);
	_blue = scr_hex_to_dec(_blue);
	
	return make_color_rgb(_red, _green, _blue);
}