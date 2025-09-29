extends PanelContainer

@export var pause_screen: PauseScreen

@onready var back_to_game_button: Button = $VBoxContainer/BackToGameButton
@onready var settings: Button = $VBoxContainer/Settings
@onready var save_and_quit: Button = $VBoxContainer/SaveAndQuit

func _ready() -> void:
	pass


func _on_back_to_game_button_pressed() -> void:
	GameManager.change_game_state(GameManager.GameStates.ingame)

func _on_settings_pressed() -> void:
	pause_screen.to_settings()

func _on_statistics_pressed() -> void:
	pause_screen.to_statistics()

func _on_save_and_quit_pressed() -> void:
	get_tree().quit()
