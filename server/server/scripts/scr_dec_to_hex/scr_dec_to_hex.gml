// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_dec_to_hex(_dec, _len = 2){
	var _hex = "";
 
	if (_dec < 0) {
	    _len = max(_len, ceil(logn(16, 2 * abs(_dec))));
	}
 
	var dig = "0123456789ABCDEF";
	while (_len-- || _dec) {
	    _hex = string_char_at(dig, (_dec & $F) + 1) + _hex;
	    _dec = _dec >> 4;
	}
 
	return _hex;
}