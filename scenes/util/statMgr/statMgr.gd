extends Node

const DEFAULT_MAX_HP = 100.0
const DEFAULT_MAX_ENERGY = 100.0

signal stat_changed(stat, new_value)
signal hp_changed(new_hp)
signal host_died()

onready var host = get_parent()

# final stats

var mods = {}
var stats = {
	"max_hp" : 100.0,
	"max_energy" : 100.0,
	"walk_speed" : 1.0
	}

# Base Stats

export var level : int = 1
export var aim : int = 10
export var speed : int = 10
export var vitality : int = 10
#export var intelligence : int = 10
#export var wits : int = 10
#export var luck : int = 10

# Resources

var hp : float
var energy : float

func _ready():
	apply_base_mods()
	#setup mod map
	for stat in stats.keys():
		mods[stat] = []
	hp = get("max_hp")
	emit_signal("hp_changed", hp)
	
func apply_base_mods():
	stats["max_hp"] = DEFAULT_MAX_HP * (float(vitality) * 0.1)
	emit_signal("stat_changed", "max_hp", stats["max_hp"])
	stats["max_energy"] = DEFAULT_MAX_ENERGY + (float(aim) * 3.0)
	emit_signal("stat_changed", "max_energy", stats["max_energy"])
	stats["walk_speed"] = 1.0 + (float(speed) * 0.05)
	emit_signal("stat_changed", "walk_speed", stats["walk_speed"])

func add_mod(stat : String, value : float, mult = false):
	if !mods.has(stat): return
	var new_mod = Mod.new(stat, value, mult)
	mods[stat].append(new_mod)

func get(stat : String):
	if !stats.has(stat):
		return null
	var final = stats.get(stat)
	var mod_list = mods.get(stat)
	for mod in mod_list:
		final += mod.value
	return final

func take_damage(damage : float):
	hp -= damage
	emit_signal("hp_changed", hp)
	if hp <= 0.0:
		hp = 0.0
		emit_signal("host_died")

func heal(amount : float):
	hp += amount
	if hp >= get("max_hp"):
		hp = get("max_hp")
	emit_signal("hp_changed", hp)

class Mod:
	
	var stat : String
	var value : float
	var mult = false
	
	func _init(_stat : String, _value : float, _mult = false):
		stat = _stat
		value = _value
		mult = _mult