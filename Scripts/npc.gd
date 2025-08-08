class_name NPC

extends CharacterBody2D

@export var speed = 100

var current_index : int = 0
var path : Array
var state : Behaviours = Behaviours.IDLE
var grid : Grid
var beeline_target : Node2D

enum Behaviours {
	IDLE,
	FOLLOW,
	BEELINE
}

func _process(_delta: float) -> void:
	match state:
		Behaviours.IDLE:
			return
		Behaviours.FOLLOW:
			var target : Vector2 = path[current_index].get_tile_position()
			if position.distance_to(target) < 1:
				if current_index == path.size()-1:
					state = Behaviours.IDLE
				else:
					current_index += 1
					target = path[current_index].get_tile_position()
			var direction = (target - position).normalized()
			velocity = direction*speed
			move_and_slide()
		Behaviours.BEELINE:
			var direction = (beeline_target.position-position).normalized()
			velocity = direction*speed
			move_and_slide()

func go_to(tile : Tile):
	if tile == null:
		state = Behaviours.IDLE
		return
	var current_tile : Tile = grid.get_tile_from_position(position)
	if current_tile == null:
		state = Behaviours.IDLE
		return
	current_index = 0
	path = AStar.find_path(current_tile,tile)
	if path.size() == 0:
		state = Behaviours.IDLE
		return
	state = Behaviours.FOLLOW
