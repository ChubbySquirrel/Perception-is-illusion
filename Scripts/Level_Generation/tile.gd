class_name Tile

extends Node

enum TileTypes {
	PATH,
	WALL,
	DOOR,
	HIDDENPATH
}

var colors : Dictionary[TileTypes,Color] = {
	TileTypes.PATH : Color.WHITE,
	TileTypes.WALL : Color.BLACK,
	TileTypes.DOOR : Color.BROWN,
	TileTypes.HIDDENPATH : Color.BLACK
}

var type : TileTypes
var scene = preload("res://Scenes/Level_Generation/tile.tscn")

const WALLS = ["Top_Wall","Left_Wall","Right_Wall","Bottom_Wall"]

var tile : Node2D
var blocked = false

var i = -1
var j = -1

var tile_above : Tile
var tile_below : Tile
var tile_right : Tile
var tile_left : Tile

func _ready() -> void:
	
	tile = scene.instantiate()
	add_child(tile)
	tile.get_node("Appearance").color = colors.get(type)
	if TileRules.tile_type_collisions.get(type):
		enable_all_walls()
		blocked = true

func enable_all_walls() -> void:
	for i in WALLS:
		tile.get_node(i).disabled = false

func disable_all_walls() -> void:
	for i in WALLS:
		tile.get_node(i).disabled = true

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
