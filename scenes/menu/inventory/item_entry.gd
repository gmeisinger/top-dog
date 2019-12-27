extends Control

export(String, FILE, "*.tscn") var item_scn

onready var image = $Button/image
onready var image_rect = $Button/image.texture.region
onready var normal_style = $"Button.custom_styles/normal"
onready var hover_style = $"Button.custom_styles/hover"

var info
var equipped = false

export var equipped_style : StyleBoxFlat
export var equipped_hover_style : StyleBoxFlat

#func _ready():
	#var tester = load(item_scn)
	#set_item(tester.instance().get_info())

signal selected(item_info)

func set_item(item_info : Dictionary):
	var tex = AtlasTexture.new()
	tex.atlas = item_info["sprite"]
	tex.region = item_info["icon"]
	image.set_texture(tex)
	info = item_info
	if item_info.has("equipped"):
		set_equipped(item_info["equipped"])

func set_group(_group):
	$Button.group = _group

func _on_Button_button_up():
	emit_signal("selected", self)



func set_equipped(eq):
	equipped = eq
	if equipped:
		$Button.add_stylebox_override("normal", equipped_style)
		$Button.add_stylebox_override("hover", equipped_hover_style)
	else:
		$Button.add_stylebox_override("normal", null)
		$Button.add_stylebox_override("hover", null)