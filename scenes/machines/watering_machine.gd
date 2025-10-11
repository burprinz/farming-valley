class_name WateringMachine
extends Machine


func _prepare() -> void:
	DayAndNightCycleManager.six_o_clock.connect(water_crops)
	DayAndNightCycleManager.twenty_o_clock.connect(water_crops)

func water_crops() -> void:
	for x in range(int_top_left.x, int_bot_right.x):
		for y in range(int_top_left.y, int_bot_right.y):
			var b : bool = CropfieldManager.try_to_water_crop(Vector2i(x,y))
