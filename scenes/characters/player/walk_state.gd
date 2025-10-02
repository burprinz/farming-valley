extends NodeState

@export var player: Player
@export var animated_sprite_2d: AnimatedSprite2D
@export var node_state_machine: NodeStateMachine
@export var speed: int = 50
@export var sprint_speed: int = 100
@export var dash_speed: int = 700
@export var dash_vanish: int = 80

var current_dash_speed: int = 0
var can_use_dash: bool = true

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	var direction: Vector2 = GameInputEvent.movement_input()
	
	node_state_machine.play_animation("walk", direction, animated_sprite_2d)
	
	if direction != Vector2.ZERO:
		player.player_direction = direction
		
	var cur_speed: int = 0
	
	if can_use_dash:
		if Input.is_action_just_pressed("dash"):
			current_dash_speed = dash_speed
			cur_speed = dash_speed
			can_use_dash = false
		elif Input.is_action_pressed("sprint"):
			cur_speed = sprint_speed
		else:
			cur_speed = speed
	else:
		current_dash_speed -= dash_vanish
		cur_speed = current_dash_speed
		if current_dash_speed <= sprint_speed:
			can_use_dash = true
	
	player.velocity = direction * cur_speed
		
	
	player.move_and_slide()

func _on_next_transitions() -> void:
	if !GameInputEvent.is_movement_input():
		transition.emit("Idle")


func _on_enter() -> void:
	pass


func _on_exit() -> void:
	animated_sprite_2d.stop()
