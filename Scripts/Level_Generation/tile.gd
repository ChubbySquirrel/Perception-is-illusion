class_name Tile

extends Node

enum TileTypes {
	PATH,
	WALL,
	DOOR,
	HIDDENPATH,
	GOAL
}

var colors : Dictionary[TileTypes,Color] = {
	TileTypes.PATH : Color.WHITE,
	TileTypes.WALL : Color.BLACK,
	TileTypes.DOOR : Color.BROWN,
	TileTypes.HIDDENPATH : Color.BLACK,
	TileTypes.GOAL : Color.DARK_GOLDENROD
}

var type : TileTypes
var scene = preload("res://Scenes/Level_Generation/tile.tscn")

const WALLS = ["Top_Wall","Left_Wall","Right_Wall","Bottom_Wall"]
const WALLS_APPEARANCE = ["Top_Wall_Appearance","Left_Wall_Appearance","Right_Wall_Appearance","Bottom_Wall_Appearance"]

var tile : Node2D
var blocked = false

var walls : int = -1
var i = -1
var j = -1

var tile_above : Tile
var tile_below : Tile
var tile_right : Tile
var tile_left : Tile

var adjacency_list : Dictionary

func _ready() -> void:
	
	tile = scene.instantiate()
	add_child(tile)
	tile.get_node("Overall_Appearance").color = colors.get(type)
	if TileRules.tile_type_collisions.get(type):
		enable_all_walls()
		blocked = true
	if walls != -1:
		setup_walls()

func enable_all_walls() -> void:
	for k in range(WALLS.size()):
		tile.get_node(WALLS[k]).disabled = false
		tile.get_node(WALLS_APPEARANCE[k]).visible = true

func disable_all_walls() -> void:
	for k in range(WALLS.size()):
		tile.get_node(WALLS[k]).disabled = true
		tile.get_node(WALLS_APPEARANCE[k]).visible = false

func set_tile_position(p : Vector2) -> void:
	tile.position = p

func get_tile_position() -> Vector2:
	return tile.position

func set_color(c : Color) -> void:
	tile.get_child(0).color = c

func set_text(t : String) -> void:
	t = t + "\n"
	if tile_above != null:
		t = t + "Tile Above: I: "+str(tile_above.i)+" J: "+str(tile_above.j)+ "\n"
	if tile_below != null:
		t = t + "Tile Below: I: "+str(tile_below.i)+" J: "+str(tile_below.j)+ "\n"
	if tile_right != null:
		t = t + "Tile Right: I: "+str(tile_right.i)+" J: "+str(tile_right.j)+ "\n"
	if tile_left != null:
		t = t + "Tile Left: I: "+str(tile_left.i)+" J: "+str(tile_left.j)+ "\n"
	tile.get_node("Debug_Text").text = t

func setup_walls()-> void:
	for k in range(WALLS.size()):
		if TileRules.is_nth_bit_set(walls,k):
			tile.get_node(WALLS[k]).disabled = false
			tile.get_node(WALLS_APPEARANCE[k]).visible = true
		else:
			tile.get_node(WALLS[k]).disabled = true
			tile.get_node(WALLS_APPEARANCE[k]).visible = false

func get_tile_adjacent(t : Tile) -> Vector2:
	if t == tile_above:
		return Vector2.UP
	elif t == tile_below:
		return Vector2.DOWN
	elif t == tile_left:
		return Vector2.LEFT
	elif t == tile_right:
		return Vector2.RIGHT
	return Vector2.ZERO

func get_wall_set(dir : Vector2) -> bool:
	match dir:
		Vector2.UP:
			return not tile.get_node(WALLS[0]).disabled
		Vector2.LEFT:
			return not tile.get_node(WALLS[1]).disabled
		Vector2.RIGHT:
			return not tile.get_node(WALLS[2]).disabled
		Vector2.DOWN:
			return not tile.get_node(WALLS[3]).disabled
	return false

func traversable(to : Tile)->bool:
	var adjacency_direction = get_tile_adjacent(to)
	match adjacency_direction:
		Vector2.ZERO:
			return false
		Vector2.UP:
			if get_wall_set(Vector2.UP) or to.get_wall_set(Vector2.DOWN):
				return false
			else:
				return true
		Vector2.DOWN:
			if get_wall_set(Vector2.DOWN) or to.get_wall_set(Vector2.UP):
				return false
			else:
				return true
		Vector2.LEFT:
			if get_wall_set(Vector2.LEFT) or to.get_wall_set(Vector2.RIGHT):
				return false
			else:
				return true
		Vector2.RIGHT:
			if get_wall_set(Vector2.RIGHT) or to.get_wall_set(Vector2.LEFT):
				return false
			else:
				return true
	return false
