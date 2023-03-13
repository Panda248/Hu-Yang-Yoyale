extends Node2D


onready var bullet_manager = $BulletManager;
onready var alert_manager = $AlertManager;
onready var chatbox_manager = $ChatBoxManager
onready var notification_manager = $NotificationManager
export (PackedScene) var Enemy
export (PackedScene) var DeathScreen;
var playerInSafeZone = false

func _ready():
	$Player/UI.visible = true
	$Player.connect("player_shot", bullet_manager, "bullet_shot");
	$Player.connect("alert_enemies", alert_manager, "alertEnemies");
	$Player.connect("death_screen", self, "game_over")

func _process(delta):
	pass

func game_over():
	var deathScreen = DeathScreen.instance()
	add_child(deathScreen)
	get_tree().set_pause(true)



func _on_SafeZone_body_entered(body):
	if body is Player:
		playerInSafeZone = true
	pass # Replace with function body.


func _on_SafeZone_body_exited(body):
	if body is Player:
		playerInSafeZone = false
	pass # Replace with function body.
