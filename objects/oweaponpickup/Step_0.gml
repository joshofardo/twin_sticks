
//FLOAT IN PLACE
if screen_pause() {exit;};

floatDir += floatSpd;
y = ystart + dsin(floatDir)*5;

//does the player already have one of these
var _size = array_length(global.PlayerWeapons);
for(var i = 0; i < _size; i++)
{
	//check if weapon is already in the player's weapon list
	if weapon == global.PlayerWeapons[i]
	{
		instance_destroy();
		exit;
	}
}


//add weapon to players weapon list
if place_meeting(x, y, oplayer)
{
	//add the weapon
	array_push(global.PlayerWeapons, weapon);
	
	
	//set as the player's weaPON
	oplayer.SelectedWeapon = array_length(global.PlayerWeapons) - 1;
	
	
	//destroy
	instance_destroy();
}
