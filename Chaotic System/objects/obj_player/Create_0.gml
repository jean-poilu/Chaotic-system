username = "";
player_num = 0;
color_num = 0;
socket = 0;

money = 0;

function add_money(_amount) {
	
	if (instance_exists(obj_money_display)) {
		var _money = instance_find(obj_money_display, 0);
		_money.alarm[0] = 60;
		
		if (_money.progress == 0) {
			_money.addition += _amount;
		}
		else if (_money.progress == 1) {
			_money.add_y = _money.ini_add_y;
			_money.acc = 0;
			_money.progress = 0;
			_money.addition += _amount;
		}
		else if (_money.progress == 2) {
			_money.addition = _amount;
			_money.acc = 0;
			_money.progress = 0;
			_money.add_y = _money.ini_add_y;
		}
		else if (_money.progress == 3) {
			_money.addition = _amount;
			_money.acc = 0;
			_money.progress = 0;
			_money.add_y = _money.ini_add_y;
			_money.alpha = 1;
		}
		
	
	}
	else {
		var _money = instance_create_layer(0, 0, "HUD", obj_money_display);
		_money.addition = _amount
		_money.money = money;
	}
	
	money += _amount;
}