class_name SeedItem
extends AreaToolItem

@export var crop_texture: Texture2D
@export var crop_aging_len: int

func _do_left_click(player: Player) -> void:
	var farmland_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	var crop_layer: CropLayer = player.get_tree().get_first_node_in_group("crop_layer")
	
	if farmland_layer.can_plant_seeds(player):
		var cell_pos = farmland_layer.get_cell_position()
		if CropfieldManager.is_field_free(cell_pos):
			var ins: Crop = _get_crop_scene()
			ins.global_position = farmland_layer.get_local_cell_position() + Vector2(0,3)
			ins.cell_position = cell_pos
			crop_layer.add_child(ins)
			CropfieldManager.add_crop(cell_pos)
			InventoryManager.remove_items_from_current_hotbar_slot(1)

func _get_crop_scene() -> Crop:
	return null
