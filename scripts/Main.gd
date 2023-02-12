extends Node2D


onready var bullet_manager = $BulletManager;
onready var alert_manager = $AlertManager;
export (PackedScene) var Enemy
var ticks = 0
var tickRate = 1

func _ready():
	$Player.connect("player_shot", bullet_manager, "bullet_shot");
	$Player.connect("alert_enemies", alert_manager, "alertEnemies");


func _process(delta):
	ticks += tickRate
	for item in get_children():
		if item.has_method("_dead"):
			if item._dead():
				remove_child(item)

	if ticks%600 == 0:
		add_child(Enemy.instance())


	pass
