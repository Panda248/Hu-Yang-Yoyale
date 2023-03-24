extends Camera2D

export var traumaDecay = 2 
export var maxOffset = 50  
export var maxRoll = 0.1  
export var traumaMultiplier = 1

onready var noise = OpenSimplexNoise.new()
onready var screenShakeIntensity = get_node("/root/GlobalVariables").screenShakeIntensity
onready var maxOffsetVector = Vector2(maxOffset * screenShakeIntensity, maxOffset * screenShakeIntensity)
var trauma = 0.0  # Current shake strength.
var trauma_power = 3  # Trauma exponent. Use [2, 3]
var noise_y = 0
var targetZoom = Vector2(0.25,0.25)
var zoomSpeed = 5

func _ready():
	randomize()
	noise.seed = randi()
	noise.period = 4
	noise.octaves = 2

func add_trauma(amount):
	trauma = min(trauma + (amount * traumaMultiplier), 1.0)
	
func _process(delta):
	if zoom != targetZoom:
		if abs(targetZoom.x-zoom.x) < 0.001:
			zoom = targetZoom
		zoom += (targetZoom-zoom)*zoomSpeed*delta
	if trauma:
		trauma = max(trauma - traumaDecay * delta, 0)
		shake()
		
func shake():
	var amount = pow(trauma, trauma_power)
	noise_y += 1
	rotation = maxRoll * amount * noise.get_noise_2d(noise.seed, noise_y)
	offset.x = maxOffsetVector.x * amount * noise.get_noise_2d(noise.seed*2, noise_y)
	offset.y = maxOffsetVector.y * amount * noise.get_noise_2d(noise.seed*3, noise_y)

func breathe():
	pass
