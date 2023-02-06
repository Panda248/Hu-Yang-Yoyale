extends Node2D

onready var bullet_manager = $BulletManager;
var ticks = 0
var tickRate = 1

func _ready():
	$Player.connect("player_shot", bullet_manager, "bullet_shot");


func _process(delta):
	ticks += tickRate
	for item in get_children():
		if item.has_method("_dead"):
			if item._dead():
				remove_child(item)
	pass
