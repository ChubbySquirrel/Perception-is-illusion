class_name Enemy

extends NPC

func activate() -> void:
	var t = grid.get_player_tile()
	go_to(t)

var player_eliminated = false

func _physics_process(_delta: float) -> void:
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
