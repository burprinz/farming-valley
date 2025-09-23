class_name InventoryInfo
extends PanelContainer

@onready var cur_item_icon: TextureRect = $VBoxContainer/CurItem/CurItemIcon
@onready var cur_item_label: Label = $VBoxContainer/CurItem/CurItemLabel


func _ready() -> void:
	InventoryManager.selected_item_changed.connect(on_selected_item_changed)
	

func on_selected_item_changed():
	if InventoryManager.current_selected_item != null:
		cur_item_icon.texture = InventoryManager.current_selected_item._get_texture()
		cur_item_label.text = "x" + str(InventoryManager.current_selected_item.amount)
	else:
		cur_item_icon.texture = null
		cur_item_label.text = ""
