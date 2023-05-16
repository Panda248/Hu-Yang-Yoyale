extends Item

func pick_up(player):
	player.addFlesh(1)
	queue_free()
