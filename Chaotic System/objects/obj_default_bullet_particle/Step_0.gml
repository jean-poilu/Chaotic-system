visible = true;

speed = speed * random_range(0.9, 0.999);

var rand_vis = irandom_range(odds, lifespan);

if (rand_vis >= lifespan - lifespan / 10) {
	visible = false;
}

odds++;