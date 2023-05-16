extends NPC

var playerInMeleeRange = false

func _ready():
	$FOV/RayCast2D.cast_to = Vector2(maxViewDistance, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Health/HealthBar/HealthLabel.set_rotation(-rotation)
	._process(delta)
	if _dead():
		queue_free()
	raycast_sweep()
	get_node("Label").text = var2str(state)
	if(get_parent().playerInSafeZone):
		state = IDLE
	#State machine
	match state:
		CHASE:
			spinShot()
		INVESTIGATE:
			_investigate(delta)
		ATTACK:
			if (player.position.distance_to(self.position) < 300):
				spinShot()
				get_node("PoisonThrower").primaryFire()
			else:
				get_node("PoisonThrower").fireRate = 300;
				_chase(delta)
				get_node("PoisonThrower").primaryFire()
	pass

var jumping
var peaked

func jump():
	get_node("Body/Sprite").texture = load("res://res/exported/sprites/frogjump.png")
	jumping = true
	peaked = false

var rotationdegrees = 0

func spinShot():
	get_node("PoisonThrower").fireRate = 2;
	
	rotationdegrees += 0.1
	print(rotation_degrees)
	rotationdegrees = clamp(rotationdegrees, 0, 360)
	global_rotation = rotationdegrees
	pass

func _chase(delta):
	if(can_see_player()):
		if (!jumping):
			slowly_rotate_to(player, delta)
			velocity = 100
		else:
			velocity = 150
			if (get_node("Body/Sprite").scale.x < 0.85 && !peaked):
				get_node("Body/Sprite").scale += Vector2(0.001, 0.001)
			if (get_node("Body/Sprite").scale.x >= 0.85):
				peaked = true;
			if (peaked && get_node("Body/Sprite").scale.x > 0.65):
				get_node("Body/Sprite").scale -= Vector2(0.001, 0.001);
			if (peaked && get_node("Body/Sprite").scale.x == 0.65):
				jumping = false
				get_node("Body/Sprite").texture = load("res://res/exported/sprites/frog.png")
		move_forward(delta)
	else:
		destination = player.position
		state = INVESTIGATE
	pass

func _investigate(delta):
	slowly_rotate_to(destination, delta)
	if(can_see_player()):
		state = CHASE
		pass
	if(abs(get_angle_to(destination)) < deg2rad(10)):
		motion = move_and_slide((destination - position).normalized() * velocity * delta * Engine.get_iterations_per_second())
	if position.distance_to(destination) < 10:
		state = IDLE
	pass

func _on_FOV_body_entered(body):
	if(body == player):
		state = CHASE
	pass

func _on_FOV_body_exited(body):
	if(body == player):
		alert(body.position)
	pass # Replace with function body.

func _on_Range_body_entered(body):
	if(body == player):
		playerInMeleeRange = true
	pass # Replace with function body.


func _on_Range_body_exited(body):
	if(body == player):
		playerInMeleeRange = true
	pass # Replace with function body.

func alert(position):
	if(state != ATTACK or state != CHASE):
		destination = position
		state = INVESTIGATE
		$alert.visible = true
		$alertTimer.start()
	

func can_see_player() -> bool:
	var castCount := angleOfVision / angleBetweenRays
	
	for index in castCount:
		var cast_vector := (
			maxViewDistance * Vector2.RIGHT.rotated(angleBetweenRays * (index - castCount / 2.0))
		)
		$FOV/RayCast2D.cast_to = cast_vector
		$FOV/RayCast2D.force_raycast_update()
		if $FOV/RayCast2D.is_colliding() and $FOV/RayCast2D.get_collider() is Player:
			return true
	return false

func raycast_sweep() -> void:
	if(can_see_player()):
		if (player.position.distance_to(self.position) < 500):
			playerInMeleeRange = true;
		if(playerInMeleeRange):
			state = ATTACK
			return
		if state != ATTACK:
			state = CHASE


func _on_alertTimer_timeout():
	$alert.visible = false
	pass # Replace with function body.


func _on_jumpTimer_timeout():
	jump()
