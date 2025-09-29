extends PanelContainer

@export var pause_screen: PauseScreen

@onready var collected_items: Label = $VBoxContainer/MarginContainer/HBoxContainer/CollectedItems
@onready var used_tools: Label = $VBoxContainer/MarginContainer/HBoxContainer/UsedTools
@onready var destroyed_objects: Label = $VBoxContainer/MarginContainer/HBoxContainer/DestroyedObjects
@onready var harvested_crops: Label = $VBoxContainer/MarginContainer/HBoxContainer/HarvestedCrops

	
func refresh() -> void:
	collected_items.text = Statistics.get_collected_items_string()
	used_tools.text = Statistics.get_used_tools_string()
	destroyed_objects.text = Statistics.get_destroyed_objects_string()
	harvested_crops.text = Statistics.get_harvested_crops_string()

func _on_back_button_pressed() -> void:
	pause_screen.to_main()
