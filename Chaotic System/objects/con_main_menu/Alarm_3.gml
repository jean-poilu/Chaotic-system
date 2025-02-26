if (ds_queue_empty(queue)) {
	is_drawing = false;
	alarm[3] = 1;
	return;
}
is_drawing = true;

if (ds_queue_head(queue) == "GOTO LOBBY") {
	room_goto(rm_waiting_room);
	ds_queue_dequeue(queue);
	ds_queue_dequeue(wait_queue);
	alarm[3] = 1;
	exit;
}
if (ds_queue_head(queue) == "CREATE CLIENT") {
	global.own_server = true;
	instance_create_depth(0, 0, 0, con_client);
	ds_queue_dequeue(queue);
	ds_queue_dequeue(wait_queue);
	alarm[3] = 1;
	exit;
}

if (line_num >= 19) {
	past_string = ds_queue_head(queue);
	line_num = 0;
}
else
	past_string += ds_queue_head(queue);
	
ds_queue_dequeue(queue);

line_num += 1;

var _wait_time = ds_queue_head(wait_queue);
ds_queue_dequeue(wait_queue);
alarm[3] = _wait_time;