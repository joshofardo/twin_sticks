//get cam coordinates
var _camx = camera_get_view_x(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0]);

//draw health bar

if instance_exists(oplayer)
{
	
var _border = 16;
draw_sprite(shealthbar, 0, _camx + _border, _camy + _border);

for(var i = 0; i < playerMaxHp; i++)
{
	//show current hp
	var _img = 1;
	if i + 1 <= playerHp{ _img = 2;};
	
	var _sep = 6;
	draw_sprite(shealthbar, _img, _camx + _border + _sep*i, _camy + _border );
}
}

//draw the enemy kill count
var _enemyCountString = "kill count:" + string(global.enemyKillCount) + "/" + string(global.enemyRoomMax);
draw_text(_camx, _camy+32, _enemyCountString);

