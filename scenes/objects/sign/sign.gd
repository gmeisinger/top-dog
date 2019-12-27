extends Node2D

export var message : String

func say(msg : String, time = 3.0):
	if !$speech_bubble.active:
		$speech_bubble.quick_message(msg, time)
	else:
		$speech_bubble.hide()


func interact(source : Node, option : String):
	match(option):
		"Inspect":
			say(message)
		"Cancel":
			pass