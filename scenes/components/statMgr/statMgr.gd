extends Node

export var level : int = 1

# Core Stats

var core = {
	"toughness" : 1,
	"precision" : 1,
	"intelligence" : 1
	}

func get_core_stat(stat : String):
	return core[stat]

func get_core_mod(stat : String):
	if not core[stat] : return 0.0
	var mod = 1.0 + (float(core[stat]) * 0.01)
	return mod