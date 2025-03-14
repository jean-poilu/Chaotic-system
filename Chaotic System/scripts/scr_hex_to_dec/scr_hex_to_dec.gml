// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_hex_to_dec(_hex) {
    var _dec = 0;
 
    var _dig = "0123456789ABCDEF";
    var _len = string_length(_hex);
    for (var pos = 1; pos <= _len; pos += 1) {
        _dec = _dec << 4 | (string_pos(string_char_at(_hex, pos), _dig) - 1);
    }
 
    return _dec;
}