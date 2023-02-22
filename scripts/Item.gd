extends Area2D
class_name Item

export var messageOffsetY = 50
var canInteract : bool = false
onready var radius = $CollisionShape2D.get_shape().radius
onready var size = Vector2(radius*scale.x, radius*scale.y)

signal notify_picked_up(message, position, scale)


func pick_up(player: Player):
	if(canInteract):
		owner = player
		emit_signal("notify_picked_up", "picked up", global_position + Vector2.UP*messageOffsetY, 0.5)
		queue_free()
