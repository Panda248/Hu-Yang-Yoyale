extends WeaponItem

func pick_up(player):
	.pick_up(player)
	$WeaponInstance/RigidBody2D/CollisionShape2D2.disabled = false

func changeToItemMode():
	.changeToItemMode()
	$WeaponInstance/RigidBody2D/CollisionShape2D2.disabled = true
