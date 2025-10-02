extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var node_state_machine: NodeStateMachine

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var animation_played = node_state_machine.play_animation("idle", player.player_direction, animated_sprite_2d)
	
	if !animation_played:
		animated_sprite_2d.play("idle_front")

func _on_next_transitions() -> void:
	GameInputEvent.movement_input()
	
	if GameInputEvent.is_movement_input():
		transition.emit("Walk")
	
	
	if InventoryManager.is_selected_item_tool() && GameInputEvent.use_tool():
		var tool_type : DataTypes.ToolTypes = InventoryManager.get_selected_tool_type()
		if tool_type == DataTypes.ToolTypes.Axe:
			transition.emit("Chopping")
		elif tool_type == DataTypes.ToolTypes.Hoe:
			transition.emit("Tilling")
		elif tool_type == DataTypes.ToolTypes.WateringCan:
			transition.emit("Watering")
		elif tool_type == DataTypes.ToolTypes.Pickaxe:
			transition.emit("Picking")

func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
