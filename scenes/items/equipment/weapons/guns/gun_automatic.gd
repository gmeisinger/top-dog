extends "res://scenes/items/equipment/weapons/guns/gun.gd"

""" Automatic Gun Template

This gun has a 'cooldown' that determines when it is ready to fire again

"""

const RECOIL_DECAY = 0.9

export var fire_rate : float = 0.05
export(float, 0.0, 1.0, 0.01) var recoil
var current_recoil : float = 0.0
var shooting = false

onready var shot_timer = $shot_timer

func primary_fire(target : Vector2):
	if current_recoil < 0.0:
		current_recoil = 0.0
	play_anim("fire")
	attack_ready = false
	shot_timer.start(fire_rate)
	var bullet = bullet_scn.instance()
	target = apply_accuracy(target, apply_recoil(accuracy))
	bullet.init(damage, enemy)
	#globals.get("cur_scene").add_object(bullet)
	bullet.position = $"Sprite/fire_point".global_position
	bullet.fire(target)
	shooting = true
	current_recoil += recoil * 0.6

func apply_recoil(_accuracy : float):
	if current_recoil == 0.0:
		return _accuracy
	var mod = 1.0 - current_recoil
	return _accuracy * mod

func _physics_process(delta):
	if current_recoil > 0.0:
		if shooting:
			shooting = false
		else:
			current_recoil = (current_recoil * RECOIL_DECAY) - (recoil * 0.1 * delta)

func _on_shot_timer_timeout():
	attack_ready = true