//pause se;f
if screen_pause() {
    exit;
};

//spawn an enemy

timer++;

//reset timer when enemy limits have been reached
if instance_number(oenemy) >= global.activeEnemyMax || global.totalEnemiesSpawned >= global.enemyRoomMax {
    timer = 0;
}

if timer >= spawnTime && !place_meeting(x, y + 16, oseeker)
{
    //create an enemy
    var _inst = instance_create_depth(x, y, depth - 1, oseeker);
    with (_inst) {
        //make the zombie invisible
        image_alpha = 0;
        state = -1;
    }
    
    //reset the timer
    timer = 0;
}
