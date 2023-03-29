extends Area2D
class_name Item

export var messageOffsetY = 50
var canInteract : bool = false
onready var radius = $CollisionShape2D.get_shape().radius
onready var size = Vector2(radius*scale.x, radius*scale.y)

var stack_size
export var item_name = "baseItem"
var item_type
var item_quantity

signal notify_picked_up(message, position, scale)

func _ready():
	item_type = "AMMO"
	item_quantity = 1;
	if item_type == "WEAPON":
		stack_size = 1;
	if item_type == "AMMO":
		stack_size = 99;
		
	if stack_size == 1:
		$Label.visible = false
	$Quantity.text = String(item_quantity)

func pick_up(player: Player):
	emit_signal("notify_picked_up", "picked up", global_position + Vector2.UP*messageOffsetY, 0.5)
	get_parent().remove_child(self)
	player.inventory.add_item(self)

func add_items(quantity):
	item_quantity += quantity
	$Quantity.text = String(item_quantity)

func remove_items(quantity):
	item_quantity -= quantity
	$Quantity.text = String(item_quantity)

