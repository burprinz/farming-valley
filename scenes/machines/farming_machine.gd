class_name FarmingMachine
extends InventoryMachine

func _prepare() -> void:
	DayAndNightCycleManager.four_o_clock.connect(try_to_plant_crops)
	DayAndNightCycleManager.eighteen_o_clock.connect(try_to_plant_crops)
	DayAndNightCycleManager.two_o_clock.connect(try_to_harvest_crops)
	DayAndNightCycleManager.six_o_clock.connect(water_crops)
	DayAndNightCycleManager.twenty_o_clock.connect(water_crops)
	super._prepare()

func water_crops() -> void:
	for x in range(int_top_left.x, int_bot_right.x):
		for y in range(int_top_left.y, int_bot_right.y):
			var b : bool = CropfieldManager.try_to_water_crop(Vector2i(x,y))

func try_to_harvest_crops() -> void:
	var crop_layer : CropLayer = get_tree().get_first_node_in_group("crop_layer")
	for x in range(int_top_left.x, int_bot_right.x):
		for y in range(int_top_left.y, int_bot_right.y):
			if x == cell_pos.x && y == cell_pos.y:
				continue
			var pos = Vector2i(x,y)
			var harvest : Array[Item] = CropfieldManager.try_to_harvest_crop(pos)
			if len(harvest) > 0:
				for h in harvest:
					machine_inventory.add_items(h)

func try_to_plant_crops() -> void:
	var grass_layer : GrassLayer = get_tree().get_first_node_in_group("grass_layer")
	var farmland_layer : FarmLandLayer = get_tree().get_first_node_in_group("farmland_layer")
	var crop_layer : CropLayer = get_tree().get_first_node_in_group("crop_layer")
	
	for x in range(int_top_left.x, int_bot_right.x):
		for y in range(int_top_left.y, int_bot_right.y):
			if x == cell_pos.x && y == cell_pos.y:
				continue
			var pos = Vector2i(x,y)
			if grass_layer.get_cell_source_id(pos) != -1:
				if farmland_layer.get_cell_source_id(pos) == -1:
					farmland_layer.add_soil_at_pos(pos)
				else:
					if CropfieldManager.is_field_free(pos):
						plant_crop(pos, crop_layer.get_local_cell_position(pos), crop_layer)
					
func plant_crop(cell_pos : Vector2i, global_pos : Vector2i, crop_layer: CropLayer) -> void:
	var seed : SeedItem = machine_inventory.get_one_seed()
	
	if seed != null:
		seed._plant_crop(cell_pos, global_pos, crop_layer)
