extends "res://scenes/util/stateMachine/baseState.gd"

var MIN_DISTANCE = 5.0
var step = 0

func enter():
	host.get_node("interactable").set_active(false)
	host.drop_items()
	host.speed = host.base_speed * 2
	host.bark()
	step = 0
	if not host.next_state:
		host.next_state = "waiting"

func update(delta):
	host.move_target = host.path[step] - host.global_position
	if host.move_target.length() < MIN_DISTANCE:
		step += 1
		if step == host.path.size():
			change_state(host.next_state)
	host.process_movement(delta)
	host.process_move_and_collide(delta)

func exit():
	pass