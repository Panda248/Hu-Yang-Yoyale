extends Control

onready var player = find_parent("Player")
var first = true


func _process(delta):
	$Label.text = var2str(player.equippedWeapon.currentClip) + "/" + var2str(player.equippedWeapon.clip)
	$clips.text = var2str(player.equippedWeapon.reserveClips) + " mags"
	if(player.equippedWeapon.reloadAndShootDelay > 0):
		$reload.visible = true
		if(first):
			$reload.max_value = player.equippedWeapon.reloadAndShootDelay
			first = false
		$reload.value = $reload.max_value - player.equippedWeapon.reloadAndShootDelay
	else:
		$reload.visible = false
		first = true
