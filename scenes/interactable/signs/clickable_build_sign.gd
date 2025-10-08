class_name ClickableBuildSign
extends ClickableSign

@onready var hover_item_list: PanelContainer = $HoverItemList

@export var item_cost : Array[PackedScene]
@export var amount_item_cost : Array[int]
var item_names : Array[String]

func _ready() -> void:
	super._ready()
	
	var textures : Array[Texture2D]
	
	for i in range(len(item_cost)):
		var item = item_cost[i].instantiate() as Item
		textures.append(item._get_texture())
		item_names.append(item.name)
	
	hover_item_list.create_panel(textures, amount_item_cost)
	

func _input(event: InputEvent) -> void:
	if mouse_on_sign && Input.is_action_just_pressed("hit"):
		if InventoryManager.has_enough_items(item_names, amount_item_cost.duplicate()):
			InventoryManager.remove_items(item_names, amount_item_cost.duplicate())
			action._interact()

func remove_items() -> void:
	#InventoryManager.remove_items(item_names, am)
	pass

func _entered() -> void:
	var am : Array[int] = amount_item_cost.duplicate()
	InventoryManager.has_enough_items(item_names, am)
	hover_item_list.update_colors(am)
	hover_item_list.show()

func _exited() -> void:
	hover_item_list.hide()
