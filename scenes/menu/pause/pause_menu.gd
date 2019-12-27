extends Control

var pause = false

func _ready():
	var _group = ButtonGroup.new()
	$resume.group = _group
	$quit.group = _group

func pause():
	visible = true
	get_tree().paused = true
	$resume.grab_focus()
	pause = true

func unpause():
	visible = false
	get_tree().paused = false
	pause = false

func _on_resume_button_up():
	unpause()


func _on_quit_button_up():
	transitionMgr.transitionTo("res://scenes/menu/title/titlescreen.tscn")

#func _input(event):
	#if event.is_action_pressed("ui_cancel"):
		#toggle()

func toggle():
	if pause:
		unpause()
	else:
		pause()