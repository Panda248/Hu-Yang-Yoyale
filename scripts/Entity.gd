class_name Entity
extends KinematicBody2D

export var velocity := 50
export var health := 10
var knockback = Vector2.ZERO

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 200*delta)
	knockback = move_and_slide(knockback)

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage
	
func takeKnockback(hitbox : HitBox):
	knockback = hitbox.knockbackDirection * hitbox.knockbackMultiplier
	
func _dead() ->bool:
	return health <= 0
	return health <= 0

func move_forward(delta):
	move_and_slide(Vector2(velocity*delta*60,0).rotated(global_rotation))
