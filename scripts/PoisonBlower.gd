extends Weapon
class_name PoisonBlower

export (PackedScene) var Bullet

func get_class():
	return "PoisonBlower"

func _process(delta):
	if(self.reloadAndShootDelay > 0):
		self.reloadAndShootDelay-= delta*60
	elif(currentClip == 0):
		currentClip = clip

	#look_at(get_parent().get_parent().get_node("Player").position)

func primaryFire():
	if self.reloadAndShootDelay <= 0:
		var bullet_instance = Bullet.instance();
		var target = get_parent().get_parent().get_node("Player").position
		var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
		$ShootSFX.play(0)	
		timer = shootTimeMS
		print(var2str(get_parent().rotation))
		var direction = Vector2.RIGHT.rotated(get_parent().rotation)

		print(var2str(direction))
		get_parent().get_parent().get_node("Player").emit_signal("player_shot", 
											bullet_instance,
											$BarrelEnd.global_position, 
											direction,
											damage, knockbackMultiplier);
		self.reloadAndShootDelay = fireRate


func secondaryFire():
	pass
