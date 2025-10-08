class_name Crop
extends Sprite2D

@export var water_reminder : TextureRect
@export var output_items : Array[PackedScene]
@export var output_probs : Array[float]

var id : int
var cell_pos : Vector2i

var mature_length: int
var days_passed: int = 0
var is_currently_watered: bool = false


func _ready() -> void:
	frame = days_passed
	mature_length = hframes
	water_reminder.show()
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)


func on_time_tick_day(day: int) -> void:
	if is_currently_watered:
		days_passed += 1
		is_currently_watered = false
		frame = days_passed
	
	if days_passed == mature_length:
		call_deferred("harvest_plant")
		queue_free()
	
	if is_currently_watered == false:
		water_reminder.show()
		
func harvest_plant() -> void:
	var layer  = get_tree().get_first_node_in_group("item_drop_layer") as Node
	var drops : Array[Item] = create_drops()
	Statistics.add_harvested_crop(drops[0].display_name + " Plant", 1)
	CropfieldManager.remove_crop(cell_pos)
	for item : Item in drops:
		layer.add_child(item)
		
func water_crop() -> void:
	if is_currently_watered:
		return
	is_currently_watered = true
	water_reminder.hide()

func create_drops() -> Array[Item]:
	
	var drops : Array[Item]
	
	for i in range(len(output_items)):
		var item_am : int = floor(output_probs[i])
		var prob = output_probs[i] - item_am
		if prob > 0 && prob >= randf():
			item_am += 1
		
		if item_am > 0:
			var item : Item = output_items[i].instantiate()
			item.amount = item_am
			item.global_position = global_position
			drops.append(item)
				
	return drops
