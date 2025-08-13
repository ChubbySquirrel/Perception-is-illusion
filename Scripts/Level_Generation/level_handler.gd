class_name LevelHandler

extends Node

@export var grid : Grid

@export var stone_manager : StoneGroupManager

@export var success_screen : Control

@export var death_screen : Control

func _ready() -> void:
	stone_manager.grid = grid
	grid.stone_manager = stone_manager
	grid.make_grid_from_file(LevelManager.current_level_location)
	stone_manager.assign_pivots()


func _on_grid_player_reached_goal() -> void:
	grid.player.disabled = true
	Engine.time_scale = 0
	success_screen.visible = true

func on_player_death() -> void:
	grid.player.disabled = true
	Engine.time_scale = 0
	death_screen.visible = true
