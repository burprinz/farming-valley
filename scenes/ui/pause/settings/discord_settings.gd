class_name DiscordSettings
extends Control

@onready var details: TextEdit = $MarginContainer/VBoxContainer/Details
@onready var large_text: TextEdit = $MarginContainer/VBoxContainer/LargeText
@onready var small_text: TextEdit = $MarginContainer/VBoxContainer/SmallText



func _on_save_button_pressed() -> void:
	DataManager.discord_details = details.text
	DataManager.discord_large_image_text = large_text.text
	DataManager.discord_small_image_text = small_text.text
	
	DiscordManager.change_discord_integration()
	
	#(get_parent() as PauseSettings).to_settings()
