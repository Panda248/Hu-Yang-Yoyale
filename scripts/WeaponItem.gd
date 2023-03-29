extends Item
class_name WeaponItem

onready var weaponInstance = $WeaponInstance


func pick_up(player: Player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	weaponInstance.visible = true

func player_has_self(player : Player):
	var playerWeapons = player.get_hotbar()
	if playerWeapons.empty():
		return null
	for w in playerWeapons:
		if w.get_class() == weaponInstance.get_class():
			return w
	return null
