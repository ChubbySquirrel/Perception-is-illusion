extends Node

func load_csv(file_path : String) -> Array:
	var file = FileAccess.open(file_path,FileAccess.READ)
	if not file:
		print("Failed to open file")
		return []
	
	var data = []
	while not file.eof_reached():
		var line : PackedStringArray = file.get_csv_line()
		var row : Array = Array(line)
		data.append(row)
	return data
