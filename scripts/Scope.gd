extends Node2D

onready var zoomValue;

func _ready(zoom = 0.2):
	zoomValue = zoom;

func attachmentModifier():
	find_parent("Player").setZoom(zoomValue);
	
