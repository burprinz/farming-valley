class_name PauseScreen
extends CanvasLayer

@onready var pause_main: PanelContainer = $PauseMain
@onready var pause_settings: PanelContainer = $PauseSettings
@onready var pause_statistics: PanelContainer = $PauseStatistics


func _ready() -> void:
	pause_settings.hide()
	pause_statistics.hide()
	pause_main.show()

func to_main() -> void:
	pause_settings.hide()
	pause_statistics.hide()
	pause_main.show()

func to_settings() -> void:
	pause_main.hide()
	pause_settings.show()

func to_statistics() -> void:
	pause_main.hide()
	pause_statistics.show()
	pause_statistics.refresh()
