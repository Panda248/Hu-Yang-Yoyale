extends Weapon

func _enter_tree():
	$HitBox.knockbackMultiplier = self.knockbackMultiplier

func _process(delta):
	$Label.text = var2str($HitBox.knockbackDirection)
	

func primaryFire():
	if reloadAndShootDelay == 0:
		$HitBox.knockbackDirection = $HitBox.knockbackDirection.rotated(global_rotation-$HitBox.knockbackDirection.angle())
		print(var2str($HitBox.knockbackDirection))
		$AnimationPlayer.play("attackLeft")
		self.reloadAndShootDelay = fireRate

func secondaryFire():
	if reloadAndShootDelay == 0:
		$HitBox.knockbackDirection = $HitBox.knockbackDirection.rotated(global_rotation-$HitBox.knockbackDirection.angle())
		$AnimationPlayer.play("attackRight")
		self.reloadAndShootDelay = fireRate
