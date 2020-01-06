extends "res://scenes/util/stateMachine/baseState.gd"

func enter():
	host.get_node("interactable").set_active(false)
	host.speed = host.base_speed
	if not host.leader:
		host.leader = globals.get("player")

func update(delta):
	host.move_target = host.find_leader()
	host.process_movement(delta)
	var col = host.process_move_and_collide(delta)
	#check for stuck
	if col and (host.global_position.distance_to(host.leader.global_position) > host.PATHFIND_DISTANCE):
		host.next_state = "follow"
		host.path = globals.get("cur_scene").get_nav(host.global_position, host.leader.global_position)
		change_state("pathfinding")