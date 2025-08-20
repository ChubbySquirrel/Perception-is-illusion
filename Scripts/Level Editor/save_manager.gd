extends Node

#Goal of this script is to use csv loader (ideally renamed to JSON loader) to load file data
#and for this file data to include all information about the objects.

#When a save is loaded (into level editor) it should load all save data
#as a child of data node and all corresponding Icons for those scenes.


func load_lvl_data_from_json(file_path : String):
	var file = FileAccess.open(file_path,FileAccess.READ)
	if not FileAccess.file_exists(file_path):
		var json = file.get_as_text()
		file.close()
		
		#If serialized properly this should be an array of dictionaries.
		var json_arr = JSON.parse_string(json)
		print(json_arr)
		return json_arr
	else:
		push_error("Could not Open File")
		return {}		

func save_lvl_data_to_json(file_name: String,json_string,directory: String):
	var output_file = FileAccess.open(directory + "/" + file_name, FileAccess.WRITE)
	var error = output_file.get_open_error()
	if not error:
		output_file.store_string(json_string)
	else:
		push_error(error)
	
func node_to_json(node,full_objects: bool = false):
	return JSON.stringify(JSON.from_native(node,full_objects))
	
func json_to_node(json_string,allow_objects: bool = false):
	return JSON.to_native(json_string,allow_objects)
	
	
