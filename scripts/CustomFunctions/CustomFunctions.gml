//drawing the player's weapon
function;
draw_my_weapon();
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
    draw_sprite_ext(weapon.sprite, 0, x + _xOffset, centerY + _yOffset, 1, _weaponYscl, aimDir, c_white, 1);
}

//vfx
function;
screen_pause();
{
    if instance_exists(oscreenpause)
    {
        image_speed = 0;
        return true;
    } else;
    {
        image_speed = 1;
        return false;
    }
}
function;
create_screen_pause(_time = 5);
{
    with (instance_create_depth(0, 0, 0, oscreenpausetimed)) {
        timer = _time;
    }
}

//player control functions
function;
screen_shake(_amount = 4);
{
    with (ocamera) {
        xShakeAmount = _amount;
        yShakeAmount = _amount;
    }
}
function;
get_inputs();
{
    rightKey = global.rightKey;
    leftKey = global.leftKey;
    upKey = global.upKey;
    downKey = global.downKey;
    shootKey = global.shootKey;
    swapKeyPressed = global.swapKeyPressed;
    startKeyPressed = global.startKeyPressed;
    punchKey = global.punchKey;
    dodgeKey = global.dodgeKey;
}
function;
player_movement();
{
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
    
    xspd = lengthdir_x(_spd, moveDir);
    yspd = lengthdir_y(_spd, moveDir);
}
function;
player_collision();
{
    var _horizKey = rightKey - leftKey;
    var _vertKey = downKey - upKey;
    
    if place_meeting(x + xspd, y, owall)
    {
        move_and_collide(_horizKey * moveSpd, _vertKey * moveSpd, owall, 4, 0, 0, 6, 6);
    } else if place_meeting(x, y + yspd, owall)
    {
        move_and_collide(_horizKey * moveSpd, _vertKey * moveSpd, owall, 4, 0, 0, 6, 6);
    } else;
    {
        //move the player normally
        x += xspd;
        y += yspd;
    }
}
function;
pause_game();
{
    if startKeyPressed {
        if !instance_exists(opausemenu)
        {
            instance_create_depth(0, 0, 0, opausemenu);
        } else;
        {
            instance_destroy(opausemenu);
        }
    }
}
function;
player_shoot();
{
    //shoot the weapon
    #region
    if shootTimer > 0 {
        shootTimer--;
    };
    
    if shootKey && shootTimer <= 0 {
        //reset the timer 
        shootTimer = weapon.cooldown;
        
        screen_shake(3);
        
        //create the bullet
        
        var _xOffset = lengthdir_x(weapon.length + weaponOffsetDist, aimDir);
        var _yOffset = lengthdir_y(weapon.length + weaponOffsetDist, aimDir);
        
        var _spread = weapon.spread;
        var _spreadDiv = _spread / max(weapon.bulletNum - 1, 1);
        //create the correct number of bullets
        for (var i = 0; i < weapon.bulletNum; i++) {
            var _bulletInst = instance_create_depth(x + _xOffset, centerY + _yOffset, depth - 100, weapon.bulletobj);
            
            //change bullet's direction
            
            with (_bulletInst) {
                dir = other.aimDir - _spread / 2 + _spreadDiv * i;
                //turn the bullet to the correct direction if needed
                if dirFix == true {
                    image_angle = dir;
                }
            }
        }
    }
}
function;
sprite_control();
{
    //player aiming
    centerY = y + centerYOffset;
    aimDir = point_direction(x, centerY, mouse_x, mouse_y);
    
    //make sure the player is facing the correct direction
    //to change to 45 degree angles change to 45		
    face = round(aimDir / 90);
    if face == 4 { face = 0;
    };
    
    //determine if the player is running forwards or backwards relative to where they are aiming
    if (face == 2) || (face == 0) {
        if xspd != 0 {
            image_speed = 1 * sign(xspd);
        } else;
        {
            image_speed = 1;
        }
    }
    //same but for y direction
    if (face == 1) || (face == 3) {
        if yspd != 0 {
            image_speed = 1 * sign(yspd);
        } else;
        {
            image_speed = 1;
        }
    }
    //animate
    if xspd == 0 && yspd == 0 {
        image_index = 0;
    }
    //set the player sprite
    mask_index = splayerdown;
    sprite_index = sprite[face];
}
function;
weapon_swapping();
{
    var _playerweapons = global.PlayerWeapons;
    //cycle through weapons
    if swapKeyPressed {
        //change the selection and wrap around
        SelectedWeapon++;
        if SelectedWeapon >= array_length(_playerweapons) { SelectedWeapon = 0; };
    }
    //set the new weapon
    weapon = _playerweapons[SelectedWeapon];
}

