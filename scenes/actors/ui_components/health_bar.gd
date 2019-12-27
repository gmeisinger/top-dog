extends ProgressBar

var hp = 1.0
var max_hp = 1.0

export var disabled : bool = false

func _ready():
	refresh()

func refresh():
	if disabled:
		visible = false
		return
	value = hp / max_hp
	if value >= 1.0:
		visible = false
	else:
		visible = true

func _on_statMgr_hp_changed(new_hp):
	hp = new_hp
	refresh()

func _on_statMgr_stat_changed(stat, new_value):
	if stat == "max_hp":
		max_hp = new_value
