extends Node2D

onready var zoomValue;

func _ready():
	zoomValue = 0.5; 

func attachmentModifier():
	find_parent("Player").setZoom(zoomValue);
	
