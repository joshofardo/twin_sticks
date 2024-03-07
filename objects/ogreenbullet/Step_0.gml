/// @description Insert description here
// You can write your code in this editor
xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

x += xspd;
y += yspd;

//cleanup
//collision

//destroy
if destroy == true { instance_destroy(); }

if place_meeting(x, y, osolidwall)
{
    destroy = true;
}

//bullet out of range
if point_distance(xstart, ystart, x, y) > maxDist {
    destroy = true;
}
