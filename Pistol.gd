extends "res://Weapon.gd"

export (PackedScene) var Bullet

func _process(delta):
	look_at(get_global_mouse_position())

func primaryFire():
	var bullet_instance = Bullet.instance();
	var target = get_global_mouse_position()
	var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
	
	get_parent().emit_signal("player_shot", bullet_instance, $BarrelEnd.global_position, direction_to_mouse, damage);
	pass

func secondaryFire():
	pass
