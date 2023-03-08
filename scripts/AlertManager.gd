extends Node2D

export (PackedScene) var Alert

func alertEnemies(position, alertRadius):
	var alert = Alert.instance()
	initializeAlert(alert, position,alertRadius)
	
func initializeAlert(alert, position, alertRadius):
	add_child(alert)
	alert.position = position
	alert.maxRadius = alertRadius
