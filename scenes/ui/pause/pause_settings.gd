class_name PauseSettings
extends PanelContainer

@export var discord_settings: PackedScene

@export var main: PauseScreen

@onready var settings: PanelContainer = $Settings
@onready var variables: PanelContainer = $Variables



func clear_var_panel() -> void:
	for n in variables.get_children():
		variables.remove_child(n)
		n.queue_free()

func _on_discord_button_pressed() -> void:
	pass
	#clear_var_panel()
	
	#var dc: DiscordSettings = discord_settings.instantiate()
	#variables.add_child(dc)
	
	#settings.hide()
	#variables.show()


func back_to_settings() -> void:
	clear_var_panel()
	variables.hide()
	settings.show()
	

func _on_back_button_pressed() -> void:
	main.to_main()
