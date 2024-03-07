hp_max = 15;
hp = hp_max;
state = states.IDLE;
damage = 1;
hitConfirm = false;
event_inherited();

get_damaged_Create(20, false);

//when we are chasing the player
alert = false;
alertdist = 500;
path = path_add();
move_spd = 6;
//variables for path calculation
calc_path_delay = 30;
//set a timer for when we calculate a path
calc_path_timer = irandom(60);
//set distance at which enemy attacks player
attack_dis = 30;

hspd = 0;
vspd = 0;

attack_dis = 50;

attack_frame = 1;
can_attack = true;
attack_cooldown = 600;
damage = 2;
knockback_time = 60;

//hp_max = 10;
//hp = hp_max

_iframes = false;
_env = false;
state = states.IDLE;

s_idle = senemyidle;
s_move = senemywalk;
s_attack = senemyattack;
s_hurt = senemyhurt;
s_dead = senemydead;


