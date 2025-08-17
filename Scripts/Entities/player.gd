class_name Player

extends CharacterBody2D

@export var speed : float = 100

@export var b : Bracer

var disabled = false

var grid : Grid

var bodies_intersecting : Dictionary[Node2D,bool] = {}

var countdown = false

var t : float = 0

var suffocation_time : float = 2

signal player_died

func _process(delta: float) -> void:
	if disabled:
		return
	
	var direction = Vector2()
	if Input.is_action_pressed("down"):
		direction += Vector2.DOWN
	if Input.is_action_pressed("up"):
		direction += Vector2.UP
	if Input.is_action_pressed("left"):
		direction += Vector2.LEFT
	if Input.is_action_pressed("right"):
		direction += Vector2.RIGHT
	velocity = direction*speed
	move_and_slide()
	if countdown:
		t += delta
		if t >= suffocation_time:
			kill()


func kill()->void:
	Engine.time_scale = 0
	disabled = true
	player_died.emit()

func make_stones(stones : Array[String], positions : Array[Vector2i])-> void:
	for i in range(stones.size()):
		var p : Vector2i = positions[i]
		b.create_stone(stones[i],b.handle_edges(Vector2(p.y,p.x)))

func check_stone_move(g : String, mov : Vector2i) -> bool:
	return grid.stone_manager.check_stone_move(g, mov)

func check_stone_rotate(g : String, dir : Vector2) -> bool:
	return grid.stone_manager.check_stone_rotate(g, dir)

func stone_move(g : String, mov : Vector2i) -> void:
	grid.stone_manager.stone_move(g, mov)

func stone_rotate(g : String, dir : Vector2) -> void:
	grid.stone_manager.stone_rotate(g,dir)


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body != self:
		bodies_intersecting.set(body,true)
		countdown = true


func _on_area_2d_body_exited(body: Node2D) -> void:
	if bodies_intersecting.has(body):
		bodies_intersecting.erase(body)
		if bodies_intersecting.size() == 0:
			t = 0
			countdown = false
