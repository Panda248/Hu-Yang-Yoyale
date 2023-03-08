extends Area2D
class_name Alert

var maxRadius := 0
export var speedOfSound = 10


func _ready():
		$CollisionShape2D.shape.radius = 1

func _process(delta):
	if(expired()):
		queue_free()
		return
	$CollisionShape2D.shape.radius += speedOfSound*delta*Engine.get_iterations_per_second()

func expired() -> bool:
	return $CollisionShape2D.shape.radius >  maxRadius

func _on_Alert_body_entered(body):
	if(body is Enemy):
		body.alert(position)
	pass # Replace with function body.
