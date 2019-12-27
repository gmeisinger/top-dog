extends "res://scenes/util/stateMachine/baseState.gd"

var PATHFIND_DISTANCE = 300.0

func enter():
	host.speed = host.base_speed
	if not host.leader:
		host.leader = globals.get("player")

func update(delta):
	host.move_target = host.find_leader()
	host.process_movement(delta)
	var col = host.process_move_and_collide(delta)
	if col and (host.global_position.distance_to(host.leader.global_position) > PATHFIND_DISTANCE):
		host.next_state = "follow"
		host.path = globals.get("cur_scene").get_nav(host.global_position, host.leader.global_position)
		change_state("pathfinding")