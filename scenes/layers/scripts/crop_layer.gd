class_name CropLayer
extends TileMapLayer

func is_field_free(pos : Vector2i) -> bool:
	return get_cell_source_id(pos) == -1
