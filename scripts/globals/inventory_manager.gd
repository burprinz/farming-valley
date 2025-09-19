extends Node

const hotbar_length: int = 9

var none_item = preload("res://scenes/items/classes/none_item.tscn")

var hotbar: Array[Item]
var hotbar_infos: Array[ItemSlotInformation]
var hotbar_created: bool = false
var selected_hotbar_slot: int = -1

signal hotbar_changed

# ALLGEMEIN

# Returnt was nicht ins inv gepasst hat
func add_item_to_inventory(item: Item) -> int:
	var name: String = item.display_name
	var amount: int = item.amount
	var stackable: bool = item.stackable
	
	amount = add_as_many_items_to_hotbar(item, name, amount, stackable)
	item.amount = amount
	
	return amount

# HOTBAR
func get_hotbar_infos() -> Array[ItemSlotInformation]:
	return hotbar_infos

func create_hotbar() -> void:
	var none: Item = none_item.instantiate()
	for i in range(hotbar_length):
		var slotinfo := ItemSlotInformation.new()
		slotinfo.name = "none"
		
		hotbar.append(none)
		hotbar_infos.append(slotinfo)
	hotbar_created = true

func add_item_to_hotbar(item: Item, pos: int) -> bool:
	if !hotbar_created:
		create_hotbar()
	
	if pos < 0 && pos >= hotbar_length:
		return false
	
	hotbar[pos] = item
	
	var newInfo := ItemSlotInformation.new()
	newInfo.image = item._get_texture()
	newInfo.amount = item.amount
	newInfo.name = item.display_name
	newInfo.stackable = item.stackable
	
	if item is ToolItem:
		newInfo.tool_type = item.tool
	
	hotbar[pos] = item.duplicate()
	hotbar_infos[pos] = newInfo
	hotbar_changed.emit()
	return true

func change_selected_slot(new_slot: int) -> void:
	print("Change to " , new_slot)
	selected_hotbar_slot = new_slot

func is_selected_item_tool() -> bool:
	if !hotbar_created:
		create_hotbar()
	return selected_hotbar_slot >= 0 && selected_hotbar_slot < hotbar_length && hotbar_infos[selected_hotbar_slot].tool_type != DataTypes.ToolTypes.None

func add_as_many_items_to_hotbar(item: Item, name: String, amount: int, stackable: bool) -> int:
	if !hotbar_created:
		create_hotbar()
	
	for i in range(hotbar_length):
		# freier platz -> alles passt rein
		if hotbar_infos[i].name == "none":
			item.amount = amount
			add_item_to_hotbar(item, i)
			return 0
		
		# kein freier platz, aber gleiches item
		if stackable && hotbar_infos[i].name == name:
			var new_amount: int = hotbar_infos[i].amount + amount
			if new_amount > Constants.MAX_ITEM_STACK_SIZE:
				amount = new_amount - Constants.MAX_ITEM_STACK_SIZE
				new_amount = Constants.MAX_ITEM_STACK_SIZE
			else:
				amount = 0
				
			hotbar[i].amount = new_amount
			hotbar_infos[i].amount = new_amount
			hotbar_changed.emit()
			
		if amount == 0:
			return 0
	
	return amount

func get_selected_tool_type() -> DataTypes.ToolTypes:
	return hotbar_infos[selected_hotbar_slot].tool_type


# CLICKING
func perform_left_click(player: Player) -> void:
	if selected_hotbar_slot < 0 || selected_hotbar_slot >= hotbar_length:
		return
		
	if hotbar[selected_hotbar_slot] is ToolItem:
		hotbar[selected_hotbar_slot]._do_left_click(player)

func perform_advanced_left_click(player: Player) -> void:
	if selected_hotbar_slot < 0 || selected_hotbar_slot >= hotbar_length:
		return
		
	if hotbar[selected_hotbar_slot] is ToolItem:
		hotbar[selected_hotbar_slot]._do_advanced_left_click(player)
	
