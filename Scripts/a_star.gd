extends Node

func find_path(start : Tile, target : Tile):
	var minheap = MinBinaryHeap.new()
	var visited_map : Dictionary[Tile,bool]= {}
	minheap.push([start],start.get_tile_position().distance_to(target.get_tile_position()))
	while !minheap.is_empty():
		var closest_array = minheap.pop()
		var closest_tile : Tile = closest_array[closest_array.size()-1]
		var potential_tiles = [closest_tile.tile_above,closest_tile.tile_below,closest_tile.tile_left,closest_tile.tile_right]
		for tile : Tile in potential_tiles:
			if tile == null:
				continue
			if visited_map.has(tile):
				continue
			elif tile.blocked:
				continue
			else:
				if tile == target:
					closest_array.append(tile)
					return closest_array
				visited_map[tile] = true
				var new_array = closest_array.duplicate()
				new_array.append(tile)
				minheap.push(new_array,tile.get_tile_position().distance_to(target.get_tile_position()))
				
	return []
