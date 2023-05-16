extends StaticBody2D


func _ready():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	var my_random_number = rng.randf_range(5, 10)
	self.scale *= my_random_number

#func _process(delta):
#	pass
