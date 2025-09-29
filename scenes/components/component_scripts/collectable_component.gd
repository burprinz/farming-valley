class_name CollectableComponent
extends Area2D

@export var parent_item: Item

func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		
		var am = parent_item.amount
		var remaining = InventoryManager.consume_items(parent_item)
		Log.DEBUG("Collected: " + parent_item.display_name + " x" + str(am-remaining))
		Statistics.add_items_to_collected(parent_item.display_name, am-remaining)
		if remaining == 0:
			get_parent().queue_free()
			return
		
		parent_item.amount = remaining
