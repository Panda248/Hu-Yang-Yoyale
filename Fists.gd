extends Weapon

func _enter_tree():
	$HitBox.damage = damage
func _process(delta):
	if(self.reloadAndShootDelay > 0):
		self.reloadAndShootDelay-=1
	$Label.text = String(reloadAndShootDelay)

func primaryFire():
	if reloadAndShootDelay == 0:
		$AnimationPlayer.play("attackLeft")
		self.reloadAndShootDelay = fireRate

func secondaryFire():
	if reloadAndShootDelay == 0:
		$AnimationPlayer.play("attackRight")
		self.reloadAndShootDelay = fireRate
