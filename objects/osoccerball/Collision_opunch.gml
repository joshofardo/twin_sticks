//if the ball is ready to be hit
if (hittimer <= 0) 
{
	with(opunch)
	{
		//get rid of the punch
		instance_change(ofollowthrough, true);
	}
	
	//reset the hit cooldown
	hittimer = 20;
	
	//increase ball speed by 30
	spd = 30;
	//set direction of the ball to be the direction the player punched it
	direction =  oplayer.aimDir;
}
else
{
	exit;
}



