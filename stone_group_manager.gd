class_name StoneGroupManager

extends Node

signal map_updated

var groups : Dictionary[String,StoneGroup] = {}

var grid : Grid

var stone_locations : Dictionary[int,Dictionary] = {}

var wall_scene = preload("res://stone_wall.tscn")

func add_stone(stone_data : Variant, loc : Vector2i,) -> bool:
	var g = stone_data.group
	if not groups.has(g):
		var new_group : StoneGroup = StoneGroup.new()
		new_group.manager = self
		new_group.grid = grid
		new_group.group = g
		add_child(new_group)
		groups[g] = new_group
		
	if stone_locations.has(loc.x):
		var row : Dictionary = stone_locations.get(loc.x)
		if row.has(loc.y):
			return false
		else:
			var stone = make_new_stone_wall(g, loc)
			stone.stone_group = groups[g]
			stone.loc = loc
			groups[g].add_wall(stone)
			if "pivot" in stone_data:
				if stone_data.pivot:
					groups[g].pivot = stone
			row.set(loc.y,stone)
			return true
	else:
		var row = {}
		var stone = make_new_stone_wall(g, loc)
		stone.stone_group = groups[g]
		stone.loc = loc
		groups[g].add_wall(stone)
		if "pivot" in stone_data:
			if stone_data.pivot:
				groups[g].pivot = stone
		row.set(loc.y,stone)
		stone_locations.set(loc.x,row)
		return true

func location_occupied(p : Vector2i) -> bool:
	if stone_locations.has(p.x):
		var row = stone_locations.get(p.x)
		if row.has(p.y):
			return true
	return false

func move_possible(p : Vector2i) -> bool:
	return not location_occupied(p) and grid.get_tile_open(p)

func make_new_stone_wall(g : String, loc : Vector2i) -> StoneWall:
	var new_wall : StoneWall = wall_scene.instantiate()
	return new_wall

func assign_pivots()-> void:
	for i : StoneGroup in groups.values():
		i.assign_pivot()

func check_stone_move(g : String, mov : Vector2i) -> bool:
	var group = groups[g]
	return group.can_move(mov)

func stone_move(g : String, mov : Vector2i) -> void:
	var group = groups[g]
	group.move(Vector2(mov.x,mov.y))
	map_updated.emit()

func check_stone_rotate(g : String, dir : Vector2) -> bool:
	var group = groups[g]
	return group.can_rotate(dir)

func stone_rotate(g : String, dir : Vector2) -> void:
	var group = groups[g]
	group.rotate(dir)
	map_updated.emit()

func change_position(before : Vector2i, after : Vector2i) -> bool:
	if stone_locations.has(before.x):
		var row = stone_locations.get(before.x)
		if row.has(before.y):
			var to_move = row.get(before.y)
			if stone_locations.has(after.x):
				var next_row = stone_locations.get(after.x)
				if next_row.has(after.y):
					return false
				next_row.set(after.y, to_move)
			else:
				var new_row = {}
				new_row.set(after.y,to_move)
				stone_locations.set(after.x,new_row)
			row.erase(before.y)
			return true
	return false
