extends Control

var rotating = false
var slide_sense = 1
var pressed = false
var initial_mouse_pos: Vector2
var initial_pos: Vector2
var initial_rot: float


func _process(delta: float) -> void:
	rotating = Input.is_action_pressed("Rotate")
	var release_rotate = Input.is_action_just_released("Rotate")
	var start_rotate = Input.is_action_just_pressed("Rotate")
	
	
	
	if pressed:
		if start_rotate:
			initial_rot = rotation
			initial_mouse_pos = get_global_mouse_position()
		if release_rotate:
			initial_mouse_pos = get_global_mouse_position()
			initial_pos = position
			initial_rot = rotation
			
		
		
		var current_mouse_pos = get_global_mouse_position()
		var rel_current_mouse_pos = current_mouse_pos - position
		var rel_initial_mouse_pos = initial_mouse_pos - position
		
		if not rotating:
			position = initial_pos + rel_current_mouse_pos - rel_initial_mouse_pos
		else:
			rotation = initial_rot + atan2(rel_initial_mouse_pos.x,rel_initial_mouse_pos.y) - atan2(rel_current_mouse_pos.x,rel_current_mouse_pos.y)
		
	
	

func _on_button_button_down() -> void:
	pressed = true
	#Get current state and save it
	initial_mouse_pos = get_global_mouse_position()
	initial_pos = position
	initial_rot = rotation
	
	pass # Replace with function body.


func _on_button_button_up() -> void:
	pressed = false
	pass # Replace with function body.
