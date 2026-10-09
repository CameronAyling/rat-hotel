level_complete = true;

with(obj_objective_marker)
{
	if(!complete)
	{
		other.level_complete = false;
	}
}

if(level_complete && !time_source_started)
{
	time_source_started = true;
	var ts = time_source_create(time_source_game, 2, time_source_units_seconds, function(e, i) {obj_game_manager.next_level()})
	time_source_start(ts);
}