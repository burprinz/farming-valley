extends Node2D

@export var fence_layer : FenceLayer
@export var structure_layer : StructureLayer

func _interact() -> void:
	for y in range(-4,3):
		for x in range(32,40):
			fence_layer.erase_cell(Vector2i(x,y))
	structure_layer.set_cell(Vector2i(35, 3), 0, Vector2i(0,0), 1)
	get_parent().queue_free()
