extends Sprite2D

@onready var interactable_component: InteractableComponent = $InteractableComponent


func _ready() -> void:
	interactable_component.interactable_activated.connect(on_interactable_activated)

func on_interactable_activated():
	material.set_shader_parameter("shake_intensity", 0.5)
	await  get_tree().create_timer(2.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	
