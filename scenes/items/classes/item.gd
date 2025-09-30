class_name Item
extends Sprite2D

@export var display_name: String
@export var amount: int = 1
@export var stackable: bool = true

func _get_texture() -> Texture2D:
	return get_texture()

func _get_type() -> String:
	return "item"

func _on_hotbar_selected() -> void:
	pass

func _on_hotbar_deselected() -> void:
	pass
