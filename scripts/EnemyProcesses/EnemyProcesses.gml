function calc_entity_movement()

{
	//apply movement
	x += hsp;
	y += vsp;

	//slowdown
	hsp *= global.drag;
	vsp *= global.drag;
	
	checkIfStopped();
	
}

function calc_knockback_movement()
{
	//get_damage(odamagenemy);
	x += hsp;
	y += vsp;
	
	
	
	//slowdown 
	
	hsp *= global.drag;
	vsp *= global.drag;
	
	checkIfStopped();
	
	show_debug_message(knockback_time);
	
	//exit state
	if knockback_time <= 0 state = states.IDLE;
	
}
 
function EnemyAnim()
{
	switch (state)
	{
		case states.IDLE:
			sprite_index = s_idle;
			showHurt();
		break;
		case states.MOVE:
			sprite_index = s_move;
			showHurt();
		break;
		case states.ATTACK:
			sprite_index = s_attack;
		break;
		case states.KNOCKBACK:
			showHurt();
		break;
		case states.DEAD:
			sprite_index = s_dead;
		break;		
	}
	//set depth
	depth = -bbox_bottom;
	//update previous position
	xp = x;
	yp = y;	
}

function CheckForPlayer()
{
	var _dis = distance_to_object(oplayer);
	//can we start chasing 
	if ((_dis <= alertdist) or alert) and _dis > attack_dis 
	{
		alert = true;
			
		if calc_path_timer-- <= 0
		{
			//reset timer
			calc_path_timer = calc_path_delay;
		
			//can we make a path to the player
			if (x == xp && y == yp)
			{
				var _type = 0
			}
			else
			{
				var _type = 1; 
			}
			var _found_player = mp_grid_path(global.mp_grid, path, x, y, oplayer.x, oplayer.y, choose(_type));
	
			//start path to the player
			if _found_player 
			{
				path_start(path, move_spd, path_action_stop, false);
			}
		}
	}
	else
	{
		//are we close enough to attack
		if _dis <= attack_dis && can_attack
		{
			path_end();
			state = states.ATTACK;
		}
	}		
}

function CheckFacing()
{
	if knockback_time <= 0
	{
		var _facing = sign(x - xp);
		if _facing != 0 facing = _facing;	
	}
}

function IsDead()
{
	//update this so it reflects the state of the player
	if state != states.DEAD
	{
		if hp <= 0
		{
			state = states.DEAD;
			hp = 0;
			image_index = 0;
			//sety the death sound
			switch(object_index)
			{
				default:
				//play sound
				break;
			}
			return true;
		}
		
	}
	else return 
}

function checkIfStopped()
{
	if abs(hsp) < 0.01 hsp = 0;
	if abs(vsp) < 0.01 vsp = 0;
}

function attack_countdown()
{
	if attack_cooldown >0
	{
	attack_cooldown--;
		if attack_cooldown <= 0
		{
			attack_cooldown = 0;
			show_debug_message("ready to attacck");
			can_attack = true;
		}
	}
}
function perform_attack()
{
	if image_index >= attack_frame and can_attack
	{
		//reset for next attack
		can_attack = false;
		attack_cooldown = 75;
		
		//get attack direction
		var _dir = point_direction(x, y, oplayer.x, oplayer.y);
		
		//get attack position
		var _xx = x + lengthdir_x(attack_dis, _dir);
		var _yy = y + lengthdir_y(attack_dis, _dir);
		
		//create hitbox and pass our varibales to the hitbox
		var _inst = instance_create_layer(_xx, _yy, "Instances", testmelee);
		_inst.owner_id = id;
		_inst.damage = damage;
		_inst.knockback_time = knockback_time;
	}
}
		
function showHurt()
{
	if knockback_time-- > 0
	{
		sprite_index = s_hurt;
	}
}

function showHealthBar()
{
	//show the health bar above an entity head
	if hp != hp_max and hp > 0
	{
		draw_healthbar(x - 20, y - 30, x+7, y - 30, hp/hp_max*100, $003300, $3232FF, $00B00, 0, 1, 1);
	}
}

function setupKnockback(_dead, _damageObj)
{
								//calculating enemy knockback distance for if the target is dead or alive
								var _dis = _dead ? 30 : 4;
								var _dir = _damageObj.dir;
								hsp += lengthdir_x(_dis, _dir);
								vsp += lengthdir_y(_dis, _dir);
}

	



