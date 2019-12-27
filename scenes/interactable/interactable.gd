extends Area2D

var selected = false
onready var outline_material = load("res://assets/shaders/outline.tres")

export(String, MULTILINE) var option_lines = "Inspect"
var options = []
var choice
var waiting_for_choice = false

onready var host = get_parent()

signal show_action_menu(opts)

func _ready():
	SignalMgr.register_publisher(self, "show_action_menu")
	SignalMgr.register_subscriber(self, "action_menu_choice", "_on_action_menu_choice")
	read_options()

func read_options():
	options.clear()
	for op in option_lines.split("\n"):
		options.append(op.capitalize())

func select(_selected : bool = true):
	selected = _selected
	if selected:
		host.set_material(outline_material)
	else:
		host.set_material(null)

func set_active(act = true):
	monitorable = act
	if !act:
		select(false)

func interact(source : Node):
	read_options()
	var selected = options[0]
	if options.size() > 1:
		options.append("Cancel")
		#emit_signal("show_action_menu", options)
		#waiting_for_choice = true
		#yield(globals.get("action_menu"), "action_menu_choice")
		#selected = choice
	host.interact(source, selected)

func _on_action_menu_choice(_choice):
	if waiting_for_choice:
		choice = _choice
		waiting_for_choice = false