extends Node2D


func _ready():
	globals.set("cur_scene", self)
	
func add_object(obj):
	$objects.add_child(obj)

func get_nav(pointA, pointB):
	#first get closest nav points
	var destination = pointB
	pointA = $map/nav.get_closest_point(pointA)
	pointB = $map/nav.get_closest_point(pointB)
	var path = $map/nav.get_simple_path(pointA, pointB)
	#if destination != pointB:
	#	path.append(destination)
	#print(path)
	return path