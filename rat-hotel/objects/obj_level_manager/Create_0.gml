level_floor_layout = [];
level_entity_layout = [];

grid_size = 128;


// PARSE FLOOR LAYOUT
enum LAYOUT {PIT, FLOOR, WALL, OBJECTIVE}
for(var i = 0; i < floor(room_height / grid_size); i++)
{
	var row = [];
	for(var j = 0; j < floor(room_width / grid_size); j++)
	{
		var type = LAYOUT.PIT;
		
		var layer_id = layer_get_id("Layout");
		var map_id = layer_tilemap_get_id(layer_id);
		var data = tilemap_get(map_id, j, i);
		switch(data)
		{
			case 0:
				type = LAYOUT.PIT;
				break;
			case 1:
				type = LAYOUT.FLOOR;
				break;
			case 2:
				type = LAYOUT.WALL;
				break;
			case 3:
				type = LAYOUT.OBJECTIVE;
				break;
		}
		
		array_push(row, type);
	}
	
	array_push(level_floor_layout, row);
}


// PARSE OBJECTS ON THE LAYOUT
enum ENTITIES {NONE, MOUSE, BLOCK, CHEESE, PLAYER}
for(var i = 0; i < floor(room_height / grid_size); i++)
{
	var row = [];
	for(var j = 0; j < floor(room_width / grid_size); j++)
	{
		var type = ENTITIES.NONE;
		var mouse = collision_point(grid_size / 2 + j * grid_size, grid_size / 2 + i * grid_size, obj_mouse, false, false);
		if(mouse != noone)
		{
			type = ENTITIES.MOUSE;
			var new_coords = room_to_grid(grid_to_room(mouse.x, mouse.y)[0], grid_to_room(mouse.x, mouse.y)[1]);
			mouse.x = new_coords[0];
			mouse.y = new_coords[1];
		}
		var block = collision_point(grid_size / 2 + j * grid_size, grid_size / 2 + i * grid_size, obj_block, false, false);
		if(block != noone)
		{
			type = ENTITIES.BLOCK;
			var new_coords = room_to_grid(grid_to_room(block.x, block.y)[0], grid_to_room(block.x, block.y)[1]);
			block.x = new_coords[0];
			block.y = new_coords[1];
		}
		var cheese = collision_point(grid_size / 2 + j * grid_size, grid_size / 2 + i * grid_size, obj_cheese, false, false);
		if(cheese != noone)
		{
			type = ENTITIES.CHEESE;
			var new_coords = room_to_grid(grid_to_room(cheese.x, cheese.y)[0], grid_to_room(cheese.x, cheese.y)[1]);
			cheese.x = new_coords[0];
			cheese.y = new_coords[1];
		}
		var player = collision_point(grid_size / 2 + j * grid_size, grid_size / 2 + i * grid_size, obj_player_mouse, false, false);
		if(player != noone)
		{
			type = ENTITIES.PLAYER;
			var new_coords = room_to_grid(grid_to_room(player.x, player.y)[0], grid_to_room(player.x, player.y)[1]);
			player.x = new_coords[0];
			player.y = new_coords[1];
		}
		
		array_push(row, type);
	}
	
	array_push(level_entity_layout, row);
}

// MOVEMENT
enum MOVEMENT {LEFT, RIGHT, UP, DOWN}
move_entity = function(_entity, _dir)
{	
	var grid_coords = room_to_grid(_entity.x, _entity.y);
	switch(_dir)
	{
		case MOVEMENT.LEFT:
			if(grid_coords[0] == 0) return false;
		
			if(level_floor_layout[grid_coords[1]][grid_coords[0] - 1] == LAYOUT.FLOOR)
			{
				if(level_entity_layout[grid_coords[1]][grid_coords[0] - 1] == ENTITIES.CHEESE)
				{
					var cheese = collision_point(_entity.x - grid_size, _entity.y, obj_cheese, false, false);
					var result = obj_level_manager.move_entity(cheese, MOVEMENT.LEFT);
					if(!result) return false;
				}
				
				level_entity_layout[grid_coords[1]][grid_coords[0] - 1] = level_entity_layout[grid_coords[1]][grid_coords[0]];
				level_entity_layout[grid_coords[1]][grid_coords[0]] = ENTITIES.NONE;
				_entity.x -= grid_size;
			}
			else return false;
			break;
			
		case MOVEMENT.RIGHT:
			if(grid_coords[0] == array_length(level_entity_layout[0]) - 1) return false;
			
			if(level_floor_layout[grid_coords[1]][grid_coords[0] + 1] == LAYOUT.FLOOR)
			{
				if(level_entity_layout[grid_coords[1]][grid_coords[0] + 1] == ENTITIES.CHEESE)
				{
					var cheese = collision_point(_entity.x + grid_size, _entity.y, obj_cheese, false, false);
					var result = obj_level_manager.move_entity(cheese, MOVEMENT.RIGHT);
					if(!result) return false;
				}
				
				level_entity_layout[grid_coords[1]][grid_coords[0] + 1] = level_entity_layout[grid_coords[1]][grid_coords[0]];
				level_entity_layout[grid_coords[1]][grid_coords[0]] = ENTITIES.NONE;
				_entity.x += grid_size;
			}
			else return false;
			break;
			
		case MOVEMENT.UP:
			if(grid_coords[1] == 0) return false;
		
			if(level_floor_layout[grid_coords[1] - 1][grid_coords[0]] == LAYOUT.FLOOR)
			{
				if(level_entity_layout[grid_coords[1] - 1][grid_coords[0]] == ENTITIES.CHEESE)
				{
					var cheese = collision_point(_entity.x, _entity.y - grid_size, obj_cheese, false, false);
					var result = obj_level_manager.move_entity(cheese, MOVEMENT.UP);
					if(!result) return false;
				}
				
				level_entity_layout[grid_coords[1] - 1][grid_coords[0]] = level_entity_layout[grid_coords[1]][grid_coords[0]];
				level_entity_layout[grid_coords[1]][grid_coords[0]] = ENTITIES.NONE;
				_entity.y -= grid_size;
			}
			else return false;
			break;
			
		case MOVEMENT.DOWN:
			if(grid_coords[1] == array_length(level_entity_layout) - 1) return false;
		
			if(level_floor_layout[grid_coords[1] + 1][grid_coords[0]] == LAYOUT.FLOOR)
			{
				if(level_entity_layout[grid_coords[1] + 1][grid_coords[0]] == ENTITIES.CHEESE)
				{
					var cheese = collision_point(_entity.x, _entity.y + grid_size, obj_cheese, false, false);
					var result = obj_level_manager.move_entity(cheese, MOVEMENT.DOWN);
					if(!result) return false;
				}
				
				level_entity_layout[grid_coords[1] + 1][grid_coords[0]] = level_entity_layout[grid_coords[1]][grid_coords[0]];
				level_entity_layout[grid_coords[1]][grid_coords[0]] = ENTITIES.NONE;
				_entity.y += grid_size;
			}
			else return false;
			break;
	}
	
	return true;
}