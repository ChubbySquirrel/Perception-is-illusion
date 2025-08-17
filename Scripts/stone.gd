extends Node2D
class_name Stone

var active = true
var rotating = false
var slide_sense = 1
var pressed = false
var initial_mouse_pos: Vector2
var initial_pos_on_click: Vector2
var initial_rot: float
var initial_pos: Vector2
var bracer_pos: Vector2i


var moved_to: Vector2

var t:float = 0

var bracer: Bracer

var type: String

var number: Polygon2D

func _ready() -> void:
	initial_pos = position
	number = find_child("Number")

func _process(delta: float) -> void:
	
	var release_rotate = Input.is_action_just_released("Rotate")
	var start_rotate = Input.is_action_just_pressed("Rotate")
	if active:
		if release_rotate:
			pressed = false
		if pressed:
			t = 0
			rotating = Input.is_action_pressed("Rotate")

			if start_rotate:
				initial_mouse_pos = get_global_mouse_position()
			
			
			
			var current_mouse_pos = get_global_mouse_position()
			var rel_current_mouse_pos = current_mouse_pos - position
			var rel_initial_mouse_pos = initial_mouse_pos - position
			
			if not rotating:
				position = initial_pos_on_click + rel_current_mouse_pos - rel_initial_mouse_pos
				
			else:
				rotation = initial_rot + atan2(rel_initial_mouse_pos.x,rel_initial_mouse_pos.y) - atan2(rel_current_mouse_pos.x,rel_current_mouse_pos.y)
			bracer.check_moved(self)
			bracer.check_rotate(self)
		
			
		else:
			if t >1:
				t = 0
			position = position.lerp(moved_to,t)
			rotation = lerp_angle(rotation,initial_rot,t)
			t += delta
			
			
			
		
	

func _on_button_button_down() -> void:

	pressed = true
	#Get current state and save it
	initial_mouse_pos = get_global_mouse_position()
	initial_pos_on_click = position
	
	pass # Replace with function body.


func _on_button_button_up() -> void:
	pressed = false
	pass # Replace with function body.


func create (itype:String,iactive:bool,sense:float,iposition:Vector2i ):
	type = itype
	active = iactive
	sense = slide_sense
	bracer_pos = iposition
	position = bracer.home_position(bracer_pos)
	number.texture = bracer.texture_dict[itype]
