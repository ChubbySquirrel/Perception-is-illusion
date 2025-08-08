extends Node

@export var grid : Grid

func _ready() -> void:
	grid.make_grid_from_file(LevelManager.current_level_location)


func _on_grid_player_reached_goal() -> void:
	grid.player.show_success_screen()
