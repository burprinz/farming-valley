class_name Machine
extends Sprite2D

@export var radius : int

var origin_area_pos

var tilesize


func _ready() -> void:
	var farmland: FarmLandLayer = get_tree().get_first_node_in_group("farmland_layer")
	tilesize = farmland.get_used_rect().size.x
	set_radius(1)


func set_radius(r: int) -> void:
	radius = tilesize * r
	#print(radius)
