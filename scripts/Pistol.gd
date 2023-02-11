extends Weapon

export (PackedScene) var Bullet

func _process(delta):
	._process(delta)
	$Label.text = var2str(currentClip) + "/" + var2str(clip)
	$Label2.text = var2str(reserveClips)
	look_at(get_global_mouse_position())

func primaryFire():
	if self.reloadAndShootDelay == 0:
		if(currentClip > 0):
			var bullet_instance = Bullet.instance();
			var target = get_global_mouse_position()
			var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
			
			get_parent().get_parent().emit_signal("player_shot", 
												bullet_instance,
												$BarrelEnd.global_position, 
												direction_to_mouse,
												damage, knockbackMultiplier);
			currentClip -=1
			if(self.currentClip > 0):
				self.reloadAndShootDelay = fireRate
			else:
				self.reloadAndShootDelay = reloadTimeFrames

func secondaryFire():
	pass