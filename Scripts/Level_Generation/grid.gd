class_name Grid

extends Node

var player_scene = preload("res://Scenes/Entities/player.tscn")

var found_start : bool = false

var grid_elements: Array

var player : Player

var tile_size : int = 128

func make_grid_from_file(file_path : String) -> void:
	var values : Array = CsvReader.load_csv(file_path)
	grid_elements = []
	var i = 0
	for row in values:
		var j = 0
		var new_row = []
		for element in row:
			if element == "s" and not found_start:
				player = player_scene.instantiate()
				add_child.call_deferred(player)
				player.position = Vector2(j*tile_size,i*tile_size)
				found_start = true
			var tile_type = TileRules.get_tile_type_from_string(element)
			var new_tile : Tile = Tile.new()
			if i > 0:
				new_tile.tile_above = grid_elements[i-1][j]
				grid_elements[i-1][j].tile_below = new_tile
			if j > 0:
				new_tile.tile_left = new_row[j-1]
				new_row[j-1].tile_right = new_tile
			new_tile.type = tile_type
			new_tile.i = i
			new_tile.j = j
			add_child(new_tile)
			new_tile.set_tile_position(Vector2(j*128,i*128))
			new_tile.set_text("I:"+str(i)+"J:"+str(j))
			j += 1
			new_row.append(new_tile)
		i += 1
		grid_elements.append(new_row)

func get_tile_from_position(p : Vector2) -> Tile:
	var i = roundi(p.y / tile_size)
	var j = roundi(p.x / tile_size)
	if i < grid_elements.size():
		var row = grid_elements[i]
		if j < row.size():
			return row[j]
	return null

func get_player_tile() -> Tile:
	return get_tile_from_position(player.position)