//damage calculation
//damage create event
function;
get_damaged_Create(_hp = 10, _iframes = false);
{
    maxHp = _hp;
    hp = _hp;
    
    //get the iframes
    if _iframes {
        show_debug_message("iframes");
        iframeTimer = 90;
        iframeNumber = 90;
    } else;
    {
        show_debug_message("creating ds list");
        damageList = ds_list_create();
    }
}
function;
get_damaged_cleanup();
{
    //DO NOT NEED if we are using iframes, player getting hit should not create a damage list
    show_debug_message("destroying lists");
    ds_list_destroy(damageList);
}

//damage step event
/// @breif applies damage to players and enemies, applies iframes to player
//applies knockback, determines if the enemy target is dead, 
///target is dead, 
/// @params 
/// @return 
function;
get_damage(_damageObj, _iframes = false, _env = false);
{
    var _hitConfirm = false;
    if is_colliding_with_damageObj(_damageObj)
    {
        if _iframes == true {
            //what happens when someone with iframes gets hit
            show_debug_message("hitting box");
            _damageObj.hitConfirm = true;
            hp -= _damageObj.damage;
            create_screen_pause(15);
            screen_shake(10);
            hp = clamp(hp, 0, maxHp);
            if _env == false {
                state = states.KNOCKBACK;
            }
        } else if _iframes == false {
            check_number_of_bullets_colliding_on_that_frame(_damageObj);
            apply_damage_per_bullet(listSize, _damageObj);
            ds_list_destroy(instList);
            
            //clear the damage list of objects that dont exist andmore or are not touching anymore
            var _damageListSize = ds_list_size(damageList);
            for (var i = 0; i < _damageListSize; i++) {
                //if not touching the damage instance anymore, remove it from the list and set the loop back one position
                var _inst = ds_list_find_value(damageList, i);
                if !instance_exists(_inst) || !place_meeting(x, y, _inst)
                        {
                    ds_list_delete(damageList, i);
                    i--;
                    _damageListSize--;
                }
            }
        }
    }
    
    //return hitconfirm variable value
    return _hitConfirm;
}
function;
is_colliding_with_damageObj(_damageObj);
{
    return place_meeting(x, y, _damageObj) ||
            (_damageObj != odamageparent && place_meeting(x, y, odamageall));
}
function;
check_number_of_bullets_colliding_on_that_frame(_damageObj);
{
    //create ds list and copy instances to it
    instList = ds_list_create();
    instance_place_list(x, y, _damageObj, instList, false);
    if _damageObj != odamageparent {
        instance_place_list(x, y, odamageall, instList, false);
        listSize = ds_list_size(instList);
    }
}
function;
apply_damage_per_bullet(listSize, _damageObj);
{
    for (var i = 0; i < listSize; i++) {
        //get a damage object instance from the list, select one of the id's
        var _inst = ds_list_find_value(instList, i);
        
        //check if this instance is already in the damage list
        if _iframes == true || ds_list_find_index(damageList, _inst) == -1 {
            //add the new damage instance to the damage list
            if _iframes == false {
                //add new damage instance to damage list
                ds_list_add(damageList, _inst);
            }
            
            //take damage from specific instance
            hp -= _inst.damage;
            
            //tell the damage instance it has impacted
            _inst.hitConfirm = true;
            path_end();
            if _env == false {
                var _dead = IsDead();
                setupKnockback(_dead, _damageObj);
                calc_path_delay = 60;
                //  make this an argument for get damage function
                alert = true;
                knockback_time = 4;
                if hp > 0 {
                    state = states.KNOCKBACK;
                } else if hp <= 0 {
                    create_screen_pause(5);
                    state = states.DEAD;
                }
            }
        }
    }
}
