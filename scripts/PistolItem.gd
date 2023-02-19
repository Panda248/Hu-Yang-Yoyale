extends Item
class_name PistolItem

export (PackedScene) var pistol
onready var pistolInstance = pistol.instance()

func pick_up(player: Player):
	if(player_has_self(player) == null):
		player.pick_up_weapon(pistolInstance)
		emit_signal("notify_picked_up", "Picked Up Pistol", global_position + Vector2.UP*messageOffsetY, 0.5)
	else:
		player_has_self(player).reserveClips += (pistolInstance.reserveClips + 1)
		emit_signal("notify_picked_up", "Picked Up " + var2str(pistolInstance.reserveClips + 1) + " clips", self.global_position + Vector2.UP*messageOffsetY, 0.5)
	queue_free()

func player_has_self(player : Player):
	var equipped = player.equipped.get_child(0)
	if(equipped is Pistol):
		return equipped
	var weapons = player.weapons.get_children()
	for weapon in weapons:
		if weapon is Pistol:
			return equipped
	return null
	pass
