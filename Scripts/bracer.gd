extends Node2D
class_name Bracer

var stones: Dictionary[String,Stone]

var stone_types = {"A":true,"B":true,"C":true,"D":true}

var stone_grid: Array[Array]

var tile_size = 32

var grid_lines = preload("res://Bracer_Grid_line.tscn")

@export var grid_size = 5
#1/scale gets us the ratio of tiles in bracer vs labrinth
var bracer_scale:int  = 1

func _ready() -> void:
	
	pass
	
	
func check_moved(stone:Stone) -> bool:
	#If the tile has moved sufficently in a direction
	print(stone.position)
	var rel_position = stone.position - home_position(stone.bracer_pos)

	var grid_change = (rel_position/tile_size).round()
	grid_change = grid_change as Vector2i
	#If there is a change
	if grid_change.length() >= 1:
		stone.bracer_pos += grid_change
		stone.bracer_pos = Vector2(posmod(stone.bracer_pos.x,grid_size),posmod(stone.bracer_pos.y,grid_size))
		stone.pressed = false
		snap_home(stone)
		return true
	else:
		return false
	
	
	
#creates empty bracer grid based off of labrinth grid
func create_grid(grid:Grid):
	stone_grid = []
	for row_index in grid_size:
		var row = []
		for column_index in grid_size:
			row.append(null)
		stone_grid.append(row)
	draw_grid()
		
#Rudementary drawing grid function
func draw_grid():
	for i in stone_grid.size():
		for j in stone_grid[0].size():
			var grid_line = grid_lines.instantiate()
			grid_line.global_position = home_position(Vector2i(i,j))
			add_child(grid_line)
	
#calculates home position of stone
func home_position(grid_location: Vector2i) -> Vector2:
	var home_position = global_position + tile_size*(grid_location as Vector2)
	return home_position
		
func snap_home(stone:Stone):
	stone.position = home_position(stone.bracer_pos)


	
