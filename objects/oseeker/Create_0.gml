// Inherit the parent event
event_inherited();
get_damage(owhitebullet);


spd = 0;
chaseSpd = 15;
dir = 0;
xspd = 0;
yspd = 0;

face = 1;

//state machine

state = 0;

//spawn from portal
fadeSpd = 1/30;
emergeSpd = .25;

//shooting state 
cooldowntime = 240;
shoottimer = irandom(cooldowntime);
winduptimer = 60;
recovertimer = 45;
bulletinst = noone;

bulletxoffset = 8;
bulletyoffset = 8;



