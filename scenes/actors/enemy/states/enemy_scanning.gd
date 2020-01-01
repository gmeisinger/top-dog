extends "res://scenes/util/stateMachine/baseState.gd"

var raycast : RayCast2D

var TICK = 0.5
var timer = 0.0

func enter():
	raycast = host.get_node("RayCast2D")
	#raycast.set_cast_to(host.get_target())
	#raycast.enabled = true

func update(delta):
	if host.has_weapon():
		host.unequip("weapon")
	host.play_anim("idle")
	timer += delta
	if timer >= TICK:
		timer = 0.0
		var found_player = check_for_player()
		if found_player:
			change_state("walking")
#	globals.get("cur_scene").draw_line(host.position, host.get_target(), Color(0, 0, 0), 2)
	#if raycast.is_colliding():
	#	change_state("walking")
	host.process_move_and_collide(delta)

func exit():
	raycast.enabled = false

func check_for_player():
	if not raycast:
		return false
	raycast.set_cast_to(host.get_target())
	raycast.force_raycast_update()
	if raycast.is_colliding():
		return false
	else:
		return true