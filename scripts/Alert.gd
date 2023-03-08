extends Area2D
class_name Alert

var maxRadius := 0
export var speedOfSound = 10

var alertCircle
func setGlobalPosition(position):
	self.global_position = position
	
func setMaxRadius(radius):
	self.maxRadius = radius

func _ready():
	alertCircle = CollisionShape2D.new()
	alertCircle.shape = CircleShape2D.new()
	alertCircle.position = self.position
	alertCircle.shape.radius = 1
	alertCircle.modulate.a = 0.1
	add_child(alertCircle)

func _process(delta):
	if(expired()):
		self.queue_free()
		return
	self.alertCircle.shape.radius += speedOfSound*delta*Engine.get_iterations_per_second()

func expired() -> bool:
	return self.alertCircle.shape.radius > maxRadius

func _on_Alert_body_entered(body):
	if(body is Enemy):
		body.alert(position)
	pass # Replace with function body.
