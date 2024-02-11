
CheckForPlayer();

switch(state) {
	case states.IDLE:
		calc_entity_movement();
		EnemyAnim();
		flash_from_visibile_and_invisible_after_getting_hit();
		get_damage(odamagenemy);
		CheckForPlayer();
		CheckFacing();
		if (path_index != -1)
		{
			state = states.MOVE;
		}
	break;
	
	case states.MOVE:
		calc_entity_movement();
		//abstract this
		if place_meeting(x + hspd, y, owall) && (knockback_time > 0)
		{
			hspd *= -1;
		}
		if place_meeting(x, y + vspd, owall) && (knockback_time > 0)
		{
			vspd *= -1;
		}
		CheckForPlayer();
		CheckFacing();
		flash_from_visibile_and_invisible_after_getting_hit();
		get_damage(odamagenemy);
		if IsDead() 
		{
			show_debug_message("switching to kb state");
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
		calc_knockback_movement();
		flash_from_visibile_and_invisible_after_getting_hit();
		get_damage(odamagenemy);
		if IsDead() 
		{
			show_debug_message("switching to kb state");
			state = states.DEAD;
		}
		EnemyAnim();
			
	break;
	
	case states.ATTACK:
		calc_entity_movement();
		flash_from_visibile_and_invisible_after_getting_hit();
		get_damage(odamagenemy);
		EnemyAnim();
	break;
	
	case states.DEAD:
		show_debug_message("dead");
		path_end();
		get_damage(odamagenemy);
		//add something in here so if the dead enemies get knocked against a wall 
		//they dont bounce off
		//calc_entity_movement();
		EnemyAnim();
	break;
	

}







