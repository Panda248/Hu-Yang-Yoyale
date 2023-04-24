extends Item

export var suppressReducer = 0.15;

func _ready():
	._ready()
	item_name = "SUPPRESSOR"
	item_type = "ATTACHMENT"

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
	weapon.suppress(suppressReducer)
	weapon.find_node("ShootSFX").set_stream(load("res://res/exported/sound/silencedshoot.wav"))
	var barrelEndPosition = weapon.find_node("BarrelEnd").global_position
	global_position = barrelEndPosition
func reset(weapon):
	weapon.resetSuppress()
	weapon.find_node("ShootSFX").set_stream(load("res://res/exported/sound/pistol shoot.wav"))
