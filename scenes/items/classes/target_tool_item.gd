class_name TargetToolItem
extends ToolItem


func set_base_collision_stats(player: Player) -> void:
	if player.player_direction == Vector2.UP:
		player.get_hit_component_collision_shape().position = Vector2(0, -18)
	elif player.player_direction == Vector2.RIGHT:
		player.get_hit_component_collision_shape().position = Vector2(9, 0)
	elif player.player_direction == Vector2.LEFT:
		player.get_hit_component_collision_shape().position = Vector2(-9, 0)
	elif player.player_direction == Vector2.DOWN:
		player.get_hit_component_collision_shape().position = Vector2(0, 3)
	else:
		player.get_hit_component_collision_shape().position = Vector2(0, 3)
