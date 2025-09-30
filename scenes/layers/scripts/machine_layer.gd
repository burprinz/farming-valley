class_name MachineLayer
extends TileMapLayer

func get_cell_pos() -> Vector2i:
	var mouse_position = get_local_mouse_position()
	var cell_position = local_to_map(mouse_position)
	return cell_position

func get_local_cell_pos() -> Vector2:
	var mouse_position = get_local_mouse_position()
	var cell_position = local_to_map(mouse_position)
	return map_to_local(cell_position)
