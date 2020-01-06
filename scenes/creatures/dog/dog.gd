extends "res://scenes/creatures/creature.gd"

var leader : Node2D
var next_state : String
var move_target : Vector2
var fetch_target
var path = []
var pickup_distance = 5.0
export var follow_distance : float = 15.0

var PATHFIND_DISTANCE = 300.0

var DEFAULT_DETECTOR_RADIUS = 250
var PRECISION_DETECTOR_RADIUS = 75

func _ready():
	SignalMgr.register_subscriber(self, "move_dog", "_on_move_dog")

func _on_move_dog(destination):
	path = globals.get("cur_scene").get_nav(global_position, destination)
	next_state = "waiting"
	$stateMachine.change_state("pathfinding")

func bark(time = 1.0):
	if !$speech_bubble.active:
		$speech_bubble.quick_message("Woof!", time)
	else:
		$speech_bubble.hide()

func update_anim():
	if $stateMachine.current_state.name == "waiting":
		play_anim("sit")
	elif velocity == Vector2.ZERO:
		play_anim("idle")
	else:
		play_anim("move")
		face_sprites(sign(velocity.x), sign(velocity.y))

func process_movement(delta):
	velocity = move_target.normalized() * speed
	update_anim()
	
func find_leader():
	if not leader: return Vector2.ZERO
	var target = leader.global_position - global_position
	if target.length() < follow_distance:
		target = Vector2.ZERO
	return target

func pickup_item(item_ref):
	item_ref.interact(self, "Pickup")

func drop_items():
	$inventoryMgr.drop_all_items()

func interact(source : Node, option : String):
	match(option):
		"Inspect":
			leader = source
			$stateMachine.change_state("follow")

func face_sprites(x, y):
	if x == 1:
		$Sprite.flip_h = false
	if x == -1:
		$Sprite.flip_h = true

func play_anim(anim_name, speed : float = 1.0):
	if $AnimationPlayer.current_animation != anim_name:
		$AnimationPlayer.play(anim_name, -1, speed)

func _on_radial_detector_area_entered(area):
	fetch_target = area
	$stateMachine.change_state("fetch")
