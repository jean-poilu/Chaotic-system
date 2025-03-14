// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_get_color(_col){
	var _str = "";
	
	_str += scr_dec_to_hex(color_get_red(_col));
	_str += scr_dec_to_hex(color_get_green(_col));
	_str += scr_dec_to_hex(color_get_blue(_col));
	
	return _str;
}