class_name Entity
extends KinematicBody2D

signal emit_damage_number(damage, position)

export var velocity := 50
export var maxHealth := 10
export var health : int = maxHealth
var knockback = Vector2.ZERO
var frozen = false
var frozen_duration = 0

func _ready():
	connect("emit_damage_number", get_tree().current_scene.get_node("DmgNumberManager"), "spawn_damage_number")

func _process(delta):
	freezeTimer+= 1;
	freezeManager()

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, 100)
	knockback = move_and_slide(knockback)
	if(frozen):
		if(frozen_duration == 0):
			frozen = false
		else:
			frozen_duration-=1

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage

var freezeTimer = 300

func freezeFX():
	freezeTimer = 0;

func freezeManager():
	if (freezeTimer < 300):
		get_node("freeze").play("freeze")
		velocity = 0;

func takeKnockback(hitbox : HitBox):
	knockback = hitbox.knockbackDirection * hitbox.knockbackMultiplier
	
func knockback(theta, magnitude):
	knockback = Vector2(magnitude, 0).rotated(theta)
	pass
	
func _dead() ->bool:
	return health <= 0

func freeze():
	print("freeze!")
	frozen = true
	frozen_duration = 180
	pass

func move_forward(delta):
	move_and_slide(Vector2(velocity,0).rotated(global_rotation))
