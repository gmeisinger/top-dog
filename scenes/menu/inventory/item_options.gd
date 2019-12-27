extends Control

onready var buttons = $hbox/vbox
onready var inventory_menu = get_owner()

func set_options(item_info):
	clear_options()
	match(item_info["type"]):
		"item":
			pass
		"weapon":
			if item_info["equipped"]:
				add_option("unequip")
			else:
				add_option("equip")
		"armor":
			pass

func get_focus():
	var first = buttons.get_child(0)
	first.grab_focus()

func add_option(text : String):
	var new_button = Button.new()
	new_button.name = text
	new_button.set_text(text.capitalize())
	#new_button.group = button_group
	buttons.add_child(new_button)
	# Connect the button to a function
	new_button.connect("button_up", inventory_menu, "_on_option_button_up", [new_button.name])
	
func clear_options():
	for button in buttons.get_children():
		button.queue_free()

func get_button(but_name):
	return buttons.get_node(but_name)