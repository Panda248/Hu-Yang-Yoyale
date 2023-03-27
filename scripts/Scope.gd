extends Node2D

onready var zoomValue;

func _ready():
	zoomValue = 0.25;

func attachmentModifier():
	find_parent("Player").setZoom(zoomValue);
	
