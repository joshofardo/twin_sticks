event_inherited();
state = states.MOVE;
//damage setup
get_damaged_Create(20, true);
//variables for movement
	moveDir = 0;
	moveSpd = 10;
	xspd = 0;
	yspd = 0;
	startKeyPressed = true;

	iframeTimer = 90;
//sprite control
	centerYOffset = -2;
	centerY = y + centerYOffset; //set in step event

	weaponOffsetDist = 25;
	aimDir = 0;

	face = 3;
	sprite[0] = splayerright;
	sprite[1] = splayerup;
	sprite[2] = splayerleft;
	sprite[3] = splayerdown;
	
	dodgeTimer = 45;
	
_iframes = true;
	
	
//weapon info
shootTimer = 0;

//add weapons to player inventory
//array_push(global.PlayerWeapons, global.Weaponlist.startergun);
array_push(global.PlayerWeapons, global.Weaponlist.pinkgun);
//array_push(global.PlayerWeapons, global.Weaponlist.greengun);

SelectedWeapon = 0;
weapon = global.PlayerWeapons[SelectedWeapon];




