extends "res://scenes/actors/player/states/basePlayerState.gd"

var active = false

func enter():
	active = true

func update(delta):
	#if host.is_on_floor() && Input.is_action_just_pressed("jump"):
	#	change_state("jumping")
	#	return
	if Input.is_action_just_pressed("dodge") and host.velocity != Vector2.ZERO:
		change_state("dodging")
		return
	if Input.is_action_just_pressed("interact"):
		host.interact()
	#if Input.is_action_just_pressed("next_weapon") and not Input.is_key_pressed(KEY_CONTROL):
	#	host.get_node("inventoryMgr").equip_next_weapon()
	#elif Input.is_action_just_pressed("prev_weapon") and not Input.is_key_pressed(KEY_CONTROL):
	#		host.get_node("inventoryMgr").equip_next_weapon(-1)
	if Input.is_action_just_pressed("drop_weapon"):
		host.get_node("inventoryMgr").drop_item(host.get_node("inventoryMgr").equips["weapon"])
	if Input.is_action_pressed("primary"):
		host.primary_fire(host.get_target())
	if Input.is_action_just_pressed("secondary"):
		host.emit_signal("move_dog", host.global_position + host.get_target())
	if host.velocity == Vector2.ZERO:
		host.play_anim("idle")
	else:
		host.play_anim("walk")
	host.process_movement(delta)
	host.process_move_and_collide(delta)
	host.update_camera()

func exit():
	active = false
	
func _input(event):
	if active:
		if event.is_action_pressed("next_weapon"):
			if host.control_mode == host.MODE_MOUSE and not Input.is_key_pressed(KEY_CONTROL):
				host.get_node("inventoryMgr").equip_next_weapon()
		elif event.is_action_pressed("prev_weapon"):
			if host.control_mode == host.MODE_MOUSE and not Input.is_key_pressed(KEY_CONTROL):
				host.get_node("inventoryMgr").equip_next_weapon(-1)