extends CanvasLayer

@onready var ingame_screen: CanvasLayer = $IngameScreen
@onready var inventory_screen: CanvasLayer = $InventoryScreen
@onready var pause_screen: CanvasLayer = $PauseScreen
@onready var machine_screen: CanvasLayer = $MachineScreen


func _ready() -> void:
	ingame_screen.show()
	inventory_screen.hide()
	pause_screen.hide()
	machine_screen.hide()
		
	GameManager.game_state_changed.connect(on_game_state_changed)


func on_game_state_changed() -> void:
	var game_state = GameManager.current_game_state
	if game_state == GameManager.GameStates.ingame:
		pause_screen.hide()
		inventory_screen.hide()
		machine_screen.hide()
		ingame_screen.show()
	elif game_state == GameManager.GameStates.inventory:
		pause_screen.hide()
		ingame_screen.hide()
		machine_screen.hide()
		inventory_screen.show()
	elif game_state == GameManager.GameStates.pause:
		ingame_screen.hide()
		inventory_screen.show()
		machine_screen.hide()
		pause_screen.show()
		pause_screen.to_main()
	elif game_state == GameManager.GameStates.ingame_ui:
		pause_screen.hide()
		ingame_screen.hide()
		inventory_screen.hide()
		machine_screen.show()
