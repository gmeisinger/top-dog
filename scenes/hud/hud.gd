extends CanvasLayer

func _ready():
	SignalMgr.register_subscriber(self, "zombie_count_changed", "update_zombie_count")

func update_zombie_count(count):
	var text = "Zombies: " + String(count)
	$zombie_count.set_text(text)
