class_name HoverItemContainer
extends PanelContainer

@onready var texture_rect: TextureRect = $HBoxContainer/TextureRect
@onready var label: Label = $HBoxContainer/Label


var texture : Texture2D
var amaount : int

func _ready() -> void:
	texture_rect.texture = texture
	label.text = "x" + str(amaount)
	label.label_settings = LabelSettings.new()
	label.label_settings.font_size = 18

func setup(text : Texture2D, am : int) -> void:
	texture = text
	amaount = am
	if texture_rect != null && label != null:
		texture_rect.texture = texture
		label.text = "x" + str(amaount)

func set_color(color : Color) -> void:
	label.label_settings.font_color = color
