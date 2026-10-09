fade_amount += fade_mod * delta_time / 1000000;

draw_set_colour(c_black);
draw_set_alpha(fade_amount);

draw_rectangle(0, 0, room_width, room_height, false);

draw_set_colour(c_white);
draw_set_alpha(1);