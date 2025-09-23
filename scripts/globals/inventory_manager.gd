extends Node

const hotbar_length: int = 9

var none_item = preload("res://scenes/items/classes/none_item.tscn")

var hotbar: Array[Item]
var hotbar_infos: Array[ItemSlotInformation]
var hotbar_created: bool = false
var selected_hotbar_slot: int = -1

var inventory: Array[Array]
var inventory_infos: Array[Array]
var inventory_created: bool = false

enum INV_MOV_STATES {
	NOTHING_SELECTED,
	ITEM_SELECTED
}
var current_inv_mov_state: INV_MOV_STATES = INV_MOV_STATES.NOTHING_SELECTED

#var current_selected_item_info: ItemSlotInformation
var current_selected_item: Item

signal hotbar_changed
signal inventory_changed
signal selected_item_changed

# ALLGEMEIN

# Returnt was nicht ins inv gepasst hat
func consume_items(item: Item) -> int:
	var name: String = item.display_name
	var amount: int = item.amount
	var stackable: bool = item.stackable
	
	amount = add_as_many_items_to_hotbar(item, name, amount, stackable)
	item.amount = amount
	
	if amount == 0:
		return 0
		
	amount = add_as_many_items_to_inventory(item, name, amount, stackable)
		
	return amount


# HOTBAR
func create_hotbar() -> void:
	var none: Item = none_item.instantiate()
	for i in range(hotbar_length):
		var slotinfo := ItemSlotInformation.new()
		slotinfo.name = "none"
		
		hotbar.append(none)
		hotbar_infos.append(slotinfo)
	hotbar_created = true

func get_hotbar_infos() -> Array[ItemSlotInformation]:
	return hotbar_infos

func add_item_to_hotbar(item: Item, pos: int) -> bool:
	if !hotbar_created:
		create_hotbar()
	
	if pos < 0 && pos >= hotbar_length:
		return false
	
	hotbar[pos] = item
	
	create_hotbar_infos(pos)
	
	hotbar[pos] = item.duplicate()
	hotbar_changed.emit()
	return true

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

func create_hotbar_infos(pos: int) -> void:
	var newInfo := ItemSlotInformation.new()
	newInfo.image = hotbar[pos]._get_texture()
	newInfo.amount = hotbar[pos].amount
	newInfo.name = hotbar[pos].display_name
	newInfo.stackable = hotbar[pos].stackable
	
	if hotbar[pos] is ToolItem:
		newInfo.tool_type = hotbar[pos].tool
	
	hotbar_infos[pos] = newInfo

func is_selected_item_tool() -> bool:
	if !hotbar_created:
		create_hotbar()
	return selected_hotbar_slot >= 0 && selected_hotbar_slot < hotbar_length && hotbar_infos[selected_hotbar_slot].tool_type != DataTypes.ToolTypes.None

func get_selected_tool_type() -> DataTypes.ToolTypes:
	return hotbar_infos[selected_hotbar_slot].tool_type

func change_selected_hotbar_slot(new_slot: int) -> void:
	if GameManager.current_game_state == GameManager.GameStates.ingame:
		Log.DEBUG("Hotbarslot " + str(new_slot) + " selected")
		selected_hotbar_slot = new_slot
	elif GameManager.current_game_state == GameManager.GameStates.inventory:
		item_from_hotbar_clicked(new_slot)


# INVENTORY

func create_inventory() -> void:
	var none: Item = none_item.instantiate()
	for y in range(3):
		var tmp: Array[Item]
		var tmp2: Array[ItemSlotInformation]
		for x in range(9):
			var slotinfo := ItemSlotInformation.new()
			slotinfo.name = "none"
			tmp.append(none)
			tmp2.append(slotinfo)
		inventory.append(tmp)
		inventory_infos.append(tmp2)
	inventory_created = true

func get_inventory_infos() -> Array[Array]:
	return inventory_infos

func create_inventory_infos(pos: Vector2i) -> void:
	var newInfo := ItemSlotInformation.new()
	newInfo.image = inventory[pos.y][pos.x]._get_texture()
	newInfo.amount = inventory[pos.y][pos.x].amount
	newInfo.name = inventory[pos.y][pos.x].display_name
	newInfo.stackable = inventory[pos.y][pos.x].stackable
	
	if inventory[pos.y][pos.x] is ToolItem:
		newInfo.tool_type = inventory[pos.y][pos.x].tool
	
	inventory_infos[pos.y][pos.x] = newInfo

