/// @description Insert description here
// You can write your code in this editor
get_damage(odamagenemy);

//show damage
var _healthPercent =1 - (hp/maxHp);
image_index = _healthPercent*image_number;

if hp <= 0 
{
	//create explosion
	instance_create_depth(x+20, y+20, -3000, obigboom);
	
	//screen pause
	create_screen_pause(6);
	//screen shake
	screen_shake(10);
	
	//destroy
	instance_destroy();
}



