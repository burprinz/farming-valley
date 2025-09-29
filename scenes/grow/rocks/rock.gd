extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var item_drop_component: Node = $ItemDropComponent


var stone_item_scene = preload("res://scenes/items/materials/stone.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	
func on_max_damage_reached() -> void:
	Statistics.add_destroyed_object("Rock", 1)
	call_deferred("add_stone_scene")
	queue_free()

func add_stone_scene() -> void:
	Log.DEBUG("Rock breaks and drops Stone")
	item_drop_component.drop_items_on_pos(stone_item_scene, 3, global_position)
