weapon = global.Weaponlist.pinkgun

floatDir = 0;
floatSpd = 6;

//set the weapon index based on image index
if image_index == 0
{
	weapon = global.Weaponlist.startergun;
}
if image_index == 1
{
	weapon = global.Weaponlist.pinkgun;
}
if image_index == 2
{
	weapon = global.Weaponlist.greengun;
}

sprite_index = weapon.pickupSprite;
image_index = 0;


//does the player already have one of these
var _size = array_length(global.PlayerWeapons);
for(var i = 0; i < _size; i++)
{
	//check if weapon is already in the player's weapon list
	if weapon == global.PlayerWeapons[i]
	{
		instance_destroy();
	}
}
