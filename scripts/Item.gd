extends Area2D
class_name Item

export var messageOffsetY = 50
var canInteract : bool = false
onready var rect_size = $TextureRect.rect_size * $TextureRect.rect_scale

signal notify_picked_up(message, position, scale)


func pick_up(player: Player):
	emit_signal("notify_picked_up", "picked up", global_position + Vector2.UP*messageOffsetY, 0.5)
	queue_free()
