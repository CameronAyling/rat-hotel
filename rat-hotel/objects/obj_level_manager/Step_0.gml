level_complete = true;

with(obj_objective_marker)
{
	if(!complete)
	{
		other.level_complete = false;
	}
}

if(level_complete)
{
	time_source_start(ts_next_level);
}