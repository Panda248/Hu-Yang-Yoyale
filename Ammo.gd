extends Control

onready var player = find_parent("Player")
var first = true


func _process(delta):
	if(int($LightCount/Label.text) != player.lightBullets):
		$LightCount/Label.text = var2str(player.lightBullets)
	if(int($MediumCount/Label.text) != player.mediumBullets):
		$MediumCount/Label.text = var2str(player.mediumBullets)
	if(int($HeavyCount/Label.text) != player.heavyBullets):
		$HeavyCount/Label.text = var2str(player.heavyBullets)
	if(int($ShellCount/Label.text) != player.shells):
		$ShellCount/Label.text = var2str(player.shells)
	if(player.equippedWeapon is Weapon):
		if(player.equippedWeapon.get_name() == "Fists"):
			$Label.text = ""
		else:
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
