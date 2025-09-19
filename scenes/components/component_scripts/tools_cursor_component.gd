class_name ToolCursorComponent
extends Node

var player: Player

func _ready() -> void:
	await get_tree().process_frame
	player = get_tree().get_first_node_in_group("player")

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("advanced_hit"):
		if InventoryManager.is_selected_item_tool():
			InventoryManager.perform_advanced_left_click(player)
	elif event.is_action_pressed("hit"):
		if InventoryManager.is_selected_item_tool():
			InventoryManager.perform_left_click(player)
