extends Node2D



func alertEnemies(alert, position, radius):
	add_child(alert)
	alert.setGlobalPosition(position)
	alert.setMaxRadius(radius)

