extends TextureButton
class_name Icon

#stores what scene needs to be updated when this Icon is updated in the level_editor
var scene: LevelObject

var level_grid_position: Vector2i

func _ready() -> void:
	level_grid_position = scene.level_grid_postiion
	return
