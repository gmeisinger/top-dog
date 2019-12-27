extends Node2D

func hide_exterior():
	$tiles/exterior.hide()
	$tiles/decoration.hide()
	$door.hide()
	#collisions
	$tiles/exterior.set_collision_layer_bit(0, false)
	if $door.state == "open":
		$door.lock_state = true

func show_exterior():
	$tiles/exterior.show()
	$tiles/decoration.show()
	$door.show()
	$tiles/exterior.set_collision_layer_bit(0, true)
	$door.lock_state = false

func _on_door_open():
	$player_detector.monitoring = true


func _on_door_closed():
	if $player_detector.get_overlapping_areas().empty():
		$player_detector.monitoring = false


func _on_player_detector_area_entered(area):
	var pc = area.get_owner()
	var threshold = $door.position.y + $door.height
	if pc.position.y < threshold:
		hide_exterior()


func _on_player_detector_area_exited(area):
	show_exterior()
