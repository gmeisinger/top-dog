extends "res://scenes/util/stateMachine/baseState.gd"

func enter():
	host.get_node("interactable").set_active(false)
	host.speed = host.base_speed * 2
	if not host.leader:
		host.leader = globals.get("player")

func update(delta):
	host.move_target = host.find_leader()
	host.process_movement(delta)
	host.process_move_and_collide(delta)
	if host.move_target.length() <= host.follow_distance + 1:
		change_state("follow")

func exit():
	host.drop_items()