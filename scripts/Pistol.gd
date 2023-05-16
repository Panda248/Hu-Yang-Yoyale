extends Weapon
class_name Pistol

export (PackedScene) var Bullet


func get_class():
	return "Pistol"

func _process(delta):
	._process(delta)
	$Label.text = var2str(currentClip) + "/" + var2str(clip)
	look_at(get_global_mouse_position())
	if(find_node("MuzzleFlash").is_visible()):
		timer-=delta*1000
		if(timer <= 0):
			find_node("MuzzleFlash").set_visible(false)

func input_action():
	if Input.is_action_just_pressed("game_primary_fire"):
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
			find_node("ShootSFX").play(0)
			find_node("MuzzleFlash").set_visible(true)
			timer = shootTimeMS
			alert()
			find_parent("Player").emit_signal("player_shot", 
												bullet_instance,
												$BarrelEnd.global_position, 
												direction_to_mouse,
												damage, knockbackMultiplier);
			currentClip -= 1
			find_parent("Player").knockback(find_parent("Player").global_rotation, selfKnockback*-0.5)
			if(self.currentClip > 0):
				self.reloadAndShootDelay = fireRate
				
			elif (reserveClips > 0):
				self.reloadAndShootDelay = reloadTimeFrames
				find_node("ReloadSFX").play(0)

func secondaryFire():
	pass
