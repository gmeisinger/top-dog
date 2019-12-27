extends Sprite

var lifetime = 0.0
var max_lifetime = 8.0

var speed = 400.0
var damage = 1.0
var knockback = 0.005

var fired = false
var velocity : Vector2 = Vector2(0.0, 0.0)

func init(_damage : float, enemy : bool = false):
	damage = _damage
	if enemy:
		$hitbox.set_collision_layer_bit(3, false)
		$hitbox.set_collision_layer_bit(4, true)
		$hitbox.set_collision_mask_bit(2, false)
		$hitbox.set_collision_mask_bit(1, true)

func fire(target : Vector2):
	fired = true
	velocity = target.normalized() * speed

func destroy():
	queue_free()

func _physics_process(delta):
	if fired:
		lifetime += delta
		position += velocity * delta
		if lifetime > max_lifetime:
			queue_free()

func _on_hitbox_body_entered(body):
	if body.get_collision_layer_bit(0):
		queue_free()



func _on_Timer_timeout():
	queue_free()
