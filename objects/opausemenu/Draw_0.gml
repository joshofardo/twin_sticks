var _camx = camera_get_view_x(view_camera[0]);
var _camw = camera_get_view_width(view_camera[0]);
var _camy = camera_get_view_y(view_camera[0]);
var _camh = camera_get_view_height(view_camera[0]);

//draw a black rectangle over the screen
draw_set_alpha(alpha);
draw_rectangle_color(_camx, _camy, _camx + _camw, _camy + _camh, c_black, c_black, c_black, c_black, false);
//draw the text
//yall died
draw_set_halign(fa_middle);
draw_set_valign(fa_center);
draw_set_alpha(1);
draw_set_font(fntArial);

//game over
var _gameoveroffset = -32;
draw_text_transformed(_camx + _camw / 2, _camy + _camh / 2 + _gameoveroffset, "puased", 3, 3, 0)

//press shoot to restart
var _restartoffset = 80;
draw_text_transformed(_camx + _camw / 2, _camy + _camh / 2 + _restartoffset, "Press esc to resume", 1, 1, 0);

draw_set_alpha(1);
