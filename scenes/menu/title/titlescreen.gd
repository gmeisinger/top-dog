extends Control

func _ready():
	$buttons/start.grab_focus()

func _on_start_button_up():
	var scene = "res://scenes/menu/character_creator/character_creator.tscn"
	transitionMgr.transitionTo(scene)


func _on_exit_button_up():
	get_tree().quit()
