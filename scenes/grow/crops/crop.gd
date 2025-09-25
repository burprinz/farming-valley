class_name Crop
extends Node2D

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var hurt_component: HurtComponent = $HurtComponent
@onready var water_reminder: TextureRect = $WaterReminder

#@export var aging_texture: Texture2D
var mature_length: int

var cell_position: Vector2i

var days_passed: int = 0
var is_currently_watered: bool = false

var harvest_item: Item

func _ready() -> void:
	#sprite_2d.texture = aging_texture
	sprite_2d.vframes = 1
	#sprite_2d.hframes = mature_length
	sprite_2d.frame = days_passed
	water_reminder.show()
	
	hurt_component.hurt.connect(on_hurt)
	DayAndNightCycleManager.time_tick_day.connect(on_time_tick_day)

func set_properties(texture: Texture2D, len: int, harvest: Item) -> void:
	sprite_2d.texture = texture
	sprite_2d.hframes = len
	mature_length = len
	harvest_item = harvest

func on_time_tick_day(day: int) -> void:
	if is_currently_watered:
		days_passed += 1
		is_currently_watered = false
		sprite_2d.frame = days_passed
	
	if days_passed == mature_length:
		call_deferred("harvest_plant")
		queue_free()
	
	if is_currently_watered == false:
		water_reminder.show()
		
func harvest_plant() -> void:
	var layer  = get_tree().get_first_node_in_group("item_drop_layer") as Node
	
	if harvest_item == null:
		queue_free()
	
	#var drop = item.instantiate() as Item
	#drop.amount = 1
	harvest_item.global_position = global_position
	
	layer.add_child(harvest_item)
		
func water_crop() -> void:
	if is_currently_watered:
		return
	is_currently_watered = true
	water_reminder.hide()

func on_hurt() -> void:
	water_crop()
