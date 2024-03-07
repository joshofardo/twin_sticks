//pause self
if screen_pause() {
    exit;
};

//movement
xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

x += xspd;
y += yspd;

//cleanup

//hit confirmed destroy
if hitConfirm == true && enemyDestroy == true { destroy = true;
};

//destroy
if destroy == true { instance_destroy(); }

//collision
if place_meeting(x, y, osolidwall)
{
    destroy = true;
}

//bullet out of range
if point_distance(xstart, ystart, x, y) > maxDist {
    destroy = true;
}
