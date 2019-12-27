tool
extends Control

var entry_scn = preload("res://scenes/menu/inventory/item_entry.tscn")

onready var grid = $PanelContainer/left/grid
onready var tooltip = $PanelContainer/right/item_tooltip
onready var button_group = ButtonGroup.new()
onready var item_options = $PanelContainer/right/item_options

var equipped = []
var selected

func _ready():
	SignalMgr.register_subscriber(self, "update_inventory", "update_inventory")
	for item in grid.get_children():
		item.connect("selected", self, "_on_item_button_up")
		item.set_group(button_group)

func find_item(item_name):
	for entry in grid.get_children():
		if entry.info["name"] == item_name:
			return entry 

func add_item(item_info):
	var new_entry = entry_scn.instance()
	grid.add_child(new_entry)
	new_entry.set_item(item_info)
	new_entry.connect("selected", self, "_on_item_button_up")
	new_entry.set_group(button_group)

func _on_item_button_up(button):
	var info = button.info
	selected = info
	tooltip.set_item(info)
	item_options.set_options(info)
	#item_options.get_focus()
	#update_inventory(globals.get("player").get_items())

func _on_option_button_up(option : String):
	match(option):
		"equip":
			globals.get("player").get_node("inventoryMgr").equip(selected)
		#	item_options.get_button("equip").set_text("unequip")
		"unequip":
			if selected["equipped"]:
				globals.get("player").get_node("inventoryMgr").unequip(selected)
		#		item_options.get_button("equip").set_text("equip")
	update_inventory(globals.get("player").get_items())

func update_inventory(items):
	clear_grid()
	for item in items:
		if item:
			add_item(item)
	if selected:
		var found = find_item(selected["name"])
		if found:
			tooltip.set_item(found.info)
			item_options.set_options(found.info)
			selected = found.info
	
func clear_grid():
	for item in grid.get_children():
		item.queue_free()
