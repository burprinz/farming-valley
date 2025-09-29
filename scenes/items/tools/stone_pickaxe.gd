extends TargetToolItem

func _do_left_click(player: Player) -> void:
	player.get_hit_component_collision_shape().disabled = false
	set_base_collision_stats(player)
	player.get_hit_component_collision_shape().disabled = true
	Statistics.add_used_tool(DataTypes.ToolTypes.Pickaxe, 1)
