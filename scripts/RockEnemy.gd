extends NPC

var playerInMeleeRange = false

func _ready():
	$FOV/RayCast2D.cast_to = Vector2(maxViewDistance, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _dead():
		queue_free()
	raycast_sweep()
	get_node("Label").text = var2str(state)
	if(get_parent().playerInSafeZone):
		state = IDLE
	#State machine
	match state:
		CHASE:
			_chase(delta)
		INVESTIGATE:
			_investigate(delta)
		ATTACK:
			_chase(delta)
			get_node("RockThrower").primaryFire()
	pass

func _chase(delta):
	if(can_see_player()):
		slowly_rotate_to(player, delta)
		move_forward(delta)
	#motion = move_and_slide((player.position - position).normalized() * velocity * delta*60)
	else :
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
		if (player.position.distance_to(self.position) < 100):
			playerInMeleeRange = true;
		if(playerInMeleeRange):
			state = ATTACK
			return
		if state != ATTACK:
			state = CHASE
