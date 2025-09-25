extends SeedItem

var crop_scene = preload("res://scenes/grow/crops/crop.tscn")
var resulting_item = preload("res://scenes/items/materials/corn.tscn")

func _get_crop_scene() -> Crop:
	var inst = crop_scene.instantiate() as Crop
	var inst2 = resulting_item.instantiate() as Item
	inst2.amount = 2
	inst.call_deferred("set_properties", crop_texture, crop_aging_len, inst2)
	return inst
