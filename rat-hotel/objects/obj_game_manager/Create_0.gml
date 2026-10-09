level_index = 0;

level_order = [
	rm_level_1,
	rm_level_2
]

next_level = function()
{
	show_debug_message("here");
	level_index++;
	room_goto(level_order[level_index]);
}