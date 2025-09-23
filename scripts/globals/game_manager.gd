extends Node

enum GameStates {
	ingame,
	pause,
	inventory
}

var current_game_state: GameStates = GameStates.ingame

signal game_state_changed

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if current_game_state == GameStates.ingame:
			current_game_state = GameStates.inventory
			game_state_changed.emit()
		elif current_game_state == GameStates.inventory:
			current_game_state = GameStates.ingame
			game_state_changed.emit()
