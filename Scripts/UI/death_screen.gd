extends Control

@export var main_menu : PackedScene

var test 

func _ready() -> void:
	test = preload("res://Scenes/test.tscn")


func _on_restart_button_down() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()


func _on_main_menu_button_down() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_file("res://Scenes/UI/levels_view.tscn")


func _on_resume_button_down() -> void:
	Engine.time_scale = 1
	visible = false
