extends Control

onready var player = find_parent("Player")

func _process(delta):
	$Label.text = var2str(player.equippedWeapon.currentClip) + "/" + var2str(player.equippedWeapon.clip)
