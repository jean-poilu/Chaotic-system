if (check_key(6))
{
	if (instance_exists(global.players) && !death_cooldown)
		die();
}