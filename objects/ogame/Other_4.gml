#macro TS  16

//set variables
var _w = ceil(room_width / TS);
var _h = ceil(room_height / TS);

//create motion planning grid
global.mpgrid = mp_grid_create(0, 0, _w, _h, TS, TS);

//add solid instances to grid
mp_grid_add_instances(global.mp_grid, owall, false);
