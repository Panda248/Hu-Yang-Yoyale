extends Node2D

export (PackedScene) var Alert

func alertEnemies(position, alertRadius):
	var alert = Alert.instance()
	alert.global_position = position;
	alert.maxRadius = alertRadius
	add_child(alert);
