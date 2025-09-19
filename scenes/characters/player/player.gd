class_name Player
extends CharacterBody2D

@onready var player_hitbox: CollisionShape2D = $CollisionShape2D
@onready var hit_component: HitComponent = $HitComponent
@onready var player_hit_shape: CollisionShape2D = $HitComponent/PlayerHitShape

@export var interaction_radius: int = 30
var player_direction: Vector2
 

func _ready() -> void:
	#player_hitbox.disabled = false
	pass

func get_hit_component_collision_shape() -> CollisionShape2D:
	return player_hit_shape
