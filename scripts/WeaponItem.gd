extends Item
class_name WeaponItem

onready var weaponInstance = $WeaponInstance
onready var attachments = $WeaponInstance/Attachments

func _ready():
	item_type = "WEAPON"
	stack_size = 1;

func pick_up(player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.hide()
	$Quantity.hide()
	weaponInstance.show()

func changeToItemMode():
	monitorable = true
	monitoring = true
	$Icon.show()
	$Quantity.show()
	weaponInstance.hide()

func player_has_self(player):
	var playerWeapons = player.get_hotbar()
	if playerWeapons.empty():
		return null
	for w in playerWeapons:
		if w.get_class() == weaponInstance.get_class():
			return w
	return null

func add_attachment(item):
	attachments.add_child(item)
	item.attachmentModifier(weaponInstance)
	pass

func remove_attachment(item):
	item.reset(weaponInstance)
	attachments.remove_child(item)
	pass

func refresh_attachments():
	for attachment in get_attachments():
		attachment.reset(weaponInstance)
		attachment.attachmentModifier(weaponInstance)

func apply_attachments():
	for attachment in get_attachments():
		attachment.attachmentModifier(weaponInstance)

func get_attachments():
	return attachments.get_children()
