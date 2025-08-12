class_name Player

extends CharacterBody2D

@export var speed : float = 100

@export var sucess_view : Control

@export var go : Control

@export var b : Bracer

var disabled = false

var grid : Grid

func _process(_delta: float) -> void:
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

func kill()->void:
	Engine.time_scale = 0
	disabled = true
	go.visible = true

func show_success_screen()->void:
	Engine.time_scale = 0
	sucess_view.visible = true

func make_stones(stones : Array[String])-> void:
	for stone in stones:
		b.create_stone(stone,Vector2i(1,2))

func check_stone_move(g : String, mov : Vector2i) -> bool:
	return grid.stone_manager.check_stone_move(g, mov)

func check_stone_rotate(g : String, dir : Vector2) -> bool:
	return grid.stone_manager.check_stone_rotate(g, dir)

func stone_move(g : String, mov : Vector2i) -> void:
	grid.stone_manager.stone_move(g, mov)

func stone_rotate(g : String, dir : Vector2) -> void:
	grid.stone_manager.stone_rotate(g,dir)
