class_name StoneHoe
extends AreaToolItem

func _do_left_click(player: Player) -> void:
	var crop_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	if crop_layer.can_add_soil(player):
		crop_layer.add_soil()
		Statistics.add_used_tool(DataTypes.ToolTypes.Hoe, 1)

func _do_advanced_left_click(player: Player) -> void:
	pass
	var crop_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	if crop_layer.can_remove_something(player):
		crop_layer.remove_soil()
		Statistics.add_used_tool(DataTypes.ToolTypes.Hoe, 1)
