type_event = ds_map_find_value(async_load, "type");

switch (type_event)
{
	case network_type_data:
		var _buffer = ds_map_find_value(async_load, "buffer");
		buffer_seek(_buffer, buffer_seek_start, 0);
		recieved_packet(_buffer);
		break;
}