extends Control

var active_menu

onready var inventory = $inventory_menu
onready var pause = $pause_menu

func _input(event):
	if event.is_action_pressed("inventory"):
		var items = globals.get("player").get_items()
		inventory.update_inventory(items)
		toggle_menu("inventory_menu")
	elif event.is_action_pressed("ui_cancel"):
		hide_all()
		pause.toggle()

func show_menu(menu):
	menu.show()
	get_tree().paused = true

func hide_menu(menu):
	menu.hide()
	get_tree().paused = false

func toggle_menu(menu_name):
	var menu = get_node(menu_name)
	if not menu: return
	if menu.visible:
		hide_menu(menu)
	else:
		show_menu(menu)

func hide_all():
	for menu in get_children():
		hide_menu(menu)