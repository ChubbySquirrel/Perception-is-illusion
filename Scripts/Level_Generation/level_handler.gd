extends Node

@export var grid : Grid

@export var stone_manager : StoneGroupManager

func _ready() -> void:
	stone_manager.grid = grid
	grid.stone_manager = stone_manager
	grid.make_grid_from_file(LevelManager.current_level_location)
	stone_manager.assign_pivots()


func _on_grid_player_reached_goal() -> void:
	grid.player.show_success_screen()
