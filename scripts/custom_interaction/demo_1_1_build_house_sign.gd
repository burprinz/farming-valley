extends Node2D

@export var fence_layer : FenceLayer
@export var structure_layer : StructureLayer
@export var overgrowth_layer : OvergrowthLayer

func _interact() -> void:
	for y in range(4,11):
		for x in range(18,26):
			fence_layer.erase_cell(Vector2i(x,y))
			overgrowth_layer.erase_cell(Vector2i(x,y))
	structure_layer.set_cell(Vector2i(21, 10), 0, Vector2i(0,0), 1)
	get_parent().queue_free()
