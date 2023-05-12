extends Item

export var amount = 20

func _ready():
	._ready()
	item_name = "HEAVY"

func pick_up(player: Player):
	player.addAmmo(amount, item_name)
	queue_free()
