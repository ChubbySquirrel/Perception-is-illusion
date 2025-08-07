extends Control

var rotate_mode = false
var slide_sense = 1
var pressed = false
var initial_mouse_pos: Vector2
var initial_pos: Vector2
var initial_rot: float
var rel_mouse_pos: Vector2
var rel_rot : float

func _process(delta: float) -> void:
	rotate_mode = Input.is_action_pressed("Rotate")
	var release_rotate = Input.is_action_just_released("Rotate")
	var start_rotate = Input.is_action_just_pressed("Rotate")
	
	if pressed:
		if release_rotate:
			initial_mouse_pos = get_global_mouse_position() - position
		if start_rotate:
			initial_rot = rotation
		var current_mouse_pos = get_global_mouse_position()
		rel_mouse_pos = current_mouse_pos - position
		if not rotate_mode:
			position = initial_pos + (current_mouse_pos - (initial_mouse_pos + position))*slide_sense
			
		else:
			rel_rot = atan2(initial_mouse_pos.x,initial_mouse_pos.y) - atan2(rel_mouse_pos.x,rel_mouse_pos.y)
			rotation = initial_rot + rel_rot

func _on_button_button_down() -> void:
	pressed = true
	initial_rot = rotation
	initial_mouse_pos = get_global_mouse_position() - position
	initial_pos = position
	
	pass # Replace with function body.


func _on_button_button_up() -> void:
	pressed = false
	initial_pos = position
	pass # Replace with function body.
