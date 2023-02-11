class_name Entity
extends KinematicBody2D

export var velocity := 50
export var health := 10

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage
	
func takeKnockback(hitbox : HitBox):
	move_and_collide((hitbox.get_owner().global_position.direction_to(global_position)).normalized()*hitbox.knockback)
