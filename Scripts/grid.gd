class_name Grid

extends Node

var player_scene = preload("res://Scenes/player.tscn")

var grid_elements: Array

func make_grid_from_file(file_path : String) -> void:
	var values : Array = CsvReader.load_csv(file_path)
	grid_elements = []
	var i = 0
	for row in values:
		var j = 0
		var new_row = []
		for element in row:
			if element == "s":
				var player : CharacterBody2D = player_scene.instantiate()
				get_tree().root.add_child.call_deferred(player)
				player.position = Vector2(j*128,i*128)
			var tile_type = TileRules.get_tile_type_from_string(element)
			var new_tile : Tile = Tile.new()
			if i > 0:
				new_tile.tile_above = grid_elements[i-1][j]
				grid_elements[i-1][j].tile_below = new_tile
			if j > 0:
				new_tile.tile_left = new_row[j-1]
				new_row[j-1].tile_right = new_tile
			new_tile.type = tile_type
			add_child(new_tile)
			new_tile.set_tile_position(Vector2(j*128,i*128))
			new_tile.set_text("I:"+str(i)+"J:"+str(j))
			j += 1
			new_row.append(new_tile)
		i += 1
		grid_elements.append(new_row)
