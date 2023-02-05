extends Node2D

onready var bullet_manager = $BulletManager;
onready var player = $Player;

func _ready():
	player.connect("player_shot", bullet_manager, "bullet_shot");


func _process(delta):
	for item in get_children():
		if item.has_method("_dead"):
			if item._dead():
				remove_child(item)
	
	pass
