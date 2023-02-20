extends Area2D
class_name Item

var canInteract : bool = false
var messageOffsetY = 50

signal notify_picked_up(message, position, scale)

func _ready():
	$TextureRect.texture = load("res://res/exported/sprites/awp.png")

func pick_up(player: Player):
	emit_signal("notify_picked_up", "picked up", global_position + Vector2.UP*messageOffsetY, 0.5)
	queue_free()
