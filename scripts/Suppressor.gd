extends Item

onready var suppressReducer;

func _ready():
	._ready()
	item_name = "SUPPRESSOR"
	item_type = "ATTACHMENT"
	suppressReducer = 0.5;

func pick_up(player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	$Sprite.visible = true

func changeToItemMode():
	monitorable = true
	monitoring = true
	$Icon.visible = true
	$Quantity.visible = true
	$Sprite.visible = false

func attachmentModifier(weapon):
	weapon.weaponInstance.suppress(suppressReducer)
	weapon.find_node("ShootSFX").set_stream(load("res://res/exported/sound/silencedshoot.wav"))
	var barrelEndPosition = weapon.find_node("BarrelEnd").position
	position = barrelEndPosition
func reset(weapon):
	weapon.weaponInstance.resetSuppress()
	weapon.find_node("ShootSFX").set_stream(load("res://res/exported/sound/pistol shoot.wav"))
