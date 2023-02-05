extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var velocity = 50
export var health = 10

var motion = Vector2()

var state = IDLE

enum	{
	IDLE, CHASE
}

func _dead() ->bool:
	return health <= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#State machine
	match state:
		CHASE:
			_chase(delta)
	pass

func _chase(delta):
	look_at(get_node("%Player").position)
	motion = move_and_collide((get_node("%Player").position - position).normalized() * delta * velocity)
	pass


func _on_FOV_body_entered(body):
	if(body == get_node("%Player")):
		state = CHASE
	pass


func _on_FOV_body_exited(body):
	if(body == get_node("%Player")):
		state = IDLE
	pass # Replace with function body.

func takeDamage(damage : int):
	get_node("damageFlash").play("damageFlash")
	health -= damage
