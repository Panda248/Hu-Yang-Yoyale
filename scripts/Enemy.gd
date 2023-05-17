class_name Enemy
extends NPC


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var playerInMeleeRange = false
export var attackCooldown = 1
var canAttack = true

# Called when the node enters the scene tree for the first time.
func _ready():
	$Body.modulate = Color.white
	$FOV/RayCast2D.cast_to = Vector2(maxViewDistance, 0)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	._process(delta)
	if _dead():
		queue_free()
	if(!frozen):
		raycast_sweep()
		get_node("Label").text = var2str(state)
		
		#State machine
		match state:
			CHASE:
				if(get_parent().playerInSafeZone):
					state = IDLE
					pass
				_chase(delta)
			INVESTIGATE:
				_investigate(delta)
			ATTACK:
				_chase(delta)

				if(canAttack):
					canAttack = false
					$attackTimer.start(attackCooldown)
					if randf() > 0.5:
						get_node("Fists").primaryFire()
					else:
						get_node("Fists").secondaryFire()


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
		motion = move_and_slide((destination - position).normalized() * velocity)
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
		$alertTimer.start()
		$alert.visible = true
	

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
		if state != ATTACK:
			state = CHASE
			print("chasing")
			pass
		if(playerInMeleeRange):
			state = ATTACK
			print("attacking")

func _on_alertTimer_timeout():
	$alert.visible = false;
	pass # Replace with function body.


func _on_attackTimer_timeout():
	canAttack = true
	pass # Replace with function body.


func _on_soundTimer_timeout():
	if (self.position.distance_to(find_parent("World").find_node("Player").position) < 700):
		$Sound.play()
