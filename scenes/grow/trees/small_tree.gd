extends Sprite2D

@onready var hurt_component: HurtComponent = $HurtComponent
@onready var damage_component: DamageComponent = $DamageComponent
@onready var item_drop_component: Node = $ItemDropComponent

var log_item_scene = preload("res://scenes/items/materials/log.tscn")

func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_hurt(hit_damage: int) -> void:
	damage_component.apply_damage(hit_damage)
	material.set_shader_parameter("shake_intensity", 0.5)
	await  get_tree().create_timer(1.0).timeout
	material.set_shader_parameter("shake_intensity", 0.0)
	
func on_max_damage_reached() -> void:
	Statistics.add_destroyed_object("Small Tree", 1)
	call_deferred("add_log_scene")
	queue_free()

func add_log_scene() -> void:
	Log.DEBUG("Small Tree breaks and drops Logs")
	item_drop_component.drop_items_on_pos(log_item_scene, 2, global_position)
