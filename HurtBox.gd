class_name HurtBox
extends Area2D

func _init() -> void:
	collision_layer = 0
	collision_mask = 2
	pass

func _ready() -> void:
	connect("area_entered", self, "_on_area_entered")
	pass

func _on_area_entered(hitbox : HitBox) -> void:
	if hitbox == null:
		return
	
	if owner.has_method("takeDamage"):
		owner.takeDamage(hitbox.damage)
