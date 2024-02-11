/// @description Insert description here
// You can write your code in this editor

draw_text(x, y-100, xspd);
draw_text(x, y-130, yspd);

//draw the weapon behind the player


if aimDir >= 0 && aimDir < 180
{
	draw_my_weapon()
}

//draw the player
{
draw_self();
}

//draw the weapon in fron of the player

if aimDir >= 180 && aimDir < 360
{
draw_my_weapon();
}
draw_line(x, centerY, mouse_x, mouse_y);
