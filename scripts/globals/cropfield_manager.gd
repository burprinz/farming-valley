extends Node

var planted_crops: Array[Vector2i]


func is_field_free(positon: Vector2i) -> bool:
	for c in planted_crops:
		#print(positon, planted_crops)
		if positon == c:
			return false
	return true

func add_crop(crop: Vector2i) -> void:
	planted_crops.append(crop)

func remove_crop(crop: Vector2i) -> void:
	for i in range(len(planted_crops)):
		if planted_crops[i].x == crop.x && planted_crops[i].y == crop.y:
			planted_crops.remove_at(i)
			break
