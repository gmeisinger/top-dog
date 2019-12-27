extends "res://scenes/actors/actor.gd"

signal move_dog(destination)

#control vars
enum { MODE_MOUSE, MODE_JOY }
var control_mode = MODE_MOUSE
var joy = -1

func _ready():
	globals.set("player", self)
	SignalMgr.register_publisher(self, "update_inventory")
	SignalMgr.register_publisher(self, "move_dog")
	var fashion = globals.get("player_fashion")
	if fashion:
		set_hair(fashion.get("hair"))
		set_hair_color(fashion.get("hair_color"))
		set_shirt(fashion.get("shirt"))
		set_shirt_color(fashion.get("shirt_color"))
		set_pants(fashion.get("pants"))
		set_pants_color(fashion.get("pants_color"))


# Movement
func process_movement(delta):
	var target_speed = Vector2()
	if Input.is_action_pressed("move_up"):
		target_speed.y -= 1
	if Input.is_action_pressed("move_down"):
		target_speed.y += 1
	if Input.is_action_pressed("move_left"):
		target_speed.x -= 1
		h_face = -1
	if Input.is_action_pressed("move_right"):
		target_speed.x += 1
		h_face = 1
	#target_speed *= walk_speed
	velocity = target_speed.normalized() * max_speed
	#flip sprites
	.face_sprites(sign(get_target().x), sign(get_target().y))
	#update interactor
	$interactor.rotation = get_target().angle()

# Combat
func primary_fire(target : Vector2):
	if has_weapon():
		if get_weapon().ready:
			get_weapon().primary(target)

func get_target():
	match(control_mode):
		MODE_MOUSE:
			return get_local_mouse_position()
		MODE_JOY:
			var ret = $inputMgr.get_right_axis_vector(joy) * (globals.get("vp_size")/2) # to move outside of normal
			#if ret == Vector2.ZERO:
			#	ret = $inputMgr.get_left_axis_vector(joy) * (globals.get("vp_size")/8) 
			if ret == Vector2.ZERO:
				ret = $inputMgr.default_vector
				ret.x *= h_face
			return ret

func take_bullet(bullet):
#	$statMgr.take_damage(bullet.damage)
	#velocity = bullet.velocity * bullet.knockback
	bullet.destroy()

func interact():
	var next = $interactor.get_overlapping_areas()
	if !next.empty():
		next[0].interact(self)

func get_inventory():
	return $inventoryMgr
		
func _on_hitbox_area_entered(area):
	if area.get_collision_layer_bit(4):
		# ENEMY BULLET
		var bullet = area.get_owner()
		take_bullet(bullet)

func die():
	$statMgr.heal(80.0)
	

func update_camera():
	$game_camera.update_offset(get_target())

func _on_interactor_area_entered(area):
	area.select(true)
	
func _on_interactor_area_exited(area):
	area.select(false)