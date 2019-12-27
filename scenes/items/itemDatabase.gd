extends Node

var dict = {}

func _ready():
	get_paths()

func get(item_name):
	if dict.has(item_name):
		var path = dict[item_name]
		var item = load(path)
		return item.instance()
	else: return null

func get_paths():
	var path = "res://scenes/items/equipment/armor"
	read_folder(path)
	path = "res://scenes/items/equipment/helmets"
	read_folder(path)
	print(dict)

func read_folder(path):
	var dir = Directory.new()
	#equipment
	dir.open(path)
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with(".") and file.ends_with(".tscn"):
			var full_path = path + "/" + file
			var tex = load(full_path)
			var item_name = file.split(".tscn")[0]
			dict[item_name] = full_path
	dir.list_dir_end()
