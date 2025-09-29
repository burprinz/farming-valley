extends AreaToolItem


func _do_left_click(player: Player) -> void:
	var farmland_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	var crop_layer: CropLayer = player.get_tree().get_first_node_in_group("crop_layer")
	
	if farmland_layer.can_plant_seeds(player):
		var position: Vector2i = farmland_layer.get_cell_position()
		
		var crops = crop_layer.get_children()
		
		for crop in crops:
			crop = crop as Crop
			if crop.cell_position == position:
				crop.water_crop()
				Statistics.add_used_tool(DataTypes.ToolTypes.WateringCan, 1)
				break
