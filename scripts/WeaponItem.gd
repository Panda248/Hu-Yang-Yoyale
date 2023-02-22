extends Item
class_name WeaponItem

export (PackedScene) var weapon
export var weaponName = "WeaponItem"
onready var weaponInstance = weapon.instance()


func pick_up(player):
	if(player_has_self(player) == null):
		player.pick_up_weapon(weaponInstance)
		emit_signal("notify_picked_up", "Picked Up " + weaponName, global_position + Vector2.UP*messageOffsetY, 0.5)
	else:
		player_has_self(player).reserveClips += (weaponInstance.reserveClips + 1)
		emit_signal("notify_picked_up", "Picked Up " + var2str(weaponInstance.reserveClips + 1) + " " +  weaponName + " clips", self.global_position + Vector2.UP*messageOffsetY, 0.5)
	queue_free()

func player_has_self(player : Player):
	var equipped = player.equipped.get_child(0)
	if equipped.get_class() == weaponInstance.get_class():
		return equipped
	var weapons = player.weapons.get_children()
	for w in weapons:
		if w.get_class() == weaponInstance.get_class():
			return equipped
	return null
	pass
