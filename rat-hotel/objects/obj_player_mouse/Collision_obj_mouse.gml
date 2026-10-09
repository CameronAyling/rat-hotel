instance_destroy(other);

var coords = [0, 0];
for(var i = 0; i < 5; i++)
{
	coords = [random_range(-global.grid_size / 3, global.grid_size / 3), random_range(-global.grid_size / 3, global.grid_size / 3)];
	var complete = true;
	
	for(var j = 0; j < array_length(mice); j++)
	{
		if(point_distance(coords[0], coords[1], mice[i][0], mice[i][1]) < 30)
		{
			complete = false;
		}
	}
	
	if(complete)
	{
		break;
	}
}

array_push(mice, coords);