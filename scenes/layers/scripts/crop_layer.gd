class_name CropLayer
extends TileMapLayer

func get_local_cell_position(_pos : Vector2i) -> Vector2:
	var pos: Vector2 = map_to_local(_pos)
	var half_size: Vector2 = Vector2(tile_set.tile_size) / 2.0
	var result = pos - Vector2(0, half_size.y)
	return result
