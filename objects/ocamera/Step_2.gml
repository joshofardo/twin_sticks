//get tyhe cameras width and height
var _camW = camera_get_view_width(view_camera[0]);
var _camH = camera_get_view_height(view_camera[0]);

//center on the player
if instance_exists(oplayer)
{
    x = (oplayer.x) - _camW / 2;
    y = (oplayer.centerY) - _camH / 2;
}

//camera shaking

//testing code
//if global.swapKeyPressed { screen_shake(4)};

//xShake
if xShakeAmount > 0 {
    xShakeDir += xShakeDirSpd;
    xShakeAmount -= xShakeAmountSpd;
} else;
{
    xShakeAmount = 0;
    xShakeDir = 0;
}
xShake = dsin(xShakeDir) * xShakeAmount;

if yShakeAmount > 0 {
    yShakeDir += yShakeDirSpd;
    yShakeAmount -= yShakeAmountSpd;
} else;
{
    yShakeAmount = 0;
    yShakeDir = 0;
}
yShake = dsin(yShakeDir) * yShakeAmount;

//add in the camera shake
x += xShake;
y += yShake;

//clamp cam position to room borders
x = clamp(x, 0, room_width - _camW);
y = clamp(y, 0, room_height - _camH);

//set the camera position
camera_set_view_pos(view_camera[0], x, y);
