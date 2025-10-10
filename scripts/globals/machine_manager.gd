extends Node


var current_open_machine_inventory : MachineInventory



func set_machine_inv(inv : MachineInventory) -> void:
	current_open_machine_inventory = inv

func remove_machine_inv() -> void:
	current_open_machine_inventory = null
	
func get_machine_inv() -> MachineInventory:
	return current_open_machine_inventory
