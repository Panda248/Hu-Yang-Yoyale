extends Label
class_name DamageNumber

export var fadeSpeed  : float = 4.5
export var MinimumYAccel : float = .2
export var MaximumYAccel : float = .5
export var MinimumYVel : float = 1
export var MaximumYVel : float = 2
export var MinimumXSpeed : float = .5
export var MaximumXSpeed : float = 1
onready var YAccel = rand_range(MinimumYAccel, MaximumYAccel)
onready var YVel = rand_range(MinimumYVel, MaximumYVel)
onready var XSpeed = rand_range(MinimumXSpeed, MaximumXSpeed) * (randi()%2-1)


func _process(delta):
	modulate.a -= fadeSpeed*delta*Engine.get_iterations_per_second()/100
	rect_global_position += Vector2.UP * YVel + Vector2.RIGHT * XSpeed * delta * Engine.get_iterations_per_second()
	YVel -= YAccel * delta * Engine.get_iterations_per_second()
	if(modulate.a <= 0):
		queue_free()
	pass
