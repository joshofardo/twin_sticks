get_damage(odamagenemy)

//death
if hp <= 0 {
    //add to the total amount of enemies killed
    global.enemyKillCount++;
    
    //drop something maybe
    var _chance = irandom(100);
    
    if _chance < 50 {
        instance_create_depth(x, y, depth, oheart);
    }
    //destroy self
    instance_destroy();
}
