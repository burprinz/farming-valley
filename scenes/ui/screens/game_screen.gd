extends CanvasLayer

@onready var ingame_screen: CanvasLayer = $IngameScreen
@onready var inventory_screen: CanvasLayer = $InventoryScreen
@onready var pause_screen: CanvasLayer = $PauseScreen


func _ready() -> void:
	ingame_screen.show()
	inventory_screen.hide()
	pause_screen.hide()
	
	GameManager.game_state_changed.connect(on_game_state_changed)


func on_game_state_changed() -> void:
	var game_state = GameManager.current_game_state
	if game_state == GameManager.GameStates.ingame:
		# Inventory, Pause
		pause_screen.hide()
		inventory_screen.hide()
		ingame_screen.show()
	elif game_state == GameManager.GameStates.inventory:
		ingame_screen.hide()
		inventory_screen.show()
	elif game_state == GameManager.GameStates.pause:
		# Ingame
		ingame_screen.hide()
		pause_screen.show()
		pause_screen.to_main()
