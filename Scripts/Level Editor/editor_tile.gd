extends Control
class_name Editor_Tile

var icon 

func _ready() -> void:
	get_node("TextureButton").texture_normal = icon
	
	

	
