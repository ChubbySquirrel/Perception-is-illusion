extends Node

@onready var grid : Grid = $Grid
@onready var brac = $Bracer
var called = false


func _ready() -> void:
	LevelManager.level_grid = grid
	LevelManager.bracer  = brac



	
	LevelManager.initialize_level("res://Resources/test.csv")
	brac.create_grid(LevelManager.level_grid)
	grid.tiles[1][1].set_color(Color.ORANGE)
	grid.tiles[3][5].set_color(Color.BLUE)
	
	var children = get_tree().current_scene.get_children()

			
func _process(_delta) -> void:
	if not called:
		var path = AStar.find_path(grid.tiles[1][1],grid.tiles[1][5])
		if path != null:
			for i in range(1,path.size()-1):
				path[i].set_color(Color.RED)
				pass
		called = true
