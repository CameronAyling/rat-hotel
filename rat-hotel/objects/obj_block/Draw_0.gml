draw_self();

draw_set_halign(fa_center);
draw_set_valign(fa_middle);

if(instance_exists(obj_player_mouse) && array_length(obj_player_mouse.mice) >= weight)
{
	draw_set_colour(c_green);
}
else
{
	draw_set_colour(c_red);
}

draw_set_font(fnt_cheese);

draw_text(x, y, weight);

draw_set_colour(c_white);

draw_set_halign(fa_left);
draw_set_valign(fa_top);