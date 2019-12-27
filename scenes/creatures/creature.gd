extends KinematicBody2D

onready var anim = $AnimationPlayer

#physics vars
var velocity = Vector2()
var speed : float
export var acceleration = 0.5
export var base_speed = 2.0
export var friction = 1.5

# Movement
func process_movement(delta):
	pass
	
func get_target():
	pass

func process_move_and_collide(delta):
	var collision_data = move_and_collide(velocity)
	return collision_data

# Animation
func face_sprites(x, y):
	pass

func play_anim(anim_name, speed : float = 1.0):
	pass

