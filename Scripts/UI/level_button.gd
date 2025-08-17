class_name LevelButton

extends MarginContainer

@export var button_label : RichTextLabel

signal level_clicked(control : Control)

func set_button_text(t : String) -> void:
	button_label.text = t

func _on_button_button_down() -> void:
	level_clicked.emit(self)
