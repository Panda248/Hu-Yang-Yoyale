extends Node2D

onready var globalVariables = get_node("/root/GlobalVariables")

onready var bullet_manager = $BulletManager;
onready var alert_manager = $AlertManager;
onready var chatbox_manager = $ChatBoxManager
onready var notification_manager = $NotificationManager
var enemies = []
export (PackedScene) var DeathScreen;
export var entityCap = 100
var playerInSafeZone = false
var timeChange = .01
var night = false

func _ready():
	$Player/UI.visible = true
	$Player.connect("player_shot", bullet_manager, "bullet_shot");
	$Player.connect("player_project", bullet_manager, "proj_shot");
	$Player.connect("alert_enemies", alert_manager, "alertEnemies");
	$Player.connect("death_screen", self, "game_over")
	loadCrates()
	loadInteractNPC()

func loadCrates():
	for crate in $Crates.get_children():
		crate.connect("spawn_item", self, "spawn_item")

func loadInteractNPC():
	for npc in $InteractableNPCs.get_children():
		npc.connect("start_dialog", $Dialogue, "startDialog")

func _process(delta):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), globalVariables.volume)
	if(Input.is_action_just_pressed("pause")):
		$PauseScreen.visible = true
		get_tree().set_pause(true)
	day_night()
	
	pass

func game_over():
	var deathScreen = DeathScreen.instance()
	add_child(deathScreen)
	get_tree().set_pause(true)

func spawn_item(item : Item):
	print("hello")
	if(item.get_parent()):
		item.get_parent().remove_child(item)
	add_child(item)
	item.connect("notify_picked_up", get_node("%NotificationManager"), "notify")

func spawn_item_at_pos(item, position):
	if(item.get_parent()):
		item.get_parent().remove_child(item)
	add_child(item)
	item.set_position(position)
	item.connect("notify_picked_up", get_node("%NotificationManager"), "notify")

func _on_SafeZone_body_entered(body):
	if body is Player:
		playerInSafeZone = true
	pass # Replace with function body.


func _on_SafeZone_body_exited(body):
	if body is Player:
		playerInSafeZone = false
	pass # Replace with function body.




func day_night():
	if(!night and $Nighttime.color.r < 1):
		$Nighttime.color.r+=timeChange
		$Nighttime.color.b+=timeChange
		$Nighttime.color.g+=timeChange
	if (night and $Nighttime.color.r > 0):
		$Nighttime.color.r-=timeChange
		$Nighttime.color.b-=timeChange
		$Nighttime.color.g-=timeChange


func _on_DNTimer_timeout():
	night = !night
	$Player.dayNightZoom(night)
	pass # Replace with function body.
