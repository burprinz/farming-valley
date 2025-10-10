class_name InventoryMachine
extends Machine

@export var machine_name : String
@export var machine_inventory : MachineInventory

var mouse_in : bool = false

func _prepare() -> void:
	machine_inventory.set_inv_size(Vector2i(3,3))
	
func _input(event: InputEvent) -> void:
	if mouse_in && GameManager.current_game_state == GameManager.GameStates.ingame && Input.is_action_just_pressed("hit"):
		machine_inventory.show_inv(0)


func _on_mouse_entered() -> void:
	mouse_in = true


func _on_mouse_exited() -> void:
	mouse_in = false
