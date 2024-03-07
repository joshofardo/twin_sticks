event_inherited();

get_damage(owhitebullet);

can_attack = true;

hspd = 0;
vspd = 0;

hp_max = 10;
hp = hp_max;
_iframes = false;

state = states.IDLE;

s_idle = sdummyidle;
s_move = senemywalk;
s_attack = senemyattack;
s_hurt = senemyhurt;
s_dead = senemydead;
