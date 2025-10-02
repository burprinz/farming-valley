extends Sprite2D

@export var action : Node2D

var mouse_on_sign: bool = false

func _input(event: InputEvent) -> void:
	if mouse_on_sign && Input.is_action_just_pressed("hit"):
		action._interact()
		

func _on_area_2d_mouse_entered() -> void:
	mouse_on_sign = true

func _on_area_2d_mouse_exited() -> void:
	mouse_on_sign = false
