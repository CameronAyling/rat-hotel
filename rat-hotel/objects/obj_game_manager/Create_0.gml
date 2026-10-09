global.paused = false;
global.locked = false;

level_index = 0;

level_order = [
	rm_level_1
]

next_level = function()
{
	level_index++;
	if(level_index > array_length(level_order) - 1)
	{
		room_goto(rm_menu);
		level_index = 0;
	}
	else
	{
		room_goto(level_order[level_index]);
	}
}

randomise();

pause_resume = function()
{
	if(!global.locked)
	{
		global.paused = !global.paused;
	}

	if(!global.paused)
	{
		layer_sequence_destroy(pause_seq);
	}

	if(global.paused)
	{
		pause_seq = layer_sequence_create("GUI", room_width / 2, room_height / 2, seq_pause);
	}
}