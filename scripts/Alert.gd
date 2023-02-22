extends Area2D

var maxRadius := 0
export var speedOfSound = 10


func _process(delta):
	if($CollisionShape2D.shape.radius < maxRadius):
		$CollisionShape2D.shape.radius += speedOfSound
	else:
		self.queue_free()


func _on_Alert_body_entered(body):
	if(body is Enemy):
		body.alert(position)
	pass # Replace with function body.
