extends SeedItem

var crop = preload("res://scenes/grow/crops/corn_crop.tscn")

func _plant_crop(cell_pos : Vector2i, global_pos : Vector2i, crop_layer: CropLayer) -> void:
	var ins : Crop = crop.instantiate()
	ins.cell_pos = cell_pos
	ins.global_position = global_pos + Vector2i(0,5)
	CropfieldManager.add_crop(ins)
	crop_layer.add_child(ins)
	Log.DEBUG("Planted Corn at " + str(cell_pos))
