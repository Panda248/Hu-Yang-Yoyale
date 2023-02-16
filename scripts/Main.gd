extends Node2D


onready var bullet_manager = $BulletManager;
onready var alert_manager = $AlertManager;
onready var chatbox_manager = $ChatBoxManager
export (PackedScene) var Enemy


func _ready():
	$InteractableNPC.connect("send_message", chatbox_manager, "send_chat")
	$Player.connect("player_shot", bullet_manager, "bullet_shot");
	$Player.connect("alert_enemies", alert_manager, "alertEnemies");


func _process(delta):

	for item in get_children():
		if item.has_method("_dead"):
			if item._dead():
				remove_child(item)

	if Engine.get_iterations_per_second()%600 == 0:
		add_child(Enemy.instance())


	pass
