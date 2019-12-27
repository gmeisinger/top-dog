extends "res://scenes/actors/player/states/basePlayerState.gd"

func enter():
	var speed
	if not speed:
		speed = 1.0
	host.play_anim("dodge", speed)
	host.velocity *= 2.0
	host.face_sprites(sign(host.velocity.x), sign(host.velocity.y))
	host.get_node("hitbox").monitoring = false

func update(delta):
	if not host.anim_playing():
		change_state("walking")
		return
	#host.process_movement(delta)
	host.process_move_and_collide(delta)
	host.update_camera()

func exit():
	#host.add_cooldown("dodge", 0.1)
	host.get_node("hitbox").monitoring = true