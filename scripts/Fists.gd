class_name ThrowRock
extends Weapon

func _enter_tree():
	$HitBox.knockbackMultiplier = knockbackMultiplier
	$HitBox.damage = damage
	pass

func _process(delta):
	._process(delta)
	$Label.text = var2str(reloadAndShootDelay)

func input_action():
	if Input.is_action_just_pressed("game_primary_fire"):
		primaryFire()
	elif Input.is_action_just_pressed("game_secondary_fire"):
		secondaryFire()
	pass

func primaryFire():
	if reloadAndShootDelay <= 0:
		$HitBox.knockbackDirection = $HitBox.knockbackDirection.rotated(global_rotation-$HitBox.knockbackDirection.angle())
		alert()
		$AnimationPlayer.play("attackLeft")
		self.reloadAndShootDelay = fireRate

func secondaryFire():
	if reloadAndShootDelay <= 0:
		$HitBox.knockbackDirection = $HitBox.knockbackDirection.rotated(global_rotation-$HitBox.knockbackDirection.angle())
		alert()
		$AnimationPlayer.play("attackRight")
		self.reloadAndShootDelay = fireRate
