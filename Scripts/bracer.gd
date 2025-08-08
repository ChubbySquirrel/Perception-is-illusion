extends Node2D
class_name Bracer

var stones: Dictionary[String,Stone]

var stone_types = {"A":true,"B":true,"C":true,"D":true}

var stone_grid: Array[Array]

var tile_size = 128

@export var grid_size = 5
#1/scale gets us the ratio of tiles in bracer vs labrinth
var bracer_scale:int  = 1

func _ready() -> void:
	
	pass
	
	
func check_moved(stone:Stone) -> bool:
	#If the tile has moved sufficently in a direction
	var rel_position = stone.global_position - stone.home_position()
	
	#Check if vector has crossed halfway between each grid section via rounding a relative change vector
		#Add this change vector to bracer_pos
		#Then pos mod round this bracer_pos vector
		#Then snap the stone to home

	var grid_change = (rel_position/tile_size).round()
	grid_change = grid_change as Vector2i
	#If there is a change
	if grid_change.length() >= 1:
		stone.bracer_pos += grid_change
		stone.bracer_pos = Vector2(posmod(stone.bracer_pos.x,grid_size),posmod(stone.bracer_pos.y,grid_size))
		stone.pressed = false
		stone.snap_home()
		return true
	else:
		return false
	
	
	
		#if new_grid_pos != stone.home_position():
			#if stone_grid[new_grid_pos.x][new_grid_pos.y ] == null:
				#stone_grid[stone.bracer_pos.x][stone.bracer_pos.y] = null
				#stone_grid[new_grid_pos.x][new_grid_pos.y] = Stone
				#stone.bracer_pos = new_grid_pos
				#print("Snapped to " + str(stone.bracer_pos))
				#print(new_grid_pos)
				#stone.pressed = false
				#stone.snap_home()
			#return true
		#else:
			#return false
	
	#
	#var position_change = (stone.position - stone.home_position())
	#var move_vector = Vector2.ZERO
	#
	#
	#if position_change.length() >= tile_size:
		#print("test")
		#
		#if abs(stone.position.x) > abs(stone.position.y):
			#if stone.position.x > 0:
				#move_vector = Vector2(1,0)
			#if stone.position.x < 0:
				#move_vector = Vector2(-1,0)
		#if abs(stone.position.x) < abs(stone.position.y):
			#if stone.position.y > 0:
				#move_vector = Vector2(0,1)
			#if stone.postion.y < 0:
				#move_vector = Vector2(0,-1)
		#var new_grid_pos = stone.bracer_pos as Vector2 + move_vector
		#if stone_grid[new_grid_pos.x as int][new_grid_pos.y as int] == null:
			#stone_grid[stone.bracer_pos.x][stone.bracer_pos.y] = 0
			#stone_grid[new_grid_pos.x][new_grid_pos.y] = Stone
			#stone.bracer_pos = new_grid_pos
			#stone.snap_home()
		#
#
		#else:
			##play sound
			#pass
		#return true
		#
	#else:
		#return false
		
	
	
#creates empty bracer grid based off of labrinth grid
func create_grid(grid:Grid):
	stone_grid = []
	for row_index in grid_size:
		var row = []
		for column_index in grid_size:
			row.append(null)
		stone_grid.append(row)
			
		
	


	
