//set the image angle to match the direction the ball is traveling
image_angle = direction - 90;

//make sure the speed doesn't get ridiculously fast
speed = clamp(spd, 0, 12);

//reduce speed each frame
spd -= .1;

//count down the hit timer so it can be hit again
if hittimer > 0
{
	hittimer -- ;
}