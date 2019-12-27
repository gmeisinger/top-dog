extends "res://scenes/util/stateMachine/baseState.gd"

func enter():
	#host.drop_items()
	host.speed = host.base_speed
	host.move_target = Vector2.ZERO
	host.get_node("interactable").set_active(true)
	host.play_anim("sit")
	
func exit():
	host.get_node("interactable").set_active(false)