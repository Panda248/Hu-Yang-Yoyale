extends Entity

signal player_shot(bullet, position, direction);

var direction;

export (PackedScene) var Bullet;


# Called when the node enters the scene tree for the first time.
func _ready():
	direction = Vector2(0,0);
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var _motion = Vector2();
	
	get_node("Label").text = var2str(health)
	look_at(get_global_mouse_position());
	
	input_movement()
	input_action()
	
	direction = direction.normalized();
	move_and_collide(direction * velocity * delta);
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
	if Input.is_action_just_pressed("game_primary_fire"):
		if($Equipped.get_child(0).has_method("primaryFire")):
			$Equipped.get_child(0).primaryFire()
			
	elif Input.is_action_just_pressed("game_secondary_fire"):
		if($Equipped.get_child(0).has_method("secondaryFire")):
			$Equipped.get_child(0).secondaryFire()
			
	elif Input.is_action_just_pressed("game_switch_weapon_left"):
		var nextWeapon = $Weapons.get_child(0)
		var prevWeapon = $Equipped.get_child(0)
		$Equipped.remove_child(prevWeapon)
		$Weapons.add_child(prevWeapon)
		$Weapons.remove_child(nextWeapon)
		$Equipped.add_child(nextWeapon)
		
	elif Input.is_action_just_pressed("game_switch_weapon_right"):
		var nextWeapon = $Weapons.get_child($Weapons.get_child_count()-1)
		var prevWeapon = $Equipped.get_child(0)
		$Equipped.remove_child(prevWeapon)
		$Weapons.add_child(prevWeapon)
		$Weapons.remove_child(nextWeapon)
		$Equipped.add_child(nextWeapon)
		
	


