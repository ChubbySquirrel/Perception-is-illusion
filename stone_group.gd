class_name  StoneGroup

extends Node

var speed : float = 0.1

var shrink_speed : float = 1

var group : String

var grid : Grid

var pivot : StoneWall

var movement_in_progress = false

var target : Vector2

var target_rotation : float

var lerp_position = true

var shrink_in_progress : bool = false

var t : float = 0

var walls : Array[StoneWall] = []

var manager : StoneGroupManager

var rotation_in_progress : bool = false

var rotation_speed : float = 1



func add_wall(w : StoneWall):
	walls.append(w)

func assign_pivot():
	if pivot == null:
		pivot = walls[0]
	add_child(pivot)
	pivot.position = Vector2(grid.tile_size * pivot.loc.y,grid.tile_size * pivot.loc.x)
	for wall : StoneWall in walls:
		if wall == pivot:
			continue
		pivot.add_child(wall)
		wall.global_position = Vector2(grid.tile_size * wall.loc.y,grid.tile_size * wall.loc.x)

func move(mov : Vector2) -> bool:
	begin_movement(mov)
	return true

func can_move(mov : Vector2i) -> bool:
	if movement_in_progress:
		return false
	var mov_possible : bool = true
	for wall in walls:
		var spot_open = manager.move_possible(wall.loc+Vector2i(mov.y,mov.x))
		if not spot_open:
			mov_possible = false
			break
	return mov_possible

func begin_movement(mov : Vector2) -> void:
	t = 0
	movement_in_progress = true
	lerp_position = true
	target = pivot.position + mov * grid.tile_size
	for wall in walls:
		var previous = wall.loc
		wall.loc += Vector2i(mov.y,mov.x)
		manager.change_position(previous,wall.loc)

func rotate(dir : Vector2)-> bool:
	begin_rotation(dir)
	return true


func begin_rotation(dir : Vector2) -> void:
	t = 0
	lerp_position = false
	movement_in_progress = true
	shrink_in_progress = true
	rotation_in_progress = false
	disable_child_colliders()
	match dir:
		Vector2.RIGHT:
			target_rotation = pivot.rotation + PI/2
			for wall in walls:
				var previous = wall.loc
				wall.loc = new_clockwise_position(wall)
				manager.change_position(previous,wall.loc)
		Vector2.LEFT:
			target_rotation = pivot.rotation - PI/2
			for wall in walls:
				var previous = wall.loc
				wall.loc = new_counterclockwise_position(wall)
				manager.change_position(previous,wall.loc)

func can_rotate(dir : Vector2) -> bool:
	var can_rotate = true
	if movement_in_progress:
		return false
	match dir:
		Vector2.LEFT:
			for wall in walls:
				if wall == pivot:
					continue
				var new_position = new_counterclockwise_position(wall)
				var moving_to_moving_tile = false
				for wall2 in walls:
					if wall2 == wall:
						continue
					if wall2.loc == new_position:
						moving_to_moving_tile = true
						break
				if moving_to_moving_tile:
					continue
				var spot_open = manager.move_possible(new_position)
				if not spot_open:
					can_rotate = false
					break
		Vector2.RIGHT:
			for wall in walls:
				if wall == pivot:
					continue
				var new_position = new_clockwise_position(wall)
				var moving_to_moving_tile = false
				for wall2 in walls:
					if wall2 == wall:
						continue
					if wall2.loc == new_position:
						moving_to_moving_tile = true
						break
				if moving_to_moving_tile:
					continue
				var spot_open = manager.move_possible(new_position)
				if not spot_open:
					can_rotate = false
					break
		_:
			return false
	return can_rotate

func new_clockwise_position(wall : StoneWall) -> Vector2i:
	var x = wall.loc.x-pivot.loc.x
	var y = wall.loc.y-pivot.loc.y
	var xp = y
	var yp = -x
	return Vector2i(xp+pivot.loc.x,yp+pivot.loc.y)

func new_counterclockwise_position(wall : StoneWall) -> Vector2i:
	var x = wall.loc.x-pivot.loc.x
	var y = wall.loc.y-pivot.loc.y
	var xp = -y
	var yp = x
	return Vector2i(xp+pivot.loc.x,yp+pivot.loc.y)

func disable_child_colliders():
	for wall in walls:
		if wall == pivot:
			continue
		else:
			wall.get_node("CollisionShape2D").disabled = true

func enable_child_colliders():
	for wall in walls:
		if wall == pivot:
			continue
		else:
			wall.get_node("CollisionShape2D").disabled = false

func _physics_process(delta: float) -> void:
	if movement_in_progress:
		if lerp_position:
			pivot.position = pivot.position.lerp(target,t*speed)
			t += delta
			if pivot.position.distance_to(target) <= 0.1:
				pivot.position = target
				movement_in_progress = false
		else:
			if shrink_in_progress and not rotation_in_progress:
				if walls.size() == 1:
					shrink_in_progress = false
					rotation_in_progress = true
				for wall : StoneWall in walls:
					if wall == pivot:
						continue
					wall.scale = wall.scale.lerp(Vector2.ZERO,shrink_speed*t)
					if wall.scale.distance_to(Vector2.ZERO) <= 0.1:
						wall.scale = Vector2.ZERO
						shrink_in_progress = false
						rotation_in_progress = true
				t += delta
				if rotation_in_progress:
					t = 0
			if rotation_in_progress:
				pivot.rotation = lerp_angle(pivot.rotation,target_rotation,t*rotation_speed)
				t += delta
				if abs(fmod(pivot.rotation-target_rotation,2*PI)) <= 0.1:
					pivot.rotation = target_rotation
					rotation_in_progress = false
					t = 0
					enable_child_colliders()
			if not rotation_in_progress and not shrink_in_progress:
				if walls.size() == 1:
					movement_in_progress = false
				for wall : StoneWall in walls:
					if wall == pivot:
						continue
					wall.scale = wall.scale.lerp(Vector2(1,1),shrink_speed*t)
					if wall.scale.distance_to(Vector2(1,1)) <= 0.1:
						wall.scale = Vector2(1,1)
						movement_in_progress = false
				t += delta
				if not movement_in_progress:
					t = 0