func change_selected_inventory_slot(pos: Vector2i) -> void:
	if GameManager.current_game_state == GameManager.GameStates.inventory:
		item_from_inventory_clicked(pos)

func add_item_to_inventory(item: Item, pos: Vector2i) -> bool:
	if !inventory_created:
		create_inventory()
	
	if pos.x < 0 || pos.y < 0 || pos.x >= hotbar_length || pos.y >= 3:
		return false
		
	
	inventory[pos.y][pos.x] = item.duplicate()
	create_inventory_infos(pos)
	inventory_changed.emit()
	return true

func add_as_many_items_to_inventory(item: Item, name: String, amount: int, stackable: bool) -> int:
	if !inventory_created:
		create_inventory()
	
	for y in range(3):
		var row: Array[ItemSlotInformation] = inventory_infos[y]
		for x in range(len(row)):
			if inventory_infos[y][x].name == "none":
				item.amount = amount
				add_item_to_inventory(item, Vector2i(x,y))
				return 0
			if stackable && inventory_infos[y][x].name == name:
				var new_amount: int = inventory_infos[y][x].amount + amount
				if new_amount > Constants.MAX_ITEM_STACK_SIZE:
					amount = new_amount - Constants.MAX_ITEM_STACK_SIZE
					new_amount = Constants.MAX_ITEM_STACK_SIZE
				else:
					amount = 0
					
				inventory[y][x].amount = new_amount
				inventory_infos[y][x].amount = new_amount
				inventory_changed.emit()
			
			if amount == 0:
				return 0
	
	return amount

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

func item_from_inventory_clicked(pos: Vector2i) -> void:
	if !inventory_created:
		create_inventory()
	
	if pos.x < 0 || pos.x >= hotbar_length || pos.y < 0 || pos.y >= 3:
		return
	
	if current_inv_mov_state == INV_MOV_STATES.NOTHING_SELECTED:
		if inventory[pos.y][pos.x]._get_type() == "none":
			return
		if Input.is_key_pressed(KEY_SHIFT):
			var full_am: int = inventory[pos.y][pos.x].amount
			var half_am: int = int(full_am/2)
			if half_am == 0 || !inventory[pos.y][pos.x].stackable:
				half_am = 1
			add_new_selected_item_from_inventory_slot(pos, half_am)
		elif Input.is_key_pressed(KEY_ALT):
			add_new_selected_item_from_inventory_slot(pos, 1)
		else:
			add_new_selected_item_from_inventory_slot(pos, inventory[pos.y][pos.x].amount)
		
	elif current_inv_mov_state == INV_MOV_STATES.ITEM_SELECTED:
		if Input.is_key_pressed(KEY_SHIFT):
			# Haelfte
			var full_am: int = current_selected_item.amount
			var half_am: int = int(full_am/2)
			if !current_selected_item.stackable || half_am == 0:
				half_am = 1
				
			add_selected_items_to_inventory_slot(pos, half_am)
		elif Input.is_key_pressed(KEY_ALT):
			# Eins
			add_selected_items_to_inventory_slot(pos, 1)
		elif Input.is_key_pressed(KEY_CTRL):
			# Weiter aufsammeln
			add_inventory_slot_to_selected_slot(pos)
		else:
			# Alles
			add_selected_items_to_inventory_slot(pos, current_selected_item.amount)

func item_from_hotbar_clicked(pos: int) -> void:
	if pos < 0 || pos >= hotbar_length:
		return
	
	if current_inv_mov_state == INV_MOV_STATES.NOTHING_SELECTED:
		if hotbar[pos]._get_type() == "none":
			return
			
		if Input.is_key_pressed(KEY_SHIFT):
			var full_am: int = hotbar[pos].amount
			var half_am: int = int(full_am/2)
			if half_am == 0 || !hotbar[pos].stackable:
				half_am = 1
			add_new_selected_item_from_hotbar_slot(pos, half_am)
		elif Input.is_key_pressed(KEY_ALT):
			add_new_selected_item_from_hotbar_slot(pos, 1)
		else:
			add_new_selected_item_from_hotbar_slot(pos, hotbar[pos].amount)
					

	elif current_inv_mov_state == INV_MOV_STATES.ITEM_SELECTED:
		if Input.is_key_pressed(KEY_SHIFT):
			# Haelfte
			var full_am: int = current_selected_item.amount
			var half_am: int = int(full_am/2)
			if !current_selected_item.stackable || half_am == 0:
				half_am = 1
				
			add_selected_items_to_hotbar_slot(pos, half_am)
		elif Input.is_key_pressed(KEY_ALT):
			# Eins
			add_selected_items_to_hotbar_slot(pos, 1)
		elif Input.is_key_pressed(KEY_CTRL):
			# Weiter aufsammeln
			add_hotbar_slot_to_selected_item(pos)
		else:
			# Alles
			add_selected_items_to_hotbar_slot(pos, current_selected_item.amount)

