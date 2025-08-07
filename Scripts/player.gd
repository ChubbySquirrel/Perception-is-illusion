extends CharacterBody2D

@export var speed : float = 100

func _process(delta: float) -> void:
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
