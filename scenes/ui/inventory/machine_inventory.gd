class_name MachineInventory
extends PanelContainer

@onready var rows: VBoxContainer = $Rows

var none_item = preload("res://scenes/items/classes/none_item.tscn")
var slot = preload("res://scenes/ui/inventory/inventory_button.tscn")

var inv_size : Vector2i

var slots : Array[Array]
var items : Array[Array]

func _ready() -> void:
	hide()
	
	GameManager.game_state_changed.connect(on_game_state_changed)

func set_inv_size(s : Vector2i) -> void:
	inv_size = s
	for y in range(inv_size.y):
		var bar : Array[InventoryButton]
		var item_bar : Array[Item]
		var cont : HBoxContainer = HBoxContainer.new()
		for x in range(inv_size.x):
			var ins : InventoryButton = slot.duplicate().instantiate()
			ins.pressed.connect(Callable(self, "on_inventory_button_pressed").bind(Vector2i(x,y)))
			
			cont.add_child(ins)
			bar.append(ins)
			
			var none = none_item.instantiate() as Item
			item_bar.append(none)
		rows.add_child(cont)
		slots.append(bar)
		items.append(item_bar)

func show_inv(offset : int) -> void:
	var cam : Camera2D = get_tree().get_first_node_in_group("camera")
	global_position = cam.global_position - Vector2(size.x/2, size.y+20) + Vector2(offset*(size.x+10),0)
	GameManager.change_game_state(GameManager.GameStates.ingame_ui)
	MachineManager.set_machine_inv(self)
	show()

func add_items(item : Item) -> int:
	for y in range(inv_size.y):
		var bar : Array[InventoryButton] = slots[y]
		var item_bar : Array[Item] = items[y]
		for x in range(inv_size.x):
			if item_bar[x]._get_type() == "none":
				#print("Empty Spot")
				item_bar[x] = item
				bar[x].set_item(item)
				return 0
			elif item_bar[x].display_name == item.display_name:
				var new_am = item_bar[x].amount + item.amount
				#print("Same Item: Adding ", item.amount, " to ", item_bar[x].amount)
				var remaining = 0
				if new_am > Constants.MAX_ITEM_STACK_SIZE:
					remaining = new_am - Constants.MAX_ITEM_STACK_SIZE
					new_am = Constants.MAX_ITEM_STACK_SIZE
				item_bar[x].amount = new_am
				bar[x].change_amount(item_bar[x].amount)
				item.amount = remaining
				#print("New am: ", item_bar[x].amount, ", remaining: ", item.amount)
				if item.amount == 0:
					return 0
	return item.amount

func on_inventory_button_pressed(pos : Vector2i) -> void:
	if items[pos.y][pos.x]._get_type() != "none":
		var rem : int = InventoryManager.consume_items(items[pos.y][pos.x])
		if rem == 0:
			var none = none_item.instantiate() as Item
			items[pos.y][pos.x] = none
			slots[pos.y][pos.x].remove_item()
		else:
			items[pos.y][pos.x].amount = rem
			slots[pos.y][pos.x].change_amount(rem)

func _on_exit_button_pressed() -> void:
	GameManager.change_game_state(GameManager.GameStates.ingame)
	MachineManager.remove_machine_inv()
	hide()
	
func on_game_state_changed() -> void:
	if GameManager.current_game_state != GameManager.GameStates.ingame_ui:
		MachineManager.remove_machine_inv()
		hide()

func get_one_seed() -> SeedItem:
	for y in range(inv_size.y):
		var bar : Array[InventoryButton] = slots[y]
		var item_bar : Array[Item] = items[y]
		for x in range(inv_size.x):
			if item_bar[x]._get_type() == "seed":
				var tmp : SeedItem = item_bar[x].duplicate()
				tmp.amount = 1
				item_bar[x].amount -= 1
				if item_bar[x].amount <= 0:
					var none : Item = none_item.instantiate()
					item_bar[x] = none
					bar[x].remove_item()
				else:
					bar[x].change_amount(item_bar[x].amount)
				return tmp
	return null
				
func get_seed_item(max_am : int) -> Array[Item]:
	
	var result : Array[Item]
	
	for y in range(inv_size.y):
		var bar : Array[InventoryButton] = slots[y]
		var item_bar : Array[Item] = items[y]
		for x in range(inv_size.x):
			if item_bar[x]._get_type() == "seed":
				var tmp : Item = item_bar[x].duplicate()
				if item_bar[x].amount > max_am:
					tmp.amount = max_am
					item_bar[x].amount -= max_am
					max_am = 0
					result.append(tmp)
					bar[x].change_amount(item_bar[x].amount)
				else:
					tmp.amount = item_bar[x].amount
					max_am -= tmp.amount
					result.append(tmp)
					var none : Item = none_item.instantiate()
					item_bar[x] = none
					bar[x].remove_item()
				if max_am == 0:
					return result
	return result
