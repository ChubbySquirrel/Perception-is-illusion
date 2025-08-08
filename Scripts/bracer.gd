extends Node2D
class_name Bracer

var stones: Dictionary[String,Stone]

var stone_types = {"A":true,"B":true,"C":true,"D":true}

var stone_grid: Array[Array]

var tile_size = 32

var grid_lines = preload("res://Bracer_Grid_line.tscn")
var stone_scene = preload("res://Scenes/Stone.tscn")

@export var grid_size = 5
#1/scale gets us the ratio of tiles in bracer vs labrinth
var bracer_scale:int  = 1

func _ready() -> void:
	create_grid(LevelManager.level_grid)
	spawn_stones()
	

	pass
	
	
func spawn_stones():

	var initialize_arr = [["A",Vector2i(1,1)],["B",Vector2i(4,1)],["C",Vector2i(1,4)],["D",Vector2i(4,4)]]
			
	for data in initialize_arr:
		var grid_pos = data[1]
		var type = data[0]
		var new_stone1 = stone_scene.instantiate()
		add_child(new_stone1)
		new_stone1.bracer = self
		new_stone1.create(type,true,1,grid_pos)
		stone_grid[grid_pos.x][grid_pos.y] = new_stone1
	
func check_moved(stone:Stone) -> bool:
	#If the tile has moved sufficently in a direction
	print(stone.position)
	var rel_position = stone.position - home_position(stone.bracer_pos)

	var grid_change = (rel_position/tile_size).round()
	grid_change = grid_change as Vector2i
	#If there is a change
	if grid_change.length() >= 1:
		var old_grid_pos = stone.bracer_pos
		var new_grid_pos = stone.bracer_pos + grid_change
		new_grid_pos = handle_edges(new_grid_pos)
		if stone_grid[new_grid_pos.x][new_grid_pos.y] == null:
			stone.bracer_pos += grid_change
			#Handle wrapping around
			stone.bracer_pos = handle_edges(stone.bracer_pos)
			
			#Add stone to new spot in grid and remove from old
			stone_grid[new_grid_pos.x][new_grid_pos.y] = stone
			stone_grid[old_grid_pos.x][old_grid_pos.y] = null
			
		stone.pressed = false
		snap_home(stone)
		return true
	else:
		return false

#Maps a grid location back to the opposite side (touruous topology)
func handle_edges(grid_pos:Vector2i) -> Vector2i:
	return Vector2(posmod(grid_pos.x,grid_size),posmod(grid_pos.y,grid_size))
	
	
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


	
