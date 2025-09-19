extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var node_state_machine: NodeStateMachine

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite_2d.is_playing():
		transition.emit("Idle")


func _on_enter() -> void:
	var animation_played = node_state_machine.play_animation("tilling", player.player_direction, animated_sprite_2d)
	
	if !animation_played:
		animated_sprite_2d.play("tilling_front")


func _on_exit() -> void:
	animated_sprite_2d.stop()