func add_selected_items_to_hotbar_slot(pos: int, amount: int) -> void:
	if hotbar_infos[pos].name == "none":
		hotbar[pos] = current_selected_item.duplicate()
		hotbar[pos].amount = amount
		create_hotbar_infos(pos)
		current_selected_item.amount -= amount
		if current_selected_item.amount <= 0:
			current_selected_item = null
			current_inv_mov_state = INV_MOV_STATES.NOTHING_SELECTED
		
		selected_item_changed.emit()
		hotbar_changed.emit()
		Log.DEBUG("Dropping x"+ str(amount) + " '"+ hotbar[pos].display_name + "' to hotbar pos " + str(pos))
	elif hotbar_infos[pos].stackable && hotbar_infos[pos].name == current_selected_item.display_name:
		var hotbar_amount: int = hotbar_infos[pos].amount
		
		var remaining_amount: int = 0
		var remove_amount: int = amount
		var new_hotbar_amount: int = hotbar_amount + amount
		if new_hotbar_amount > Constants.MAX_ITEM_STACK_SIZE:
			remaining_amount = new_hotbar_amount-Constants.MAX_ITEM_STACK_SIZE
			remove_amount -= remaining_amount
			new_hotbar_amount = Constants.MAX_ITEM_STACK_SIZE
			
		hotbar[pos].amount = new_hotbar_amount
		hotbar_infos[pos].amount = new_hotbar_amount
		current_selected_item.amount -= remove_amount
		if current_selected_item.amount <= 0:
			current_selected_item = null
			current_inv_mov_state = INV_MOV_STATES.NOTHING_SELECTED
		
		selected_item_changed.emit()
		hotbar_changed.emit()
		Log.DEBUG("Adding x"+ str(amount) + " '"+ hotbar[pos].display_name + "' to hotbar pos " + str(pos))

func add_hotbar_slot_to_selected_item(pos: int) -> void:
	if hotbar_infos[pos].name == "none":
		add_selected_items_to_hotbar_slot(pos, current_selected_item.amount)
		return
	
	var slot_amount = hotbar[pos].amount
	var selected_amount = current_selected_item.amount
	
	var new_amount = selected_amount + slot_amount
	var remaining_amount = 0
	var delete_amont = slot_amount
	if new_amount > Constants.MAX_ITEM_STACK_SIZE:
		remaining_amount = new_amount-Constants.MAX_ITEM_STACK_SIZE
		delete_amont -= remaining_amount
		new_amount = Constants.MAX_ITEM_STACK_SIZE


	hotbar[pos].amount -= delete_amont
	hotbar_infos[pos].amount -= delete_amont
	current_selected_item.amount = new_amount
	if hotbar[pos].amount <= 0:
		hotbar[pos] = null
		var slotinfo := ItemSlotInformation.new()
		slotinfo.name = "none"
		hotbar_infos[pos] = slotinfo
	
	selected_item_changed.emit()
	hotbar_changed.emit()
	Log.DEBUG("Adding hotbar slot "+ str(pos) + " to selected")

func add_new_selected_item_from_hotbar_slot(pos: int, amount: int) -> void:
			current_selected_item = hotbar[pos].duplicate()
			current_selected_item.amount = amount
			
			hotbar[pos].amount -= amount
			hotbar_infos[pos].amount -= amount
			if hotbar[pos].amount <= 0:
				var none: Item = none_item.instantiate()
				hotbar[pos] = none
				var slotinfo := ItemSlotInformation.new()
				slotinfo.name = "none"
				hotbar_infos[pos] = slotinfo
			
			current_inv_mov_state = INV_MOV_STATES.ITEM_SELECTED
			selected_item_changed.emit()
			hotbar_changed.emit()
			Log.DEBUG("Picking up item '"+ current_selected_item.display_name + "' from hotbar pos " + str(pos))

