class_name Machine
extends Sprite2D

@export var radius : int = 1

var cell_pos : Vector2i

var origin_area_pos

var int_top_left : Vector2i
var int_bot_right : Vector2i

func _ready() -> void:
	change_radius(2)
	


func change_radius(r: int) -> void:
	radius = r
	int_top_left = cell_pos + Vector2i(-radius, -radius)
	int_bot_right = cell_pos + Vector2i(radius+1, radius+1)
	_prepare()


func _prepare() -> void:
	pass
