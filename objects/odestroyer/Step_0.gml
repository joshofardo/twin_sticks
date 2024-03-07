if screen_pause() {
    exit;
};

//code commands
var _wallCollisions = true;
var _getDamage = true;

//state machine
switch (state) {
    //spawn in from portal
    case -1:
        //fade in
        if image_alpha < 1 {
            //dont walk while fading in
            spd = 0;
            image_alpha += fadeSpd;
        }
        //walk out 
        _wallCollisions = false;
        _getDamage = false;
        if image_alpha >= 1 {
            //set the speed and direction
            spd = emergeSpd;
            dir = 270;
            show_debug_message("direction");
        }
        
        //switch to chasing state
        if !place_meeting(x, y, owall)
        {
            state = 0;
        }
        break;
        //chase state
    case 0:
        show_debug_message("moving to state 0");
        
        #region
        
        //chase player code
        if instance_exists(oplayer)
        {
            dir = point_direction(x, y, oplayer.x, oplayer.y);
        }
        
        spd = chaseSpd;
        //transition to shooting state
        var _camLeft = camera_get_view_x(view_camera[0]);
        var _camRight = _camLeft + camera_get_view_width(view_camera[0]);
        var _camTop = camera_get_view_y(view_camera[0]);
        var _camBottom = _camTop + camera_get_view_height(view_camera[0]);
        
        //only add to timer if on screen
        if bbox_right > _camLeft && bbox_left < _camRight && bbox_bottom > _camTop && bbox_top < _camBottom {
            shoottimer++;
        }
        
        if shoottimer > cooldowntime {
            //go to shoot state
            state = 1;
            
            //reset the timer so we can use it in the next state
            shoottimer = 0;
        }
        
        #endregion
        
        break; //pause and shoot state
    case 1:
        #region
        
        //get the player's direction
        if instance_exists(oplayer)
        {
            dir = point_direction(x, y, oplayer.x, oplayer.y);
        }
        //set the correct speed
        spd = 0;
        
        //stop animating / manually set the image index
        image_index = 0;
        
        //shoot a bullet
        shoottimer++;
        
        if shoottimer == 1 {
            bulletinst = instance_create_depth(x + bulletxoffset, y + bulletyoffset, depth, oenemybullet);
        }
        
        //keep the bullet in the zombie's hands
        if shoottimer <= winduptimer && instance_exists(bulletinst)
            {
            bulletinst.x = x + bulletxoffset * face;
            bulletinst.y = y + bulletyoffset;
        }
        
        //shoot the bullet after the windup
        if shoottimer == winduptimer && instance_exists(bulletinst)
            
            {
            //set our bullets state ro the move state
            bulletinst.state = 1;
        }
        //recover and return to chasing the player
        if shoottimer > winduptimer + recovertimer {
            //go back to chasing the player
            state = 0;
            
            //reset the timer so we can use it again
            shoottimer = 0;
        }
        
        #endregion
        
        break;
}

//chase the player

if instance_exists(oplayer) && _wallCollisions == true {
    dir = point_direction(x, y, oplayer.x, oplayer.y);
}
//getting the speeds
show_debug_message("chasing player");
xspd = lengthdir_x(spd, dir);
yspd = lengthdir_y(spd, dir);

//get the correct face

if dir < 90 && dir < 270 {
    face = -1;
} else;
{
    face = 1;
}
//collisions
//wall collisions
if _wallCollisions = true {
    if place_meeting(x + xspd, y, owall)
    { xspd = 0;
    }
    
    if place_meeting(x, y + yspd, owall)
    {
        yspd = 0;
    }
}
//enemy collisions
if place_meeting(x + xspd, y, oenemy)
{ xspd = 0;
}

if place_meeting(x, y + yspd, oenemy)
{
    yspd = 0;
}
//moving
x += xspd;
y += yspd;

if _getDamage = true {
    event_inherited();
}
