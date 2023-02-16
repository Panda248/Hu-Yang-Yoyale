extends Weapon

export (PackedScene) var Bullet
export var shootTimeMS = 100
var timer = shootTimeMS

func _process(delta):
	._process(delta)
	$Label.text = var2str(currentClip) + "/" + var2str(clip)
	$Label2.text = var2str(reloadAndShootDelay)
	look_at(get_global_mouse_position())
	if($MuzzleFlash.is_visible()):
		timer-=delta*1000
		if(timer <= 0):
			$MuzzleFlash.set_visible(false)

func primaryFire():
	if self.reloadAndShootDelay <= 0:
		if(currentClip > 0):
			var bullet_instance = Bullet.instance();
			var target = get_global_mouse_position()
			var direction_to_mouse = $BarrelEnd.global_position.direction_to(target).normalized();
			$ShootSFX.play(0)
			$MuzzleFlash.set_visible(true)
			timer = shootTimeMS
			alert()
			get_parent().get_parent().emit_signal("player_shot", 
												bullet_instance,
												$BarrelEnd.global_position, 
												direction_to_mouse,
												damage, knockbackMultiplier);
			currentClip -= 1
			if(self.currentClip > 0):
				self.reloadAndShootDelay = fireRate
				
			elif (reserveClips > 0):
				self.reloadAndShootDelay = reloadTimeFrames
				$ReloadSFX.play(0)

func secondaryFire():
	pass

func reload():
	if (currentClip < clip && self.reloadAndShootDelay <= 0 && reserveClips > 0):
		currentClip = clip
		reserveClips -= 1
		self.reloadAndShootDelay = reloadTimeFrames
		$ReloadSFX.play(0)
