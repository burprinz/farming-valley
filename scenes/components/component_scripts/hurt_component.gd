class_name HurtComponent
extends Area2D

@export var tool : DataTypes.ToolTypes = DataTypes.ToolTypes.None

signal hurt

func _on_area_entered(area: Area2D) -> void:
	var hit_component = area as HitComponent	
	if tool == InventoryManager.get_selected_tool_type():
		hurt.emit(hit_component.hit_damage)
