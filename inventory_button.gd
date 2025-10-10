class_name InventoryButton
extends Button

@onready var image: TextureRect = $Image
@onready var amount: Label = $Amount

func set_item(item : Item) -> void:
	image.texture = item.texture
	amount.text = "x" + str(item.amount)

func remove_item() -> void:
	image.texture = null
	amount.text = ""

func change_amount(am : int) -> void:
	amount.text = "x" + str(am)
