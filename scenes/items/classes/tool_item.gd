class_name ToolItem
extends Item

@export var tool: DataTypes.ToolTypes

func _get_type() -> String:
	return "tool"

func _do_left_click(player: Player) -> void:
	pass

func _do_advanced_left_click(player: Player) -> void:
	pass
