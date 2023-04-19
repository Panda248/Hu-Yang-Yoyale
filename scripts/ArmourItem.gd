extends Item
class_name ArmourItem

onready var armourInstance = $ArmourInstance

var shield = 0
var movementPenalty = 0
var armourType

func _ready():
	item_type = "ARMOUR"
	item_quantity = 1;
	stack_size = 1;

func pick_up(player: Player):
	.pick_up(player)
	monitorable = false
	monitoring = false
	$Icon.visible = false
	$Quantity.visible = false
	armourInstance.visible = true

func player_has_self(player : Player):
	var playerGear = player.get_gear()
	if playerGear.empty():
		return null
	for w in playerGear:
		if w.get_class() == armourInstance.get_class():
			return w
	return null

func get_shield():
	return shield

func get_type():
	return armourType
