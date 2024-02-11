//float in place
if screen_pause() {exit;};
floatDir += floatSpd;
y = ystart + dsin(floatDir)*5;



//get collected by the player
if place_meeting(x, y, oplayer)
{
	oplayer.hp += heal;
	instance_destroy();
}




