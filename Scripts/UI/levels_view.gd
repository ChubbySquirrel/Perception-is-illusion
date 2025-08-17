extends Control

@export var grid : GridContainer
var level_scene = preload("res://Scenes/UI/level_button.tscn")
var button_map : Dictionary[Control,String] = {}

func _ready() -> void:
	var levels : MinBinaryHeap = CsvReader.get_all_level_csv()
	while levels.size() > 0:
		var priority = levels.peek_priority()
		var filename = levels.pop()
		var new_button : LevelButton = level_scene.instantiate()
		grid.add_child(new_button)
		new_button.set_button_text(str(priority as int))
		new_button.level_clicked.connect(load_level)
		button_map[new_button] = filename
		
		

func load_level(c : Control):
	var level_name = button_map[c]
	LevelManager.current_level_location = "res://Resources/Levels/"+level_name
	get_tree().change_scene_to_file("res://Scenes/Level_Generation/level_handler.tscn")


func _on_back_button_down() -> void:
	get_tree().change_scene_to_file("res://Scenes/UI/main_menu.tscn")
