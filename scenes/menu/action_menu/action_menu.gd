extends Control

onready var menu = $menu
var size = Vector2(128.0 , 128.0)

signal action_menu_choice(choice)

func _ready():
	globals.set("action_menu", self)
	SignalMgr.register_subscriber(self, "show_action_menu", "display")
	SignalMgr.register_publisher(self, "action_menu_choice")

func display(options):
	set_menu(options)
	menu.popup(Rect2(get_local_mouse_position(), menu.rect_size))

func _on_menu_minimum_size_changed():
	menu.rect_size = menu.rect_min_size

#items

func set_menu(items : Array):
	menu.clear()
	for item in items:
		if item is String:
			menu.add_item(item)

#show / hide

func _on_menu_about_to_show():
	pass

func _on_menu_popup_hide():
	pass

#Selection

func _on_menu_index_pressed(index):
	var text = menu.get_item_text(index)
	#just pass this text to player! ...
	emit_signal("action_menu_choice", text)
