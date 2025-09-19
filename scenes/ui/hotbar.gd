extends PanelContainer

@onready var hotbar_01: Button = $MarginContainer/HBoxContainer/Hotbar01
@onready var hotbar_icon_01: TextureRect = $MarginContainer/HBoxContainer/Hotbar01/HotbarIcon01
@onready var hotbar_label_01: Label = $MarginContainer/HBoxContainer/Hotbar01/HotbarLabel01
@onready var hotbar_02: Button = $MarginContainer/HBoxContainer/Hotbar02
@onready var hotbar_icon_02: TextureRect = $MarginContainer/HBoxContainer/Hotbar02/HotbarIcon02
@onready var hotbar_label_02: Label = $MarginContainer/HBoxContainer/Hotbar02/HotbarLabel02
@onready var hotbar_03: Button = $MarginContainer/HBoxContainer/Hotbar03
@onready var hotbar_icon_03: TextureRect = $MarginContainer/HBoxContainer/Hotbar03/HotbarIcon03
@onready var hotbar_label_03: Label = $MarginContainer/HBoxContainer/Hotbar03/HotbarLabel03
@onready var hotbar_04: Button = $MarginContainer/HBoxContainer/Hotbar04
@onready var hotbar_icon_04: TextureRect = $MarginContainer/HBoxContainer/Hotbar04/HotbarIcon04
@onready var hotbar_label_04: Label = $MarginContainer/HBoxContainer/Hotbar04/HotbarLabel04
@onready var hotbar_05: Button = $MarginContainer/HBoxContainer/Hotbar05
@onready var hotbar_icon_05: TextureRect = $MarginContainer/HBoxContainer/Hotbar05/HotbarIcon05
@onready var hotbar_label_05: Label = $MarginContainer/HBoxContainer/Hotbar05/HotbarLabel05
@onready var hotbar_06: Button = $MarginContainer/HBoxContainer/Hotbar06
@onready var hotbar_icon_06: TextureRect = $MarginContainer/HBoxContainer/Hotbar06/HotbarIcon06
@onready var hotbar_label_06: Label = $MarginContainer/HBoxContainer/Hotbar06/HotbarLabel06
@onready var hotbar_07: Button = $MarginContainer/HBoxContainer/Hotbar07
@onready var hotbar_icon_07: TextureRect = $MarginContainer/HBoxContainer/Hotbar07/HotbarIcon07
@onready var hotbar_label_07: Label = $MarginContainer/HBoxContainer/Hotbar07/HotbarLabel07
@onready var hotbar_08: Button = $MarginContainer/HBoxContainer/Hotbar08
@onready var hotbar_icon_08: TextureRect = $MarginContainer/HBoxContainer/Hotbar08/HotbarIcon08
@onready var hotbar_label_08: Label = $MarginContainer/HBoxContainer/Hotbar08/HotbarLabel08
@onready var hotbar_09: Button = $MarginContainer/HBoxContainer/Hotbar09
@onready var hotbar_icon_09: TextureRect = $MarginContainer/HBoxContainer/Hotbar09/HotbarIcon09
@onready var hotbar_label_09: Label = $MarginContainer/HBoxContainer/Hotbar09/HotbarLabel09



var hotbar_cells: Array[Button]
var hotbar_icons: Array[TextureRect]
var hotbar_labels: Array[Label]

func _ready() -> void:
	
	
	hotbar_cells.append(hotbar_01)
	hotbar_cells.append(hotbar_02)
	hotbar_cells.append(hotbar_03)
	hotbar_cells.append(hotbar_04)
	hotbar_cells.append(hotbar_05)
	hotbar_cells.append(hotbar_06)
	hotbar_cells.append(hotbar_07)
	hotbar_cells.append(hotbar_08)
	hotbar_cells.append(hotbar_09)
	
	hotbar_icons.append(hotbar_icon_01)
	hotbar_icons.append(hotbar_icon_02)
	hotbar_icons.append(hotbar_icon_03)
	hotbar_icons.append(hotbar_icon_04)
	hotbar_icons.append(hotbar_icon_05)
	hotbar_icons.append(hotbar_icon_06)
	hotbar_icons.append(hotbar_icon_07)
	hotbar_icons.append(hotbar_icon_08)
	hotbar_icons.append(hotbar_icon_09)
	
	hotbar_labels.append(hotbar_label_01)
	hotbar_labels.append(hotbar_label_02)
	hotbar_labels.append(hotbar_label_03)
	hotbar_labels.append(hotbar_label_04)
	hotbar_labels.append(hotbar_label_05)
	hotbar_labels.append(hotbar_label_06)
	hotbar_labels.append(hotbar_label_07)
	hotbar_labels.append(hotbar_label_08)
	hotbar_labels.append(hotbar_label_09)
	
	InventoryManager.hotbar_changed.connect(on_hotbar_changed)
	

func on_hotbar_changed() -> void:
	var infos: Array[ItemSlotInformation] = InventoryManager.get_hotbar_infos()
	
	for i in range(InventoryManager.hotbar_length):
				
		if infos[i].name != "none":
			hotbar_icons[i].texture = infos[i].image
			if infos[i].stackable:
				hotbar_labels[i].text = "x" + str(infos[i].amount)
			else:
				hotbar_labels[i].text = ""
		else:
			hotbar_icons[i].texture = null
			hotbar_labels[i].text = ""

func _on_hotbar_01_pressed() -> void:
	InventoryManager.change_selected_slot(0)

func _on_hotbar_02_pressed() -> void:
	InventoryManager.change_selected_slot(1)

func _on_hotbar_03_pressed() -> void:
	InventoryManager.change_selected_slot(2)

func _on_hotbar_04_pressed() -> void:
	InventoryManager.change_selected_slot(3)

func _on_hotbar_05_pressed() -> void:
	InventoryManager.change_selected_slot(4)

func _on_hotbar_06_pressed() -> void:
	InventoryManager.change_selected_slot(5)

func _on_hotbar_07_pressed() -> void:
		InventoryManager.change_selected_slot(6)

func _on_hotbar_08_pressed() -> void:
	InventoryManager.change_selected_slot(7)

func _on_hotbar_09_pressed() -> void:
	InventoryManager.change_selected_slot(8)
