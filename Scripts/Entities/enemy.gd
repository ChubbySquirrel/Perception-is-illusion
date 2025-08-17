class_name Enemy

extends NPC

var activate_on_ready = false
var activated = false
var player_tile

var animated_sprite_2d: AnimatedSprite2D

func activate() -> void:
	activated = true
	var t = grid.get_player_tile()
	go_to(t)


var player_eliminated = false

func  _ready() -> void:
	animated_sprite_2d = get_node("AnimatedSprite2D")
	if activate_on_ready:
		activate()
		
func _physics_process(_delta: float) -> void:
	
	var t = grid.get_player_tile()
	if player_tile != t:
		go_to(t)
		player_tile = t
	
	if player_eliminated:
		return

	var previous_collision = get_last_slide_collision()
	
	if previous_collision != null:
		if previous_collision.get_collider().is_in_group("Player"):
			previous_collision.get_collider().kill()
			state = Behaviours.IDLE
			beeline_target = null
			player_eliminated = true
			return
	
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(position,grid.player.position)
	var result = space_state.intersect_ray(query)
	if result:
		if result.collider.is_in_group("Player"):
			state = Behaviours.BEELINE
			beeline_target = grid.player
	else:
		state = Behaviours.FOLLOW
		go_to(grid.get_player_tile())
	if state == Behaviours.IDLE:
		animated_sprite_2d.play("idle")
	else:
		if velocity.x > 0:
			animated_sprite_2d.flip_h = false
		if velocity.x < 0: 
			animated_sprite_2d.flip_h = true
		animated_sprite_2d.play("walk")
	


	
