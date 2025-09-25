extends Node

func _ready() -> void:
	change_discord_integration()

func change_discord_integration() -> void:
	DiscordRPC.app_id = 1420025485848477848
	DiscordRPC.state = DataManager.discord_state
	DiscordRPC.details = DataManager.discord_details
	var start: int = int(Time.get_unix_time_from_system())
	DataManager.discord_start_timestamp = start
	DiscordRPC.start_timestamp = start
	DiscordRPC.large_image = DataManager.discord_large_image
	DiscordRPC.large_image_text = DataManager.discord_large_image_text
	DiscordRPC.small_image = DataManager.discord_small_image
	DiscordRPC.small_image_text = DataManager.discord_small_image_text
	
	DiscordRPC.refresh()
	Log.DEBUG("Discord Integration updated")
