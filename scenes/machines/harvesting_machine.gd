class_name HarvestingMachine
extends InventoryMachine

func _prepare() -> void:
	DayAndNightCycleManager.two_o_clock.connect(try_to_harvest_crops)
	super._prepare()

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
