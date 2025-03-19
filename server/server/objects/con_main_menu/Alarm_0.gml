instance_create_layer(0, 0, "Instances", con_client);
ini_open("save");
ini_write_string("Info", "address", global.address);
ini_write_string("Info", "username", global.username);
ini_close();