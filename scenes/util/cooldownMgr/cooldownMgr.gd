extends Node

func add_cooldown(label : String, time : float):
	if get_node(label):
		get_node(label).queue_free()
	var new_cd = Cooldown.new(label, time)
	add_child(new_cd)
	new_cd.connect("cd_end", self, "_on_cd_end")

func has_cooldown(label):
	if get_node(label):
		return true
	else:
		return false

func _on_cd_end(_label):
	get_node(_label).queue_free()

class Cooldown:
	extends Node
	
	var label : String
	var time : float
	var timer
	
	signal cd_end(_label)
	
	func _init(_label : String, _time : float):
		label = _label
		time = _time
	
	func _ready():
		name = label
		start()
	
	func start():
		var new_timer = Timer.new()
		add_child(new_timer)
		new_timer.connect("timeout", self, "timer_timeout")
		new_timer.start(time)
	
	func timer_timeout():
		emit_signal("cd_end", label)
		