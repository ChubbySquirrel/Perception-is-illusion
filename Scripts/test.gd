extends Node

@onready var grid : Grid = $Grid

var called = false

func _ready() -> void:
	grid.make_grid_from_file("res://Resources/test.csv")
	grid.grid_elements[1][1].set_color(Color.ORANGE)
	grid.grid_elements[3][5].set_color(Color.BLUE)

func _process(_delta) -> void:
	if not called:
		var path = AStar.find_path(grid.grid_elements[1][1],grid.grid_elements[1][5])
		if path != null:
			for i in range(1,path.size()-1):
				path[i].set_color(Color.RED)
				pass
		called = true
