extends Control

@export var main_menu : PackedScene

var test 

func _ready() -> void:
	test = preload("res://Scenes/test.tscn")


func _on_restart_button_down() -> void:
	var tree = get_tree()
	var current_scene = tree.current_scene
	var new_root = test.instantiate()
	tree.get_root().add_child(new_root)
	tree.get_root().remove_child(current_scene)
	tree.current_scene = new_root
	Engine.time_scale = 1	


func _on_main_menu_button_down() -> void:
	Engine.time_scale = 1
	get_tree().change_scene_to_packed(main_menu)
