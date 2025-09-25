extends Node

var planted_crops: Array[Vector2i]


func is_field_free(positon: Vector2i) -> bool:
	for c in planted_crops:
		#print(positon, planted_crops)
		if positon == c:
			return false
	return true

func add_crop(crop: Vector2i):
	planted_crops.append(crop)
