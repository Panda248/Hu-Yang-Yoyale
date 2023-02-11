class_name HitBox
extends Area2D

export var damage = 0
export var knockbackDirection : Vector2 = Vector2.ZERO
export var knockbackMultiplier = 0

func _init() -> void:
	collision_layer = 2
	collision_mask = 0
	pass 



