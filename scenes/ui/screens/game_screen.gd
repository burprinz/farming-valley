extends CanvasLayer

@onready var ingame_screen: CanvasLayer = $IngameScreen
@onready var inventory_screen: CanvasLayer = $InventoryScreen


func _ready() -> void:
	ingame_screen.show()
	inventory_screen.hide()
	
	GameManager.game_state_changed.connect(on_game_state_changed)


func on_game_state_changed() -> void:
	if GameManager.current_game_state == GameManager.GameStates.ingame:
		ingame_screen.show()
		inventory_screen.hide()
	elif GameManager.current_game_state == GameManager.GameStates.inventory:
		inventory_screen.show()
		ingame_screen.hide()
