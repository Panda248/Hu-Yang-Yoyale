extends Control

onready var player = find_parent("Player")
var first = true


func _process(delta):
	if(player.equippedWeapon is Weapon):
		$Label.text = var2str(player.equippedWeapon.currentClip) + "/" + var2str(player.equippedWeapon.clip)
		if(player.equippedWeapon.reloadAndShootDelay > 0):
			$reload.visible = true
			if(first):
				$reload.max_value = player.equippedWeapon.reloadAndShootDelay
				first = false
			$reload.value = $reload.max_value - player.equippedWeapon.reloadAndShootDelay
		else:
			$reload.visible = false
	elif(player.equippedWeapon is Consumable):
		$Label.text = var2str(player.equippedWeapon.item_quantity)
	else:
		$reload.visible = false
		first = true
