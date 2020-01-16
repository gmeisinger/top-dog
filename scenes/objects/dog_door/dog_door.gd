extends Node2D

export var dog_priority : int = 1

var path_speed = 100.0
var path_length

var busy = false

func _ready():
	path_length = $path.get_curve().get_baked_length() / path_speed

func follow_path(start_node : Area2D):
	var start = 0.0
	var end = 1.0
	if start_node.name == "2":
		#going backwards
		print("backward")
		start = 1.0
		end = 0.0
	$path/path_follow.unit_offset = start
	$path/path_follow/light.visible = true
	$Tween.interpolate_property($path/path_follow, "unit_offset", start, end, path_length, Tween.TRANS_LINEAR, Tween.EASE_IN)
	$Tween.start()
	busy = true
	#print("starting tween")
	yield($Tween, "tween_completed")
	#print("tween complete")
	$path/path_follow/light.visible = false
	busy = false