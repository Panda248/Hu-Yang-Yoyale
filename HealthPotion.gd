extends Consumable

export var healthGain = 5

func use(player):
	player.health += healthGain
	pass
