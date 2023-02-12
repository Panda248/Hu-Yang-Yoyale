extends Node2D

export (PackedScene) var Alert

func alertEnemies(position, alertRadius):
	var alert = Alert.instance()
	alert.get_node("CollisionShape2D").shape.radius = 1
	alert.position = position;
	alert.maxRadius = alertRadius
	add_child(alert);
	pass
