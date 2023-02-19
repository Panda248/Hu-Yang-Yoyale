extends Label
class_name Notification

export var fadeSpeed = 5
export var yspeed = 1

func _ready():
	rect_global_position.x -= rect_size.x*rect_scale.x/2

func _process(delta):
	self_modulate.a-=fadeSpeed * delta * Engine.get_iterations_per_second()/100
	rect_global_position += Vector2.UP*yspeed * delta * Engine.get_iterations_per_second()
	if(self_modulate.a <= 0):
		queue_free()
	pass
