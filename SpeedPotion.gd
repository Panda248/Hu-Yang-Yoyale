extends Consumable

func _ready():
	._ready()
	item_quantity = 1;

func use():
	player.speedFX()
	find_parent("Inventory").remove_item(self)
	pass 

func input_action():
	if Input.is_action_just_pressed("game_primary_fire"):
		use()
