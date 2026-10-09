var cheese = collision_point(x, y, obj_cheese, false, false)

complete = false;

if(cheese != noone)
{
	if(needed_weight == cheese.weight)
	{
		complete = true;
	}
}
