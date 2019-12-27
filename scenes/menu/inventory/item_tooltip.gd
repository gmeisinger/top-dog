extends Control

onready var keys = $vbox/info/keys
onready var vals = $vbox/info/vals
onready var img = $vbox/top/CenterContainer/TextureRect
onready var item_name = $vbox/top/item_name

func set_item(item_info):
	clear_info()
	for key in item_info.keys():
		if key == "sprite":
			img.texture.atlas = item_info[key]
		elif key == "icon":
			img.texture.region = item_info[key]
		elif key == "name":
			item_name.set_text(item_info[key])
		elif key == "description":
			$vbox/description.set_text(item_info[key])
		elif key in ["reference", "type"] :
			pass
		else:
			#create key/val
			new_key(key)
			new_val(String(item_info[key]))

func clear_info():
	for child in keys.get_children():
		child.queue_free()
	for child in vals.get_children():
		child.queue_free()

func new_key(txt : String):
	var label = Label.new()
	var final_text = txt + " : "
	label.set_text(final_text.capitalize())
	keys.add_child(label)

func new_val(txt : String):
	var label = Label.new()
	label.set_text(txt)
	vals.add_child(label)