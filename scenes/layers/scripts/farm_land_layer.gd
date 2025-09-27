class_name FarmLandLayer
extends TileMapLayer

var none_source = -1
var field_source = 2

var tmp_cell_source: int

var local_cell_position: Vector2
var cell_position: Vector2i

func can_add_soil(player: Player) -> bool:
	return in_distance(player) && tmp_cell_source == none_source

func can_plant_seeds(player: Player) -> bool:
	return in_distance(player) && tmp_cell_source > 0

func can_remove_something(player: Player) -> bool:	
	return in_distance(player) && tmp_cell_source > 0

func in_distance(player: Player) -> bool:
	var mouse_position = get_local_mouse_position()
	cell_position = local_to_map(mouse_position)
	local_cell_position = map_to_local(cell_position)
	tmp_cell_source = get_cell_source_id(cell_position)
	var distance = player.global_position.distance_to(local_cell_position)
	return distance <= player.interaction_radius

func add_soil() -> void:
	var mouse_position = get_local_mouse_position()
	var cell_position = local_to_map(mouse_position)
	set_cells_terrain_connect([cell_position], 0, field_source, true)

func remove_soil() -> void:
	var mouse_position = get_local_mouse_position()
	var cell_position = local_to_map(mouse_position)
	set_cells_terrain_connect([cell_position], 0, none_source, true)

func get_local_cell_position() -> Vector2:
	var pos: Vector2 = map_to_local(cell_position)
	var half_size: Vector2 = Vector2(tile_set.tile_size) / 2.0
	var result = pos - Vector2(0, half_size.y)
	return result


func get_cell_position() -> Vector2i:
	return local_cell_position
