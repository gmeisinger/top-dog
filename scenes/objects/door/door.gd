extends Node2D

signal open
signal closed

var OPEN_TIME = 2.0

var height = 64.0
var lock_state = false
var state = "closed"

func open():
	$AnimationPlayer.play("open")
	$collision.set_collision_layer_bit(0, false)

func close():
	$AnimationPlayer.play("close")

func _on_AnimationPlayer_animation_finished(anim_name):
	match(anim_name):
		"open":
			state = "open"
			#disable collision
			$collision.set_collision_layer_bit(0, false)
			emit_signal("open")
			$Timer.start(OPEN_TIME)
			pass
		"close":
			state = "closed"
			#enable collision
			$collision.set_collision_layer_bit(0, true)
			emit_signal("closed")
			pass


func _on_radial_detector_area_entered(area):
	if state == "closed" and not lock_state:
		open()


func _on_radial_detector_area_exited(area):
	if state == "open" and not lock_state:
		close()


func _on_Timer_timeout():
	if $radial_detector.get_overlapping_areas().empty() and state == "open" and not lock_state:
		close()
	
	
	
	
