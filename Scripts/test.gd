extends Node

@onready var grid : Grid = $Grid

@export var npc : NPC

@export var enemy : Enemy

var called = false

func _ready() -> void:
	npc.grid = grid
	enemy.grid = grid
	grid.make_grid_from_file("res://Resources/test.csv")
	enemy.activate()
