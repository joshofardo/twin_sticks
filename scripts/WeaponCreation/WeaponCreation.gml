//constructor template for weapons
function create_weapon( _sprite = sgun, _length = 0, _bulletobj = owhitebullet, _cooldown = 1, _bulletNum = 1, _spread = 0, _pickupSprite = sgunpickup ) constructor


	{
	sprite = _sprite;
	length = _length;
	bulletobj = _bulletobj;
	cooldown = _cooldown;
	bulletNum = _bulletNum;
	spread = _spread;
	pickupSprite = _pickupSprite;
	}
 
 //the player's weapon inventory
 global.PlayerWeapons = array_create(0);
 
 
 //the weapons
 
 global.Weaponlist  = {
	 
 
	startergun : new create_weapon(
		sgun,
		sprite_get_bbox_right(sgun) - sprite_get_xoffset(sgun),
		owhitebullet,
		9, 
		10,
		40,
		sgunpickup
		), 
	pinkgun : new create_weapon(
		sgun2,
		sprite_get_bbox_right(sgun2) - sprite_get_xoffset(sgun2),
		opinkbullet,
		7,
		1,
		0,
		sgun2pickup
		),
	greengun : new create_weapon(
		sgun3,
		sprite_get_bbox_right(sgun3) - sprite_get_xoffset(sgun3),
		ogreenbullet,
		15, 
		7, 
		45,
		sgun3pickup
		),
 }
 
 
 