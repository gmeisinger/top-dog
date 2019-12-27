extends "res://scenes/items/equipment/weapons/old_weapon.gd"

"""
Base class for guns

on top of weapon class, guns need to aim

George Meisinger 2019
"""

export(float, 0.0, 1.0, 0.01) var accuracy = 1.0 #perfect accuracy

var bullet_scn = load("res://scenes/items/equipment/weapons/bullets/bullet.tscn")
var enemy = false

func set_enemy(_enemy = true):
	enemy = _enemy

func primary_fire(target : Vector2):
	pass

# Uses a value between 0.0 and 1.0 to adjust the target point randomly
func apply_accuracy(target : Vector2, _accuracy : float):
	var angle = target.angle()
	var mod = 1.0 - _accuracy
	var new_angle_min = angle - (0.5 * (mod * PI))
	var new_angle_max = angle + (0.5 * (mod * PI))
	var new_angle = rand_range(new_angle_min, new_angle_max)
	var new_target = Vector2(cos(new_angle), sin(new_angle)) * target.length()
	return new_target

func _on_AnimationPlayer_animation_finished(anim_name):
	pass
