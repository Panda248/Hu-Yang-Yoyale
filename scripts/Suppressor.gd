extends Item

onready var suppressReducer;

func _ready():
	._ready()
	item_name = "SUPPRESSOR"
	item_type = "ATTACHMENT"
	suppressReducer = 0.5;

func pick_up(player: Player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	$Sprite.visible = true
	
func attachmentModifier(weapon):
	weapon.weaponInstance.suppress(suppressReducer)
	weapon.find_node("ShootSFX").set_stream(load("res://res/exported/sound/silencedshoot.wav"))
	global_position = get_parent().find_node("BarrelEnd").global_position
func reset(weapon):
	weapon.weaponInstance.resetSuppress()
	weapon.find_node("ShootSFX").set_stream(load("res://res/exported/sound/pistol shoot.wav"))
