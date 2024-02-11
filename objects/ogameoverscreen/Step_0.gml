//get the shoot key input
shootKey = global.shootKey;


//fade in
alpha += alphaSpd;
alpha = clamp(alpha, 0, 1 );

//restart
if global.shootKey && alpha >= 1
{
	room_restart();
}





