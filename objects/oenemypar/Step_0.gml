
CheckForPlayer();

switch(state) {
	case states.IDLE:
		attack_countdown();
		calc_entity_movement();
		EnemyAnim();
		get_damage(odamagenemy);
		CheckForPlayer();
		CheckFacing();	if IsDead() 
		{
			mask_index = -1;
			state = states.DEAD;
		}
		if (path_index != -1)
		{
			state = states.MOVE;
		}
	break;
	
	case states.MOVE:
		attack_countdown();
		calc_entity_movement();
		CheckForPlayer();
		CheckFacing();
		get_damage(odamagenemy);
		if IsDead() 
		{
			mask_index = -1;
			state = states.DEAD;
		}
		EnemyAnim();
		if (path_index == -1) 
		{
			EnemyAnim();
			state = states.IDLE;
		}
	break;
	
	case states.KNOCKBACK:
	
	if hp > 0
		{
		if place_meeting( x + hspd, y, owall)
			{
				hspd = -hspd;
			}
			else if place_meeting( x, y + vspd, owall)
			{
				vspd = -vspd;
			}
		
		EnemyAnim();
		get_damage(odamagenemy);
		calc_knockback_movement();
	}
	else 
	{
		state = states.DEAD;
	}
	break;
	
	case states.ATTACK:
		get_damage(odamagenemy);
		attack_countdown();
		CheckForPlayer();
		{
			perform_attack();
			EnemyAnim();
		}
		show_debug_message(image_index);
		if image_index >=3
		{
			can_attack = false;
			attack_cooldown = 100;
			image_index = 0;
			state = states.IDLE;
		}
	break;
	
	case states.DEAD:
		if place_meeting( x + hspd, y, owall)
			{
				hspd = -hspd;
			}
			else if place_meeting( x, y + vspd, owall)
			{
				vspd = -vspd;
			}
		can_attack = false;
		mask_index = -1;
		path_end();
		EnemyAnim();
		calc_entity_movement();
	break;
	

}






