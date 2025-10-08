extends SeedItem

var crop = preload("res://scenes/grow/crops/corn_crop.tscn")

func _plant_crop(cell_pos : Vector2i, global_pos : Vector2i, crop_layer: CropLayer) -> void:
	Log.DEBUG("Trying to plant Corn at " + str(cell_pos))
	var ins : Crop = crop.instantiate()
	ins.cell_pos = cell_pos
	ins.global_position = global_pos + Vector2i(0,5)
	CropfieldManager.add_crop(ins)
	crop_layer.add_child(ins)
	#crop_layer.set_cell(pos, 0, Vector2i(0,0), 1)
