class_name Player

extends CharacterBody2D

@export var speed : float = 100

@export var sucess_view : Control

@export var go : Control

@export var b : Bracer

var disabled = false

var grid : Grid

var moving: directions

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

	
enum directions{
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

func _process(_delta: float) -> void:
	if disabled:
		return
	
	var direction = Vector2()
	if Input.is_action_pressed("down"):
		direction += Vector2.DOWN

	if Input.is_action_pressed("up"):
		direction += Vector2.UP

	if Input.is_action_pressed("left") and not Input.is_action_pressed("right") :
		direction += Vector2.LEFT

	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		direction += Vector2.RIGHT
		
	direction = direction.normalized()
	
	if direction.x == 0:
		if direction.y == 0:
			play_idle()
		elif direction.y <0:
			moving = directions.UP
			animated_sprite_2d.play("walk_up")
		elif direction.y >0:
			moving = directions.DOWN
			animated_sprite_2d.play("walk_down")
	elif direction.x > 0:
		moving = directions.RIGHT
		animated_sprite_2d.play("walk_right")
		animated_sprite_2d.flip_h = false
	elif direction.x < 0:
		moving = directions.LEFT
		animated_sprite_2d.play("walk_right")
		animated_sprite_2d.flip_h = true

		
	velocity = direction*speed
	

	move_and_slide()

func play_idle():
	match moving:
			directions.DOWN:
				animated_sprite_2d.play("idle_down")
			directions.UP:
				animated_sprite_2d.play("idle_up")
			_:
				animated_sprite_2d.play("idle_right")
		

func kill()->void:
	disabled = true
	$AnimationPlayer.play("Death")
	match moving:
		directions.DOWN:
			animated_sprite_2d.play("death_down")
		directions.UP:
			animated_sprite_2d.play("death_up")
		_:
			animated_sprite_2d.play("death_right")
			
	

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

#Things to play after animation ends on player, only calls on animations that dont loop. Since only one is death
#This will only call on any of the death animations
func _on_animated_sprite_2d_animation_finished() -> void:
	Engine.time_scale = 0
	go.visible = true
	pass # Replace with function body.
