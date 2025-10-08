extends Control

@onready var v_box_container: VBoxContainer = $MarginContainer/VBoxContainer

var container_list : Array[HoverItemContainer]

var hover_item_container = preload("res://scenes/ui/hover/hover_item_container.tscn")

func create_panel(texts : Array[Texture2D], amounts: Array[int]) -> void:
	
	for i in range(len(texts)):
		var container = hover_item_container.instantiate() as HoverItemContainer
		container.setup(texts[i], amounts[i])
		v_box_container.add_child(container)
		
		container_list.append(container)


func update_colors(enough : Array[int]) -> void:
	for i in range(len(container_list)):
		if enough[i] > 0:
			container_list[i].set_color(Color(1,0,0))
		else:
			container_list[i].set_color(Color(0,1,0))
