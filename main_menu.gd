extends Control


func _on_exit_button_down() -> void:
	get_tree().quit(0)


func _on_levels_button_down() -> void:
	get_tree().change_scene_to_file("res://levels_view.tscn")
