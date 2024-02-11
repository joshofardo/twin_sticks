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
	get_damage(odamagenemy);
	show_debug_message("knockback");
	x += hsp;
	y += vsp;
	
	//slowdown 
	
	hsp *= global.drag;
	vsp *= global.drag;
	
	checkIfStopped();
	
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
		if _dis <= attack_dis 
		{
			path_end();
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
	if abs(hsp) < 0.1 hsp = 0;
	if abs(vsp) < 0.1 vsp = 0;
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

	



