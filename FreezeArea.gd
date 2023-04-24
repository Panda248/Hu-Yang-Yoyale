extends KinematicBody2D

var moving = true
export var speed = 10
var direction = Vector2(0,0)
export var rotation_speed = 5

func _process(delta):
	if moving:
		rotate(rotation_speed*delta)
		if move_and_collide(direction * speed * delta * 60):
			explode()
		#move and collide and detect collisions
		pass
	else:
		for body in $Area2D.get_overlapping_bodies():
			if(body.has_method("freeze")):
				body.freeze()
		#freeze enemies
		pass


func _on_Lifetime_timeout():
	queue_free()
	pass # Replace with function body.

func explode():
	$Projectile.visible = false
	$Area2D.visible = true
	$CollisionShape2D.disabled = true
	moving = false
	$Lifetime.start()


func _on_ThrowTime_timeout():
	explode()
	pass # Replace with function body.
