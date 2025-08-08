class_name Player

extends CharacterBody2D

@export var speed : float = 100

@export var sucess_view : Control

var disabled = false

var game_over = preload("res://Scenes/UI/death_screen.tscn")

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
	var go = game_over.instantiate()
	add_child(go)

func show_success_screen()->void:
	Engine.time_scale = 0
	sucess_view.visible = true
