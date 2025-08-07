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
var scene = preload("res://Scenes/tile.tscn")

var tile : Node2D
var blocked = false

var tile_above : Tile
var tile_below : Tile
var tile_right : Tile
var tile_left : Tile

func _ready() -> void:
	
	tile = scene.instantiate()
	add_child(tile)
	tile.get_child(0).color = colors.get(type)
	if TileRules.tile_type_collisions.get(type):
		tile.get_child(1).disabled = false
		blocked = true

func set_tile_position(p : Vector2) -> void:
	tile.position = p

func get_tile_position() -> Vector2:
	return tile.position

func set_color(c : Color) -> void:
	tile.get_child(0).color = c

func set_text(t : String) -> void:
	tile.get_child(2).text = t
