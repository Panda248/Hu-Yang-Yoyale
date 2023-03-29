extends Item

onready var alertRadius;

func _ready():
	._ready()
	item_name = "SUPPRESSOR"
	item_type = "ATTACHMENT"
	alertRadius = 900;

func pick_up(player: Player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	$Sprite.visible = true
	
func attachmentModifier():
	get_parent().suppress(alertRadius)
	get_parent().find_node("ShootSFX").set_stream(load("res://res/exported/sound/silencedshoot.wav"))
	global_position = get_parent().find_node("BarrelEnd").global_position
func reset():
	get_parent().suppress(-alertRadius)
	get_parent().find_node("ShootSFX").set_stream(load("res://res/exported/sound/pistol shoot.wav"))
