extends Node2D

var on_position = false

func toggle():
	globals.get("camera").toggle_darkness()
	if on_position:
		turn_off()
	else:
		turn_on()

func turn_on():
	on_position = true
	$AnimationPlayer.play("turn_on")

func turn_off():
	on_position = false
	$AnimationPlayer.play("turn_off")

func interact(source : Node, option : String):
	match(option):
		"Inspect":
			toggle()
		"Cancel":
			pass