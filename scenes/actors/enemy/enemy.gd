extends "res://scenes/actors/actor.gd"

var target_location
var chasing = false
var ATTACK_DISTANCE = 32.0

export(String, FILE, "*.tscn") var weapon_path = "res://scenes/items/equipment/weapons/unarmed/unarmed_weapon.tscn"
onready var weapon_scene = load(weapon_path)
var weapon

var target

func _ready():
	max_speed = 3.0
	acceleration = 2.0
	weapon = weapon_scene.instance()
	equip(weapon)
	get_weapon().set_enemy(true)
	target = globals.get("player")

func get_target():
	return (target.global_position - global_position)

func speech_bubble(msg : String, time = 2.0):
	$speech_bubble.quick_message(msg, time)

# Movement
func process_movement(delta):
	var target_speed = global_position.direction_to(target.global_position)
	var delta_vel = target_speed.normalized() * delta * acceleration
	#target_speed *= walk_speed
	velocity += delta_vel
	if abs(velocity.x) > max_speed:
		velocity.x = sign(velocity.x) * max_speed
	if abs(velocity.y) > max_speed:
		velocity.y = sign(velocity.y) * max_speed
	apply_friction(delta)
	#flip sprites
	face_sprites(sign(get_target().x), sign(get_target().y))
	if global_position.distance_to(target.global_position) <= ATTACK_DISTANCE:
		$stateMachine.change_state("attacking")

# Combat

func take_bullet(bullet):
	$statMgr.take_damage(bullet.damage)
	velocity = bullet.velocity * bullet.knockback
	bullet.destroy()
	#die()

func die():
	$stateMachine.disabled = true
	play_anim("die")
	yield($AnimationPlayer, "animation_finished")
	queue_free()

func _on_hitbox_area_entered(area):
	if area.get_collision_layer_bit(3):
		var bullet = area.get_owner()
		take_bullet(bullet)

func _on_VisibilityEnabler2D_screen_entered():
	$stateMachine.disabled = false
