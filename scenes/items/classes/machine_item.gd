class_name MachineItem
extends AreaToolItem

@export var machine : PackedScene

func _do_left_click(player: Player) -> void:
	var farmland_layer: FarmLandLayer = player.get_tree().get_first_node_in_group("farmland_layer")
	var machine_layer: MachineLayer = player.get_tree().get_first_node_in_group("machine_layer")
	
	var ins: Machine = machine.instantiate()
	ins.global_position = machine_layer.get_local_cell_pos()
	machine_layer.add_child(ins)
	InventoryManager.remove_items_from_current_hotbar_slot(1)
