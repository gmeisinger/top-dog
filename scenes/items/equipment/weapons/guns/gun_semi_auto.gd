extends "res://scenes/items/equipment/weapons/guns/gun.gd"

""" Semi Auto Gun Template

This gun will be ready to fire again once it's 'fire' animation has finished

"""

func primary_fire(target : Vector2):
	play_anim("fire")
	attack_ready = false
	var bullet = bullet_scn.instance()
	target = apply_accuracy(target, accuracy)
	bullet.init(damage, enemy)
	globals.get("cur_scene").add_object(bullet)
	bullet.position = $"Sprite/fire_point".global_position
	bullet.fire(target)
	

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "fire":
		attack_ready = true