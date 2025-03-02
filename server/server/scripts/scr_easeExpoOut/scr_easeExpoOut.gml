// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_easeExpoOut(_start, _end, _step) {
	if (_step == 1)
		return 1;
	return _start + (1 - power(2, -10 * _step)) * (_end - _start);
}