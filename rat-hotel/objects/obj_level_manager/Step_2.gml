for(var i = 0; i < array_length(level_floor_layout); i++)
{
	for(var j = 0; j < array_length(level_floor_layout[0]); j++)
	{
		if(level_floor_layout[i][j] == LAYOUT.FRAGILE)
		{
			if(level_entity_layout[i][j] != ENTITIES.NONE)
			{
				var break_through = false;				
				
				var room_coords = grid_to_room(j, i);
				var on_it = collision_point(room_coords[0], room_coords[1], [obj_block, obj_cheese, obj_player_mouse], false, false);
				if(on_it.object_index == obj_player_mouse)
				{
					if(array_length(on_it.mice) > 3)
					{
						break_through = true;
						time_source_start(ts_restart_level);
						global.locked = true;
					}
				}
				else
				{
					if(on_it.weight > 3)
					{
						break_through = true;
					}
				}
				
				if(break_through)
				{
					var layer_id = layer_get_id("Layout");
					var map_id = layer_tilemap_get_id(layer_id);
					tilemap_set(map_id, 0, j, i);
					instance_destroy(on_it);
					level_complete = true;
					level_floor_layout[i][j] = LAYOUT.PIT;
					level_entity_layout[i][j] = ENTITIES.NONE;
				}
			}
		}
	}
}