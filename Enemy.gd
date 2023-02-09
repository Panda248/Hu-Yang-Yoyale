extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocity = 50
export var health = 10

var motion = Vector2()

var state = IDLE

var destination : Vector2;

enum	{
	IDLE, CHASE, INVESTIGATE, ATTACK
}

func _dead() ->bool:
	return health <= 0

# Called when the node enters the scene tree for the first time.
func _ready():
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
			look_at(get_node("%Player").position)
			if randf() > 0.5:
				get_node("Fists").primaryFire()
				
				get_node("Fists").secondaryFire()
	pass

func _chase(delta):
	look_at(get_node("%Player").position)
	motion = move_and_collide((get_node("%Player").position - position).normalized() * delta * velocity)
	pass
func _investigate(delta):
	look_at(destination)
	motion = move_and_collide((destination - position).normalized() * delta * velocity)
	if position.distance_to(destination) < 10:
		state = IDLE
	pass

func _on_FOV_body_entered(body):
	if(body == get_node("%Player")):
		state = CHASE
	pass


func _on_FOV_body_exited(body):
	if(body == get_node("%Player")):
		destination = get_node("%Player").position
		state = INVESTIGATE
	pass # Replace with function body.

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage

func takeKnockback(hitbox : HitBox):
	move_and_collide((hitbox.get_owner().position.direction_to(self.position))*hitbox.knockback)

func _on_Range_body_entered(body):
	if(body == get_node("%Player")):
		state = ATTACK
	pass # Replace with function body.


func _on_Range_body_exited(body):
	if(body == get_node("%Player")):
		state = CHASE
	pass # Replace with function body.
