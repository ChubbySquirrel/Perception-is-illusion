class_name Enemy

extends NPC

var activate_on_ready = false
var activated = false
var player_tile
var player_eliminated = false

@export var shape_cast : ShapeCast2D

var animated_sprite_2d: AnimatedSprite2D

func activate() -> void:
	activated = true
	var t = grid.get_player_tile()
	go_to(t)

func  _ready() -> void:
	animated_sprite_2d = get_node("AnimatedSprite2D")
	if activate_on_ready:
		activate()

func on_map_updated() -> void:
	player_tile = grid.get_player_tile()
	go_to(player_tile)

func _physics_process(_delta: float) -> void:
	if player_eliminated:
		return

	var t = grid.get_player_tile()
	if player_tile != t:
		go_to(t)
		player_tile = t
	


	var previous_collision = get_last_slide_collision()
	
	if previous_collision != null:
		if previous_collision.get_collider().is_in_group("Player"):
			previous_collision.get_collider().kill()
			state = Behaviours.IDLE
			beeline_target = null
			player_eliminated = true
			return
	
	shape_cast.target_position = grid.player.global_position - shape_cast.global_position
	shape_cast.force_shapecast_update()
	if shape_cast.is_colliding():
		var result = shape_cast.get_collider(0)
		if result:
			if result.is_in_group("Player"):
				state = Behaviours.BEELINE
				beeline_target = grid.player
	
	if state == Behaviours.FOLLOW:
		if current_index <= path.size()-2:
			shape_cast.target_position = path[current_index + 1].get_tile_global_position() - global_position
			shape_cast.force_shapecast_update()
			if not shape_cast.is_colliding():
				current_index += 1
	if state == Behaviours.IDLE:
		animated_sprite_2d.play("idle")
	else:
		if velocity.x > 0:
			animated_sprite_2d.flip_h = false
		if velocity.x < 0: 
			animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	


	
