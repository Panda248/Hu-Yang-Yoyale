extends Weapon
class_name RockThrower

export (PackedScene) var Bullet

func get_class():
	return "RockThrower"

func _process(delta):
	if(self.reloadAndShootDelay > 0):
			self.reloadAndShootDelay-= delta*60
	elif(currentClip == 0):
		currentClip = clip
	look_at(get_parent().get_parent().get_node("Player").position)

func primaryFire():
	if self.reloadAndShootDelay <= 0:
		var bullet_instance = Bullet.instance();
		var target = get_parent().get_parent().get_node("Player").position
		var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
		$ShootSFX.play(0)
		timer = shootTimeMS
		get_parent().get_parent().get_node("Player").emit_signal("player_shot", 
											bullet_instance,
											$BarrelEnd.global_position, 
											direction_to_mouse,
											damage, knockbackMultiplier);
		get_parent().get_node("Fists").primaryFire()
		self.reloadAndShootDelay = fireRate


func secondaryFire():
	pass
