extends Area2D
class_name Item


var canInteract : bool = false

func process():
	if(canInteract):
		print("hi")
	pass
	
func pick_up(player: Player):
	queue_free()
