tool
extends Area2D

export var radius : int = 0

onready var host = get_parent()

func _ready():
	if radius == 0:
		radius = int(get_viewport_rect().size.x * 0.5)
	set_radius(radius)

func set_radius(r : int):
	$CollisionShape2D.get_shape().set_radius(radius)