func add_selected_items_to_inventory_slot(pos: Vector2i, amount: int) -> void:
	if inventory_infos[pos.y][pos.x].name == "none":
		inventory[pos.y][pos.x] = current_selected_item.duplicate()
		inventory[pos.y][pos.x].amount = amount
		create_inventory_infos(pos)
		current_selected_item.amount -= amount
		if current_selected_item.amount <= 0:
			current_selected_item = null
			current_inv_mov_state = INV_MOV_STATES.NOTHING_SELECTED
		
		selected_item_changed.emit()
		inventory_changed.emit()
		Log.DEBUG("Dropping x"+ str(amount) + " '"+ inventory[pos.y][pos.x].display_name + "' to hotbar pos " + str(pos))
	elif inventory_infos[pos.y][pos.x].stackable && inventory_infos[pos.y][pos.x].name == current_selected_item.display_name:
		var hotbar_amount: int = inventory_infos[pos.y][pos.x].amount
		
		var remaining_amount: int = 0
		var remove_amount: int = amount
		var new_hotbar_amount: int = hotbar_amount + amount
		if new_hotbar_amount > Constants.MAX_ITEM_STACK_SIZE:
			remaining_amount = new_hotbar_amount-Constants.MAX_ITEM_STACK_SIZE
			remove_amount -= remaining_amount
			new_hotbar_amount = Constants.MAX_ITEM_STACK_SIZE
			
		inventory[pos.y][pos.x].amount = new_hotbar_amount
		inventory_infos[pos.y][pos.x].amount = new_hotbar_amount
		current_selected_item.amount -= remove_amount
		if current_selected_item.amount <= 0:
			current_selected_item = null
			current_inv_mov_state = INV_MOV_STATES.NOTHING_SELECTED
		
		selected_item_changed.emit()
		inventory_changed.emit()
		Log.DEBUG("Adding x"+ str(amount) + " '"+ inventory[pos.y][pos.x].display_name + "' to hotbar pos " + str(pos))

func add_inventory_slot_to_selected_slot(pos: Vector2i) -> void:
	if inventory_infos[pos.y][pos.x].name == "none":
		add_selected_items_to_inventory_slot(pos, current_selected_item.amount)
		return
	
	var slot_amount = inventory[pos.y][pos.x].amount
	var selected_amount = current_selected_item.amount
	
	var new_amount = selected_amount + slot_amount
	var remaining_amount = 0
	var delete_amont = slot_amount
	if new_amount > Constants.MAX_ITEM_STACK_SIZE:
		remaining_amount = new_amount-Constants.MAX_ITEM_STACK_SIZE
		delete_amont -= remaining_amount
		new_amount = Constants.MAX_ITEM_STACK_SIZE


	inventory[pos.y][pos.x].amount -= delete_amont
	inventory_infos[pos.y][pos.x].amount -= delete_amont
	current_selected_item.amount = new_amount
	if inventory[pos.y][pos.x].amount <= 0:
		inventory[pos.y][pos.x] = null
		var slotinfo := ItemSlotInformation.new()
		slotinfo.name = "none"
		inventory_infos[pos.y][pos.x] = slotinfo
	
	selected_item_changed.emit()
	inventory_changed.emit()
	Log.DEBUG("Adding inv slot "+ str(pos) + " to selected")

func add_new_selected_item_from_inventory_slot(pos: Vector2i, amount: int) -> void:
	current_selected_item = inventory[pos.y][pos.x].duplicate()
	current_selected_item.amount = amount
	
	inventory[pos.y][pos.x].amount -= amount
	inventory_infos[pos.y][pos.x].amount -= amount
	if inventory[pos.y][pos.x].amount <= 0:
		var none: Item = none_item.instantiate()
		inventory[pos.y][pos.x] = none
		var slotinfo := ItemSlotInformation.new()
		slotinfo.name = "none"
		inventory_infos[pos.y][pos.x] = slotinfo
	
	current_inv_mov_state = INV_MOV_STATES.ITEM_SELECTED
	selected_item_changed.emit()
	inventory_changed.emit()
	Log.DEBUG("Picking up item '"+ current_selected_item.display_name + "' from inv pos " + str(pos))
