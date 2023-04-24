extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func bullet_shot(bullet, position, direction, damage, knockbackMultiplier):
	add_child(bullet);
	bullet.get_node("HitBox").damage = damage
	bullet.get_node("HitBox").knockbackMultiplier = knockbackMultiplier
	bullet.get_node("HitBox").knockbackDirection = bullet.get_node("HitBox").knockbackDirection.rotated(direction.angle())
	bullet.global_position = position;
	bullet.set_direction(direction);
func proj_shot(projectile):
	add_child(projectile)
