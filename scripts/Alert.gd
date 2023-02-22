extends Area2D

var maxRadius := 0
export var speedOfSound = 10

func _ready():
	$CollisionShape2D.shape.radius = 1

func _process(delta):
	if($CollisionShape2D.shape.radius < maxRadius):
		$CollisionShape2D.shape.radius += speedOfSound*delta*Engine.get_iterations_per_second()
	else:
		free()


func _on_Alert_body_entered(body):
	if(body is Enemy):
		body.alert(position)
	pass # Replace with function body.
