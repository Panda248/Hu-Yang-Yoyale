extends "res://Weapon.gd"

export (PackedScene) var Bullet

func _process(delta):
	if(self.reloadAndShootDelay > 0):
		self.reloadAndShootDelay-=1
	look_at(get_global_mouse_position())

func primaryFire():
	if self.reloadAndShootDelay == 0:
		if(self.currentClip > 0):
			self.reloadAndShootDelay = fireRate
		else:
			self.reloadAndShootDelay = reloadTimeFrames
		var bullet_instance = Bullet.instance();
		var target = get_global_mouse_position()
		var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
		
		get_parent().emit_signal("player_shot", bullet_instance, $BarrelEnd.global_position, direction_to_mouse, damage);
		

func secondaryFire():
	pass
