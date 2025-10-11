class_name StoneHoe
extends AreaToolItem

func _do_left_click(player: Player) -> void:
	var crop_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	var cell_pos = crop_layer.get_cell_position()
	
	if !CropfieldManager.is_field_free(cell_pos):
		var dropped_items_layer : Node = player.get_tree().get_first_node_in_group("item_drop_layer")
		var items : Array[Item] = CropfieldManager.try_to_harvest_crop(cell_pos)
		
		if len(items) > 0:
			for item in items:
				item.global_position = crop_layer.map_to_local(cell_pos)
				dropped_items_layer.add_child(item)
		
	elif crop_layer.can_add_soil(player):
		crop_layer.add_soil()
		Statistics.add_used_tool(DataTypes.ToolTypes.Hoe, 1)

func _do_advanced_left_click(player: Player) -> void:
	pass
	var crop_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	if crop_layer.can_remove_something(player):
		crop_layer.remove_soil()
		Statistics.add_used_tool(DataTypes.ToolTypes.Hoe, 1)
