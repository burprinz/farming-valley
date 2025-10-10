extends Node

enum GameStates {
	ingame,
	pause,
	inventory,
	ingame_ui
}

var current_game_state: GameStates = GameStates.ingame


signal game_state_changed


func _process(delta: float) -> void:
	if Input.is_action_just_pressed("open_inventory"):
		if current_game_state == GameStates.ingame:
			current_game_state = GameStates.inventory
			game_state_changed.emit()
		elif current_game_state == GameStates.inventory || current_game_state == GameStates.ingame_ui:
			current_game_state = GameStates.ingame
			game_state_changed.emit()
	elif Input.is_action_just_pressed("pause"):
		if current_game_state == GameStates.ingame:
			current_game_state = GameStates.pause
			game_state_changed.emit()
		elif current_game_state == GameStates.pause || current_game_state == GameStates.inventory || current_game_state == GameStates.ingame_ui:
			current_game_state = GameStates.ingame
			game_state_changed.emit()


func change_game_state(new_state: GameStates):
	current_game_state = new_state
	game_state_changed.emit()
	
