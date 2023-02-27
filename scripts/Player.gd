extends Entity
class_name Player

signal player_shot(bullet, position, direction);
signal alert_enemies(alertRadius);
signal interact(interactable);
signal death_screen();

onready var equipped = $Equipped
onready var weapons = $Weapons
onready var heartbeat = $HeartBeat

export var weaponOffset = 12

var direction;
var targetInteractable

export (PackedScene) var Bullet;



# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0,0);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(!heartbeat.is_playing() and health < maxHealth):
		heartbeat.play()
		heartbeat.volume_db = 20 -50 * health/maxHealth
	var _motion = Vector2();
	
	get_node("Label").text = var2str(health)
	look_at(get_global_mouse_position());
	
	input_movement()
	input_action()
	
	direction = direction.normalized();
	
	var modifiedVelocity = (velocity - 40 * $Equipped.get_child(0).getWeight()) * (health+5)/15
	
	
	move_and_slide(direction * modifiedVelocity * delta * Engine.get_iterations_per_second());
	
	if _dead():
		emit_signal("death_screen")
	pass

func input_movement():
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

func input_action():
	if(equipped.get_child(0).has_method("input_action")):
		equipped.get_child(0).input_action()
	if Input.is_action_just_pressed("game_switch_weapon_left"):
		swap_weapon_left()
	elif Input.is_action_just_pressed("game_switch_weapon_right"):
		swap_weapon_right()
	elif Input.is_action_just_pressed("game_interact"):
		if(is_instance_valid(targetInteractable) and targetInteractable.canInteract):
			targetInteractable.interact()
		else:
			pick_up_nearby_items()
			pass

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
	.takeDamage(damage)
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

func swap_weapon_left() -> void:
	if(weapons.get_child_count() > 0):
			var nextWeapon = weapons.get_child(0)
			var prevWeapon = equipped.get_child(0)
			equipped.remove_child(prevWeapon)
			weapons.add_child(prevWeapon)
			weapons.remove_child(nextWeapon)
			equipped.add_child(nextWeapon)
			prevWeapon.set_owner(self)
			nextWeapon.set_owner(self)

func swap_weapon_right() -> void:
	if(weapons.get_child_count() > 0):
			var nextWeapon = weapons.get_child(weapons.get_child_count()-1)
			var prevWeapon = equipped.get_child(0)
			equipped.remove_child(prevWeapon)
			weapons.add_child(prevWeapon)
			weapons.remove_child(nextWeapon)
			weapons.move_child(prevWeapon, 0)
			equipped.add_child(nextWeapon)
			prevWeapon.set_owner(self)
			nextWeapon.set_owner(self)

func pick_up_weapon(weapon : Weapon):
	weapons.add_child(weapon)
	swap_weapon_right()
	equipped.get_child(0).position += Vector2.DOWN * weaponOffset

func get_weapons() -> Array:
	var weaponArr = weapons.get_children()
	weaponArr += equipped.get_children()
	return weaponArr
