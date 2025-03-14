// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function scr_unstuck(_obj){
	if (place_meeting(x, y, _obj))
	{
		var _moved = 0;
		var _start_moved = 0;
		var _multiplier = 1;
		var _part = instance_place(x, y, _obj);
		var _attempt = 0;
		while (place_meeting(x, y, _obj))
		{
			_start_moved = _moved;
			if (_attempt > 1000)
			{
				show_message(string(_moved));
				break;
			}
			if (x > _part.x + 32 && !place_meeting(x + _multiplier, y, _obj))
			{
				x += _multiplier;
				_moved++;
			}
			else if (!place_meeting(x - _multiplier, y, _obj))
			{
				x -= _multiplier;
				_moved++;
			}
		
			if (y > _part.y + 32 && !place_meeting(x, y + _multiplier, _obj))
			{
				y += _multiplier;
				_moved++;
			}
			else if (!place_meeting(x, y - _multiplier, _obj))
			{
				y -= _multiplier;
				_moved++;
			}
		
			if (_moved == _start_moved)
			{
				_multiplier++;
			}
			else
				_multiplier = 1;
			_attempt++;
		}
	}
}