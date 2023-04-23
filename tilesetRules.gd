tool
extends TileSet

const GRASS = 3
const WALL = 2
const SAND = 5

var binds = {
	GRASS:[WALL],
	WALL:[GRASS],
	SAND:[GRASS],
	GRASS:[SAND]
}

func _is_tile_bound(drawn_id, neighbor_id):
	if drawn_id in binds:
		return neighbor_id in binds[drawn_id]
	return false
