extends Node

func drop_items_on_pos(item_scene, amount: int, pos: Vector2) -> void:
	var layer  = get_tree().get_first_node_in_group("item_drop_layer") as Node
	
	var item = item_scene.instantiate() as Item
	item.amount = amount
	item.global_position = pos
	
	layer.add_child(item)
