class_name Player

extends CharacterBody2D

@export var speed : float = 100

@export var b : Bracer

var disabled = false

var grid : Grid

var moving: directions

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer


	
enum directions{
	UP,
	DOWN,
	LEFT,
	RIGHT,
}

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

	if Input.is_action_pressed("left") and not Input.is_action_pressed("right") :
		direction += Vector2.LEFT

	if Input.is_action_pressed("right") and not Input.is_action_pressed("left"):
		direction += Vector2.RIGHT
		
	direction = direction.normalized()
	if direction == Vector2.ZERO:
		play_idle()
	else:
		animation_player.play("walk_noise")
		if direction.x == 0:
			if direction.y <0:
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
	if countdown:
		t += delta
		if t >= suffocation_time:
			kill()


#play idle animation based on most recent direction state
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
	animation_player.play("Death")
	match moving:
		directions.DOWN:
			animated_sprite_2d.play("death_down")
		directions.UP:
			animated_sprite_2d.play("death_up")
		_:
			animated_sprite_2d.play("death_right")
	player_died.emit()

	

#func show_success_screen()->void:
	#Engine.time_scale = 0
	#sucess_view.visible = true

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

#Things to play after animation ends on player, only calls on animations that dont loop. Since only one is death
#This will only call on any of the death animations
func _on_animated_sprite_2d_animation_finished() -> void:
	Engine.time_scale = 0
	player_died.emit()
