function grid_to_room(_x, _y)
{
	return [64 + _x * 128, 64 + _y * 128]
}

function room_to_grid(_x, _y)
{
	return [floor(_x / 128), floor(_y / 128)];
}

enum LAYOUT {PIT, FLOOR, WALL, OBJECTIVE}
enum ENTITIES {NONE, MOUSE, BLOCK, CHEESE, PLAYER}
enum MOVEMENT {LEFT, RIGHT, UP, DOWN}