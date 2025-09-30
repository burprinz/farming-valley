extends TileMapLayer

var is_hidden: bool = true

func _ready() -> void:
	hide()
	InventoryManager.hotbar_slot_changed.connect(on_hotbar_slot_changed)

func on_hotbar_slot_changed() -> void:
	if !is_hidden:
		is_hidden = true
	if InventoryManager.is_selected_item_tool():
		var item = InventoryManager.get_selected_slot()
		if item is MachineItem:
			is_hidden = !is_hidden
	if is_hidden:
		hide()
	else:
		show()
			
