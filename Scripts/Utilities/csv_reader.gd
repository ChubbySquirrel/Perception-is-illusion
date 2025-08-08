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

func get_all_level_csv() -> MinBinaryHeap:
	var files : MinBinaryHeap = MinBinaryHeap.new()
	var dir = DirAccess.open("res://Resources/Levels")
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			if not dir.current_is_dir():
				if file_name.get_extension() == "csv":
					var level = get_level_from_filename(file_name.get_basename())
					files.push(file_name,level)
			file_name = dir.get_next()
	return files

func get_level_from_filename(fn : String) -> float:
	var parts = fn.split("_")
	return float(parts[1])
