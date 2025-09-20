class_name SeedItem
extends AreaToolItem

@export var crop_scene: PackedScene

func _do_left_click(player: Player) -> void:
	pass
#	var crop_field_layer: CropLayer = player.get_tree().get_first_node_in_group("crop_field_layer")
#	var crop_layer: Node = player.get_tree().get_first_node_in_group("crop_layer")
#	if crop_field_layer.can_plant_seeds(player):
#		var cell_pos = crop_field_layer.get_cell_position()
#		#print(CropfieldManager.is_field_free(cell_pos))
#		if CropfieldManager.is_field_free(cell_pos):
#			var instance = crop_scene.duplicate().instantiate() as CropState
#			instance.global_position = crop_field_layer.get_local_cell_position()
#			instance.cell_position = cell_pos
#			crop_layer.add_child(instance)
#			CropfieldManager.add_crop(cell_pos)
