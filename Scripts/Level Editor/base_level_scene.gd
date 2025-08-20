extends Node2D

@onready var data: Node = $Data
@onready var icons: Node = $Icons


func _ready() -> void:
	return
	
func save_lvl_data(file_name: String, directory:String):
	var node_array = get_node("Data").get_children()
	if node_array.size() == 0:
		push_error("There is no data to save!")
	else:
		for node in data.get_children():
			if node.get_groups().has("Level_element"):
				SaveManager.save_lvl_data_to_json(file_name,SaveManager.node_to_json(node),directory)
	return
	
func load_lvl_data(file_path):
	var json_arr = SaveManager.load_lvl_data_from_json(file_path)
	for scene in json_arr:
		var new_node = SaveManager.json_to_node(scene)
		data.add_child(new_node)
		icons.add_child(new_node.icon)
	
