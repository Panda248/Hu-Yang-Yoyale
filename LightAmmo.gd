extends Item

func _ready():
	._ready()
	item_name = "LIGHT"

func pick_up(player: Player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false