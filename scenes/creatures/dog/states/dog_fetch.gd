extends "res://scenes/util/stateMachine/baseState.gd"

func enter():
	host.get_node("interactable").set_active(false)
	host.drop_items()
	host.speed = host.base_speed * 2
	host.bark()
	if not host.fetch_target:
		change_state("follow")

func update(delta):
	host.move_target = host.fetch_target.global_position - host.global_position
	host.process_movement(delta)
	host.process_move_and_collide(delta)
	if host.move_target.length() < host.pickup_distance and host.fetch_target.host.get_state() == "pickup":
		host.pickup_item(host.fetch_target.host)
		change_state("return")
	
func exit():
	pass