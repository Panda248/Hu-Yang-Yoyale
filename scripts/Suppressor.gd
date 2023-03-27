extends Node2D

onready var alertRadius;

func _ready():
	alertRadius = 200;

func attachmentModifier():
	get_parent().suppress(alertRadius)
