draw_self();

for(var i = 1; i < array_length(mice); i++)
{
	draw_sprite(sprite_index, image_index, x + mice[i][0], y + mice[i][1]);
}