class_name Enemy
extends NPC


# Declare member variables here. Examples:
# var a = 2
# var b = "text"




# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("World").get_node("Player")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_node("Label").text = var2str(health)
	#State machine
	match state:
		CHASE:
			_chase(delta)
		INVESTIGATE:
			_investigate(delta)
		ATTACK:
			_chase(delta)
			if randf() > 0.5:
				get_node("Fists").primaryFire()
			else:
				get_node("Fists").secondaryFire()
	pass

func _chase(delta):
	look_at(player.position)
	motion = move_and_slide((player.position - position).normalized() * velocity * delta*60)
	pass
func _investigate(delta):
	look_at(destination)
	motion = move_and_slide((destination - position).normalized() * velocity * delta*60)
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

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage



func _on_Range_body_entered(body):
	if(body == player):
		state = ATTACK
	pass # Replace with function body.


func _on_Range_body_exited(body):
	if(body == player):
		state = CHASE
	pass # Replace with function body.

func alert(position):
	destination = position
	state = INVESTIGATE
