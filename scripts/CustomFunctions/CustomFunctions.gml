//drawing the player's weapon
function draw_my_weapon()
{
	//draw the weapon
//get weapon off the players body
var _xOffset = lengthdir_x(weaponOffsetDist, aimDir);
var _yOffset = lengthdir_y(weaponOffsetDist, aimDir);


//flip weapon 
	var _weaponYscl = 1;
	/*
	if aimDir > 90 && aimDir < 270
	{
		_weaponYscl = -1;
	}
*/
	draw_sprite_ext(weapon.sprite,0,x + _xOffset, centerY + _yOffset, 1, _weaponYscl, aimDir, c_white, 1)
}

//vfx
//pause self

function screen_pause()
{
	if instance_exists(oscreenpause)
	{
		image_speed = 0;
		return true;
	}
	else
	{
		image_speed = 1;
		return false;
	}
}
function create_screen_pause(_time = 5)
{
	
	with (instance_create_depth(0, 0, 0, oscreenpausetimed))
	{
		timer = _time;
	}
}
function screen_shake(_amount = 4)
{
	
	with(ocamera)
	{
		xShakeAmount = _amount;
		yShakeAmount = _amount;
	
	}
}

//damage calculation
	//damage create event
	function get_damaged_Create(_hp = 10, _iframes = false)
	{
		maxHp = _hp;
		hp = _hp;
			
		//get the iframes
		if _iframes
		{
			show_debug_message("iframes");
			iframeTimer = 0;
			iframeNumber = 90;
		}
		else 
		{
			show_debug_message("creating ds list")
			damageList = ds_list_create();
		}
	
	}

	//damage clean up
	function get_damaged_cleanup()
	{
		//DO NOT NEED if we are using iframes
		show_debug_message("destroying lists");
		//delete our damage list data structure to free memory
		ds_list_destroy(damageList);
	}
	
	//damage step event
	/// @breif applies damage to players and enemies, applies iframes to player
	//applies knockback, determines if the enemy target is dead, 
	///target is dead, 
	/// @params 
	/// @return 
	function get_damage(_damageObj, _iframes = false)
	{
		//receive damage
			var _hitConfirm = false;
			if is_colliding_with_bullet(_damageObj)
			{	
				//getting a list of damage instances
				//create ds list and copy instances to it
					var _instList = ds_list_create();
					instance_place_list(x, y, _damageObj, _instList, false);
					if _damageObj != odamageparent
					{
						instance_place_list(x, y, odamageall, _instList, false);
					}
				//get the size of our list
					var _listSize = ds_list_size(_instList);
				
				//loop through the list
					for(var i = 0; i < _listSize; i++ )
					{		
						//get a damage object instance from the list, select one of the id's
						var _inst = ds_list_find_value( _instList, i);
		
						//check if this instance is already in the damage list
						if _iframes == true || ds_list_find_index( damageList, _inst) == -1
							{
								//add the new damage instance to the damage list
								if _iframes == false
								{
									//add new damage instance to damage list
									ds_list_add(damageList, _inst);
								}
							
								//take damage from specific instance
								hp -= _inst.damage;
								//tell the damage instance it has impacted
								_inst.hitConfirm = true;	
								_hitConfirm = true;
								show_debug_message("hit confirm");
								var _dead = IsDead();
								path_end();
								//set a knockback distance
								//if the enemy IS not dead
								
								//callculating enemy knockback
								var _dis = _dead ? 30 : 4;
								var _dir = _damageObj.dir;
								hsp += lengthdir_x(_dis, _dir);
								vsp += lengthdir_y(_dis, _dir);
								
								calc_path_delay = 60;//  make this an argument for get damage function
								alert = true;
								knockback_time = 4;
								show_debug_message("kb")
								if !_dead 
								{
									show_debug_message("switching to kb state");
									state = states.KNOCKBACK;
								}
							}
					}
			
				//set iframes if we were hit
				if _iframes == true && _hitConfirm == true
				{
				
					show_debug_message("ouch");
					iframeTimer = iframeNumber;
				}						
	
			//free memory by destroying ds_list
			ds_list_destroy( _instList );
			}

			if _iframes == false
			{
					//clear the damage list of objects that dont exist andmore or are not touching anymore
				var _damageListSize = ds_list_size(damageList);
				for(var i = 0; i < _damageListSize; i++)
				{
					//if not touching the damage instance anymore, remove it from the list and set the loop back one position
					var _inst = ds_list_find_value(damageList, i);
					if !instance_exists(_inst) || !place_meeting(x, y, _inst)
					{
						ds_list_delete(damageList, i );
						i--;
						_damageListSize--;
					}
				}	
		}
	
	//clamp hp
	hp = clamp(hp, 0, maxHp);

	//return hitconfirm variable value
	return _hitConfirm;

		}

function flash_from_visibile_and_invisible_after_getting_hit(_iframes = false)
{
	
			if _iframes && iframeTimer > 0
		{
			show_debug_message("iframes true");
		
			iframeTimer--;
			show_debug_message(iframeTimer);
			if iframeTimer mod 5 == 0
			{
				show_debug_message("flashing");
				if image_alpha == 1
				{
					image_alpha = 0;
				}else{
					image_alpha = 1;
				}
			}
		
			//clamp hp
			hp = clamp(hp, 0, maxHp);
		
			//exit by returning the function as false
			return false;

		}
		else if !_iframes
		//make sure iframe blinking stops
		{
			image_alpha = 1;
		}
}
function is_colliding_with_bullet(_damageObj)
{
	return place_meeting( x, y, _damageObj) || 
	(_damageObj != odamageparent && place_meeting(x, y, odamageall))
}


	

