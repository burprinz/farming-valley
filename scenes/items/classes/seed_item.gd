class_name SeedItem
extends AreaToolItem

@export var crop_texture: Texture2D
@export var crop_aging_len: int

func _do_left_click(player: Player) -> void:
	var farmland_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	var crop_layer: CropLayer = player.get_tree().get_first_node_in_group("crop_layer")
	
	if farmland_layer.can_plant_seeds(player):
		var cell_pos = farmland_layer.get_cell_position()
		var global_pos = farmland_layer.get_local_cell_position()
		if crop_layer.is_field_free(cell_pos):
			_plant_crop(cell_pos, global_pos, crop_layer)


func _plant_crop(cell_pos : Vector2i, global_pos : Vector2i, crop_layer: CropLayer) -> void:
	pass
