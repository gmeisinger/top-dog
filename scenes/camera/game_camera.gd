extends Camera2D

const DAMP_TIME = 0.5
const MIN_ZOOM = 0.3
const MAX_ZOOM = 1.0

var max_offset_x
var max_offset_y
onready var vp_size = get_viewport_rect().size
onready var tween = $Tween

onready var host = get_parent()

func _ready():
	globals.set("vp_size", vp_size)
	globals.set("camera", self)
	max_offset_x = vp_size.x/4
	max_offset_y = vp_size.y/4

func update_offset(target : Vector2):
	var new_offset = target / 4.0
	var distance = new_offset - offset
	if (distance.x < max_offset_x) and (distance.y < max_offset_y):
		tween.interpolate_property(self, "offset", offset, new_offset, DAMP_TIME, Tween.TRANS_QUAD, Tween.EASE_OUT)
		#offset = new_offset
		tween.start()

func _input(event):
	if Input.is_key_pressed(KEY_CONTROL) or host.control_mode == host.MODE_JOY:
		if event.is_action("zoom_in"):
			var new_zoom = max(MIN_ZOOM, zoom.x - 0.05)
			var vec = Vector2(new_zoom, new_zoom)
			tween.interpolate_property(self, "zoom", zoom, vec, DAMP_TIME/2, Tween.TRANS_QUAD, Tween.EASE_OUT)
			tween.start()
		elif event.is_action("zoom_out"):
			var new_zoom = min(MAX_ZOOM, zoom.x + 0.05)
			var vec = Vector2(new_zoom, new_zoom)
			tween.interpolate_property(self, "zoom", zoom, vec, DAMP_TIME/2, Tween.TRANS_QUAD, Tween.EASE_OUT)
			tween.start()