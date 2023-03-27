extends Item
class_name WeaponItem

export (PackedScene) var weapon
export var weaponName = "WeaponItem"
onready var weaponInstance = weapon.instance()


func pick_up(player):
	if(player_has_self(player) == null):
		if(!player.find_node("Inventory").add_item_to_inventory(self)):
			emit_signal("notify_picked_up", "No Inventory Space", global_position + Vector2.UP*messageOffsetY, 0.5)
		else:
			player.pick_up_weapon(weaponInstance)
			emit_signal("notify_picked_up", "Picked Up " + weaponName, global_position + Vector2.UP*messageOffsetY, 0.5)
	else:
		player_has_self(player).reserveClips += (weaponInstance.reserveClips + 1)
		emit_signal("notify_picked_up", "Picked Up " + var2str(weaponInstance.reserveClips + 1) + " " +  weaponName + " clips", self.global_position + Vector2.UP*messageOffsetY, 0.5)
		queue_free()

func player_has_self(player : Player):
	var playerWeapons = player.get_hotbar()
	if playerWeapons.empty():
		return null
	for w in playerWeapons:
		if w.get_class() == weaponInstance.get_class():
			return w
	return null
