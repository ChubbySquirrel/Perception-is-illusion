extends Control

@export var pause_menu : Control 

func show_pause_menu():
	Engine.time_scale = 0
	pause_menu.visible = true
