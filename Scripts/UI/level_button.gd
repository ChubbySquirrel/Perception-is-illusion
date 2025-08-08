class_name LevelButton

extends MarginContainer

@export var button : Button

signal level_clicked(control : Control)

func set_button_text(t : String) -> void:
	button.text = t

func _on_button_button_down() -> void:
	print("button_pressed")
	level_clicked.emit(self)
