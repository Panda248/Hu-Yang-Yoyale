extends Weapon
class_name AssaultRifle

export (PackedScene) var Bullet


func get_class():
	return "AssaultRifle"

func _process(delta):
	._process(delta)
	$Label.text = var2str(currentClip) + "/" + var2str(clip)
	look_at(get_global_mouse_position())
	if($MuzzleFlash.is_visible()):
		self.timer-=delta*1000
		if(self.timer <= 0):
			$MuzzleFlash.set_visible(false)

func input_action():
	if Input.is_action_pressed("game_primary_fire"):
		primaryFire()
	elif Input.is_action_just_pressed("reload"):
		reload()
	pass

func primaryFire():
	if self.reloadAndShootDelay <= 0:
		if(currentClip > 0):
			var bullet_instance = Bullet.instance();
			var target = get_global_mouse_position()
			var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
			$ShootSFX.play(0)
			$MuzzleFlash.set_visible(true)
			self.timer = self.shootTimeMS
			alert()
			find_parent("Player").emit_signal("player_shot", 
												bullet_instance,
												$BarrelEnd.global_position, 
												direction_to_mouse,
												damage, knockbackMultiplier);
			find_parent("Player").knockback(find_parent("Player").global_rotation, selfKnockback*-0.5)
			currentClip -= 1
			if(self.currentClip > 0):
				self.reloadAndShootDelay = fireRate
				
			elif (reserveClips > 0):
				self.reloadAndShootDelay = reloadTimeFrames
				$ReloadSFX.play(0)

func secondaryFire():
	pass

