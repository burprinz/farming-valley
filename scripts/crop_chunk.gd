class_name CropChunk
extends Node

var chunk_pos : Vector2i
var crops : Array[Crop]

func try_to_water_crop(cell_pos : Vector2i) -> bool:
	for i in range(len(crops)):
		if crops[i].cell_pos == cell_pos:
			crops[i].water_crop()
			return true
	return false

func add_crop(crop : Crop) -> void:
	crops.append(crop)

func remove_crop_by_id(id : int) -> void:
	for i in range(len(crops)):
		if crops[i].id == id:
			crops.remove_at(i)
			break
			
func remove_crop(cell_pos : Vector2i) -> void:
	for i in range(len(crops)):
		if crops[i].cell_pos == cell_pos:
			crops.remove_at(i)
			break

func get_crop(id : int) -> Crop:
	for i in range(len(crops)):
		if crops[i].id == id:
			return crops[i]
	return null

func is_crop_at_pos(pos : Vector2i) -> bool:
	for i in range(len(crops)):
		if crops[i].cell_pos == pos:
			return true
	return false

func has_crops() -> bool:
	return len(crops) > 0
