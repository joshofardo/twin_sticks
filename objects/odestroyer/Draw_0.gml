/// @description Insert description here
// You can write your code in this editor
draw_sprite_ext(sprite_index, image_index, x, y, face, image_yscale, image_angle, image_blend, image_alpha);


//draw hp
var _healthPercent = hp/maxHp;
var _hpimage = _healthPercent * (sprite_get_number(senemyhealth) - 1);
draw_sprite_ext( senemyhealth, _hpimage, x, y - sprite_height - 3, image_xscale, image_yscale, image_angle, image_blend, image_alpha );
//draw_text( x, y, string(hp));

//check size of the damage list

//draw_text(x, y -32, string(ds_list_size(damageList)));
