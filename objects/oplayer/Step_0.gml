switch(state) {
	default:


//get inputs
rightKey = global.rightKey;
leftKey = global.leftKey;
upKey = global.upKey;
downKey = global.downKey;
shootKey = global.shootKey;
swapKeyPressed = global.swapKeyPressed;
startKeyPressed = global.startKeyPressed;
punchKey = global.punchKey;


//pause menu
if startKeyPressed
{
	if !instance_exists(opausemenu)
	{
		instance_create_depth(0, 0, 0, opausemenu);
	}
	else
	{
		instance_destroy(opausemenu);
	}
}

//pause self
if screen_pause() {exit;};
//player movement

#region
	//get direction

	var _horizKey = rightKey - leftKey;
	var _vertKey = downKey - upKey;
	
	moveDir = point_direction(0, 0, _horizKey, _vertKey);
	
	//get the x and y variables
	
	var _spd = 0;
	show_debug_log(_spd);
	
	var _inputLevel = point_distance(0, 0, _horizKey, _vertKey);
	_inputLevel = clamp(_inputLevel, -1, 1);
	_spd = moveSpd * _inputLevel;
	
	xspd = lengthdir_x(_spd, moveDir );
	yspd = lengthdir_y(_spd, moveDir );
	
	 
	//collision
	
if place_meeting( x + xspd, y, owall)
	{
		move_and_collide(_horizKey * moveSpd, _vertKey * moveSpd, owall, 4, 0, 0, 6, 6);
	}
	else if place_meeting( x, y + yspd, owall)
	{
		move_and_collide(_horizKey * moveSpd, _vertKey * moveSpd, owall, 4, 0, 0, 6, 6);
	}
	else 
	{
	//move the player normally
	x += xspd;
	y += yspd;
	}
	
	depth = -bbox_bottom;
	
	#endregion

	flash_from_visibile_and_invisible_after_getting_hit(true);
	get_damage(odamageplayer, true)
	
	
	//get damaged
	if IsDead()
	{
		//screenpause
		create_screen_pause(25);
		//shake the screen
		screen_shake(5);
	}
	
	
	//sprite control
	#region
	//player aiming
		centerY = y + centerYOffset;
		aimDir = point_direction(x, centerY, mouse_x, mouse_y);
		
	//make sure the player is facing the correct direction
	//to change to 45 degree angles change to 45
		
		
		face = round( aimDir/90 );
		if face == 4 {face = 0};
		
		//determine if the player is running forwards or backwards relative to where they are aiming
		if (face == 2) || (face == 0)
		{
			if xspd != 0
			{
				image_speed = 1 * sign(xspd);
			}
			else
			{
				image_speed = 1;
			}
		}
		//same but for y direction
				if (face == 1) || (face == 3)
		{
			if yspd != 0
			{
				image_speed = 1 * sign(yspd);
			}
			else
			{
				image_speed = 1;
			}
		}
		
	
	//animate
	if xspd == 0 && yspd == 0
	{
		image_index = 0;
	}
	
	
	
	//set the player sprite
	mask_index = splayerdown;
	sprite_index = sprite[face];
	#endregion
	
	//weapon swapping 
	#region
	var _playerweapons = global.PlayerWeapons;
	
	//cycle through weapons
	
	if swapKeyPressed
	{
		
		//change the selection and wrap around
		SelectedWeapon++;
		if SelectedWeapon >= array_length(_playerweapons) {SelectedWeapon = 0;};
		

		
	}
			//set the new weapon
		weapon = _playerweapons[SelectedWeapon];
	
	#endregion	
	
	/*//punch
	if punchKey
	{
		
		var _xOffset = lengthdir_x(weapon.length + weaponOffsetDist, aimDir);
		var _yOffset = lengthdir_y(weapon.length + weaponOffsetDist, aimDir);
		
		var _punchInst = instance_create_depth(x + _xOffset, centerY + _yOffset, depth-100, opunch);
	}
	*/
	
	//shoot the weapon
	#region
	if shootTimer > 0 
	{
		shootTimer--; 
	};
	
	if shootKey && shootTimer <= 0
	{
		//reset the timer 
		shootTimer = weapon.cooldown;
		
		screen_shake(1);
		
		//create the bullet

		var _xOffset = lengthdir_x(weapon.length + weaponOffsetDist, aimDir);
		var _yOffset = lengthdir_y(weapon.length + weaponOffsetDist, aimDir);
		
		var _spread  = weapon.spread;
		var _spreadDiv = _spread / max(weapon.bulletNum-1, 1);
		//create the correct number of bullets
		for ( var i = 0; i < weapon.bulletNum; i++)
		{
		
			var _bulletInst = instance_create_depth(x + _xOffset, centerY + _yOffset, depth-100, weapon.bulletobj);
		
		//change bullet's direction
		
		with( _bulletInst )
		{ 
			dir = other.aimDir - _spread/2 + _spreadDiv*i;
			//turn the bullet to the correct direction if needed
			if dirFix == true
			{
				image_angle = dir;
			}
		}
	}
	}
	
	#endregion
	
	//dyin / game over
	if hp <= 0
	{
		//get downed
		instance_create_depth(0, 0, -10000, ogameoverscreen);
		instance_destroy();
		moveSpd = .5;
	}
	break;
}
	


		
	
	
	





