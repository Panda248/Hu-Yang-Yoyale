extends Entity
class_name Player

signal player_shot(bullet, position, direction);
signal alert_enemies(alertRadius);
signal interact(interactable);
signal death_screen();

onready var inventory = $Inventory
onready var hotbar = $Inventory/Hotbar
onready var equipped = $Inventory/Equipped
onready var equippedWeapon = $Inventory/Equipped/Fists
onready var heartbeat = $HeartBeat
onready var gear = $Inventory/Gear

export var maxStamina = 100
export var staminaConsumption = .5
export var staminaRegeneration = 0.3
export var weaponOffset = 12
export var sneakMovementDebuff = 0.5
export var runMovementMultiplier = 1.5
export var sneakAlertRadius = 25
export var walkAlertRadius = 50
export var runAlertRadius = 300
export var timeToHeal = 3

export var totalShield = 0;
export var defaultZoom = 0.25
export  (PackedScene) var Alert
var curStamina = maxStamina
var direction;
var targetInteractable
var canHeal = false
var canSprint = true

# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0,0);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#shield_remaining()
	effectManager()
	
	if (health > maxHealth):
		health = maxHealth
	
	var _motion = Vector2();
	
	get_node("UI/ColorRect").color = Color(1,0,0,percent_health())
	if(health < maxHealth):
		if(!heartbeat.is_playing()):
			heartbeat.play()
			heartbeat.volume_db = 10 - 50 * health/maxHealth

	if(curStamina >= maxStamina):
		curStamina = maxStamina
	else:
		curStamina+=staminaRegeneration*delta*Engine.get_iterations_per_second()

	look_at(get_global_mouse_position());
	
	input_movement(delta)
	input_action()
	
	
	
	var modifiedVelocity = (velocity - 40 * equippedWeapon.getWeight()) * (health+5)/15
	
	
	move_and_slide(direction * modifiedVelocity * delta * Engine.get_iterations_per_second());
	
	if _dead():
		emit_signal("death_screen")
	pass

func input_movement(delta):
	if(Input.is_action_pressed("ui_left")):
		direction.x = -1;
	elif(Input.is_action_pressed("ui_right")):
		direction.x = 1;
	else:
		direction.x = 0;

	if(Input.is_action_pressed("ui_up")):
		direction.y = -1;
	elif(Input.is_action_pressed("ui_down")):
		direction.y = 1;
	else:
		direction.y = 0;
	
	direction = direction.normalized();
	if(direction == Vector2.ZERO):
		$Run.stop()
		$Sneak.stop()
	else:
		if(Input.is_action_pressed("game_run") and canSprint):
			curStamina-=staminaConsumption*delta*Engine.get_iterations_per_second()
			if(curStamina <= 0):
				curStamina = 0
				canSprint = false
			$Walk.stop()
			$Sneak.stop()
			direction*=runMovementMultiplier
			if(!$Run.is_playing()):
				$Run.play()
				alertEnemies(sneakAlertRadius)
		else:
			if(curStamina > maxStamina):
				curStamina = maxStamina
				canSprint = true
			if(Input.is_action_pressed("game_sneak")):
				$Run.stop()
				$Walk.stop()
				direction*=sneakMovementDebuff
				if(!$Sneak.is_playing()):
					$Sneak.play()
					alertEnemies(sneakAlertRadius)
			else:
				$Sneak.stop()
				$Run.stop()
				if(!$Walk.is_playing()):
					$Walk.play()
					alertEnemies(walkAlertRadius)

func input_action():
	if(!get_node("UI/Inventory").visible):
		if(weakref(equippedWeapon).get_ref() and equippedWeapon.has_method("input_action")):
			equippedWeapon.input_action()
	if Input.is_action_just_pressed("game_switch_weapon_left"):
		inventory.swap_weapon_left()
	elif Input.is_action_just_pressed("game_switch_weapon_right"):
		inventory.swap_weapon_right()
	elif Input.is_action_just_pressed("game_interact"):
		if(is_instance_valid(targetInteractable) and targetInteractable.canInteract):
			targetInteractable.interact()
		else:
			pick_up_nearby_items()

func _on_InteractBox_body_entered(body):
	if(body.has_method("interact")):
		if(closest_node(body, targetInteractable) == body):
			targetInteractable = body
			targetInteractable.canInteract = true
	
func _on_InteractBox_body_exited(body):
	if(targetInteractable == body):
		targetInteractable.canInteract = false
		targetInteractable = null

func takeDamage(damage):
	$HealTimer.wait_time = timeToHeal
	$HealTimer.start()
	.takeDamage(damage)
	get_node("UI/BloodSplatter").modulate.a = 1
	$Camera2D.add_trauma(damage)

func closest_node(node1, node2) -> Node:
	if(!is_instance_valid(node1)):
		return node2
	if(!is_instance_valid(node2)):
		return node1
	if(self.global_position.distance_to(node1.global_position) 
		< self.global_position.distance_to(node2.global_position)):
			return node1
	return node2

func pick_up_nearby_items() -> void:
	var overlappingAreas = $InteractBox.get_overlapping_areas()
	for area in overlappingAreas:
		if(area.has_method("pick_up")):
			area.pick_up(self)
	pass
	
func pick_up_weapon(weapon):
	hotbar.add_child(weapon)
	inventory.swap_weapon_right()
	equippedWeapon.position += Vector2.DOWN * weaponOffset

func get_hotbar() -> Array:
	return inventory.get_hotbar()

func get_gear() -> Array:
	return gear

func shield_remaining() -> float:
	var shield = 0;
	for obj in get_gear():
		shield += obj.get_shield()
	totalShield = shield
	return shield

func percent_health() -> float:
	return float(maxHealth-health)/float(maxHealth)

func alertEnemies(radius):
	var alert = get_node("/root/GlobalVariables").alert.instance()
	emit_signal("alert_enemies", alert, global_position, radius)

func setZoom(value):
	$Camera2D.targetZoom = Vector2(value,value)

func resetZoom():
	$Camera2D.targetZoom = Vector2(defaultZoom, defaultZoom)

func _on_HealTimer_timeout():
	if(health < maxHealth):
		health += 1
		healFX()
		$HealTimer.wait_time = timeToHeal
		$HealTimer.start()
	pass # Replace with function body.

var healTimer = 30;

func healFX():
	healTimer = 0

func effectManager():
	healTimer += 1
	if (healTimer < 30):
		$Effects/HealFX.visible = true
	else:
		$Effects/HealFX.visible = false
