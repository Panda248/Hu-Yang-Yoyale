extends Node2D

func spawn_item(item : Item):
	add_child(item)
	item.connect("notify_picked_up", get_node("%NotificationManager"), "notify")
