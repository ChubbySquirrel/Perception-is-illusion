extends Node

var tile_type_map : Dictionary[String,Tile.TileTypes] = {
	"x" : Tile.TileTypes.WALL,
	"o" : Tile.TileTypes.PATH,
	"d" : Tile.TileTypes.DOOR,
	"h" : Tile.TileTypes.HIDDENPATH,
	"s" : Tile.TileTypes.PATH,
	"g" : Tile.TileTypes.GOAL
}

var tile_type_collisions : Dictionary[Tile.TileTypes,bool] = {
	Tile.TileTypes.WALL : true,
	Tile.TileTypes.PATH : false,
	Tile.TileTypes.DOOR : true,
	Tile.TileTypes.HIDDENPATH : false,
	Tile.TileTypes.GOAL : false
}

func get_tile_type_from_string(s : String) -> Tile.TileTypes:
	if tile_type_map.has(s):
		return tile_type_map.get(s)
	else:
		return Tile.TileTypes.WALL

func is_nth_bit_set(value : int, n : int):
	return (value & (1 << n)) != 0

func extract_tile_parameters():
	pass
