extends Node2D

export (PackedScene) var Notification

func notify(message, position, scale):
	var notif = Notification.instance()
	notif.text = message
	notif.rect_global_position = position
	notif.rect_scale *= scale
	add_child(notif)
	pass # Replace with function body.
