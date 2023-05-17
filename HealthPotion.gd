extends Consumable

export var healthGain = 5

func _ready():
	._ready()
	stack_size = 1;

func use():
	player.health += healthGain
	player.healFX()
	item_quantity-=1
	if(item_quantity == 0):
		find_parent("Inventory").remove_item(self)
	$Sound.play()
	pass 

func input_action():
	if Input.is_action_just_pressed("game_primary_fire"):
		use()
