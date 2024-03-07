/// @description Insert description here
// You can write your code in this editor
get_damage(odamagenemy, false, true);

if hp <= 0 {
    instance_create_depth(x + 20, y + 20, -3000, _destroyobj);
    instance_destroy();
}
