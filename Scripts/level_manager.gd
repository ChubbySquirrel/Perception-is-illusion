extends Node

var level_grid: Grid
var bracer: Bracer
@export var default_stone_sense = 1

#Temp variables
var grid_width: int
var grid_height: int

var player_scene = preload("res://Scenes/player.tscn")


func _ready() -> void:
	
	pass
			

func initialize_level(file_path : String) -> void:
	var values : Array = CsvReader.load_csv(file_path)
	level_grid.tiles = []
	var i = 0
	for row in values:
		var j = 0
		var new_row = []
		for element in row:
			if element.contains("s"):
				var player : CharacterBody2D = player_scene.instantiate()
				level_grid.add_child(player)
				player.position = Vector2(j*128,i*128)
			var tile_type = TileRules.get_tile_type_from_string(element) 
			var new_tile : Tile = Tile.new()
			
			if element.contains("E"):
				spawn_enemy()	
			
			if i > 0:
				new_tile.tile_above = level_grid.tiles[i-1][j]
				level_grid.tiles[i-1][j].tile_below = new_tile
			if j > 0:
				new_tile.tile_left = new_row[j-1]
				new_row[j-1].tile_right = new_tile
			new_tile.type = tile_type
			level_grid.add_child(new_tile)
			new_tile.set_tile_position(Vector2(j*128,i*128))
			new_tile.set_text("I:"+str(i)+"J:"+str(j))
			j += 1
			new_row.append(new_tile)
		i += 1
		level_grid.tiles.append(new_row)
		
		
func spawn_enemy():
	pass
	
