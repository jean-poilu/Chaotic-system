global.session_msg = "";
global.messages = 0;
global.number_of_players = 0;
global.tanks[4] = noone;
for (var _i = 0; _i < 4; _i++)
	global.tanks[_i] = noone;

randomize();

instance_create_depth(0, 0, 0, con_main_menu);