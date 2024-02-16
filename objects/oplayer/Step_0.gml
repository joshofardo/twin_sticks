switch(state) 

{case states.MOVE:

		//player standard functions
		get_inputs();
		pause_game();
		//pause self
		if screen_pause() {exit;};
		player_movement();
		player_collision();
		depth = -bbox_bottom;
		get_damage(odamageplayer, true)
		sprite_control();
		weapon_swapping();
		player_shoot();
	if IsDead()
	{
		create_screen_pause(25);
		screen_shake(5);
	}
	break;
	case states.KNOCKBACK:
	//player's functions during knockback
		
		if iframeTimer > 0 
		{
			get_inputs();
			pause_game();
			//pause self
			if screen_pause() {exit;};
			player_movement();
			player_collision();
			depth = -bbox_bottom;
			sprite_control();
			weapon_swapping();
			player_shoot();
			if IsDead()
				{
					create_screen_pause(25);
					screen_shake(5);
				}
			iframeTimer--;
		
			if iframeTimer mod 5 == 0
			{ 
				image_alpha = image_alpha? 0:1
			}
		exit;
		}
		else
		iframeTimer = 90;
		state = states.MOVE;

	break;
}
	
	

	
/*	
	//dyin / game over
	if hp <= 0
	{
		//get downed
		instance_create_depth(0, 0, -10000, ogameoverscreen);
		instance_destroy();
		moveSpd = .5;
	}
	*/	
	
	
	





