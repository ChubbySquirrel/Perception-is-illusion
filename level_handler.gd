extends Node

@export var grid : Grid

func _ready() -> void:
	grid.make_grid_from_file(LevelManager.current_level_location)
