extends Item
class_name Consumable

var player

func _ready():
	item_type = "CONSUMABLE"

func _process(delta):
	if (!player == null):
		self.position = Vector2(0, player.weaponOffset)

func pick_up(player1):
	.pick_up(player1)
	player = player1
	monitorable = false
	monitoring = false
	pass
	
func spawn(player1):
	.spawn(player1)
	player = player1
	monitorable = false
	monitoring = false
	pass

func changeToItemMode():
	monitorable = true
	monitoring = true

func use():
	pass
