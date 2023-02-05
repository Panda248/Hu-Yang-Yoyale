extends Node2D

onready var bullet_manager = $BulletManager;
var tick = 0

func _ready():
	$Player.connect("player_shot", bullet_manager, "bullet_shot");


func _process(delta):
	tick += 1
	for item in get_children():
		if item.has_method("_dead"):
			if item._dead():
				remove_child(item)
	pass
