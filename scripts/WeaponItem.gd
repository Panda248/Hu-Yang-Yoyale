extends Item
class_name WeaponItem

onready var weaponInstance = $WeaponInstance

func _ready():
	item_type = "WEAPON"
	item_quantity = 1;
	stack_size = 1;

func pick_up(player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	$Attachments.visible = true
	weaponInstance.visible = true

func player_has_self(player):
	var playerWeapons = player.get_hotbar()
	if playerWeapons.empty():
		return null
	for w in playerWeapons:
		if w.get_class() == weaponInstance.get_class():
			return w
	return null

func add_attachment(item):
	$Attachments.add_child(item)
	item.attachmentModifier(self)
	pass

func remove_attachment(item):
	item.reset(self)
	$Attachments.remove_child(item)
	pass

func get_attachments():
	return $Attachments.get_children()
