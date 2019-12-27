extends "res://scenes/util/stateMachine/baseState.gd"

func enter():
	host.position = Vector2.ZERO
	#apply mods?
	pass

func exit():
	#remove mods
	#unattach
	pass