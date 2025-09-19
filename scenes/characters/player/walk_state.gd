extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var node_state_machine: NodeStateMachine
@export var speed: int = 50
@export var sprint_speed: int = 100


func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvents.movement_input()
	
	node_state_machine.play_animation("walk", direction, animated_sprite_2d)
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
	
	if Input.is_action_pressed("sprint"):
		player.velocity = direction * sprint_speed
	else:
		player.velocity = direction * speed
	
	
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvents.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
