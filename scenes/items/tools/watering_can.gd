extends AreaToolItem


func _do_left_click(player: Player) -> void:
	var farmland_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	var crop_layer: CropLayer = player.get_tree().get_first_node_in_group("crop_layer")
	
	if farmland_layer.can_plant_seeds(player):
		var cell_position: Vector2i = farmland_layer.get_cell_position()
		
		CropfieldManager.try_to_water_crop(cell_position)
