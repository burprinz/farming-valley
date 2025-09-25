class_name PauseScreen
extends CanvasLayer

@onready var pause_main: PanelContainer = $PauseMain
@onready var pause_settings: PanelContainer = $PauseSettings



func _ready() -> void:
	pause_settings.hide()
	pause_main.show()

func to_settings() -> void:
	pause_main.hide()
	pause_settings.show()
