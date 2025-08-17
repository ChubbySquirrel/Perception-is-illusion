extends Control

@export var pause_menu : Control 

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("pause"):
		show_pause_menu()

func show_pause_menu():
	Engine.time_scale = 0
	pause_menu.visible = true
