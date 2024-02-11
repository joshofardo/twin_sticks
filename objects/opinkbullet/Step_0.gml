/// @description Insert description here
// You can write your code in this editor
if screen_pause() {exit;};
xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

depth = -y;

x += xspd;
y += yspd;

//cleanup

	//hit confirmed destroy
	if hitConfirm == true && enemyDestroy == true {destroy = true};
	
	//destroy
	if destroy == true{instance_destroy();}

	//collision
	if place_meeting(x, y, osolidwall){destroy = true;};
	
	//bullet out of range
	if point_distance(xstart, ystart, x, y) > maxDist{destroy = true;};
	

	
	


