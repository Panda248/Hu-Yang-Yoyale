extends Item

export var amount = 10

func _ready():
	._ready()
	item_name = "LIGHT"

func pick_up(player: Player):
	player.addAmmo(amount, item_name)
	queue_free()
