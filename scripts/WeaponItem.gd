extends Item
class_name WeaponItem

onready var weaponInstance = $WeaponInstance

func _ready():
	item_type = "WEAPON"
	item_quantity = 1;
	if item_type == "WEAPON":
		stack_size = 1;

func pick_up(player):
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

func add_attachment(item):
	weaponInstance.add_child(item)
	item.attachmentModifier(self)
	pass

func remove_attachment(item):
	pass

func get_attachments():
	var attachments = []
	for child in get_children():
		if child is Item:
			if child.item_type == "ATTACHMENTS":
				attachments.append(child)
	return attachments
