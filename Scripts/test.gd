extends Node

@onready var grid : Grid = $Grid
@onready var brac = $Bracer
var called = false


func _ready() -> void:
	pass

			
func _process(_delta) -> void:
	if not called:
		var path = AStar.find_path(grid.tiles[1][1],grid.tiles[1][5])
		if path != null:
			for i in range(1,path.size()-1):
				path[i].set_color(Color.RED)
				pass
		called = true
