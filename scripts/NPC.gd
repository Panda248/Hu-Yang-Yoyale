extends Entity
class_name NPC

export var fleshMin = 2
export var fleshMax= 5
export var dropsFlesh = false
export var rotationSpeedDegrees := 30
export var angleOfVisionDegrees := 30
export var maxViewDistance := 800.0
export var angleBetweenRaysDegrees := 5.0

onready var angleOfVision := deg2rad(angleOfVisionDegrees)
onready var angleBetweenRays := deg2rad(angleBetweenRaysDegrees)
onready var flesh = load("res://RottenFlesh.tscn")
onready var fleshCount = rand_range(fleshMin,fleshMax)

enum	{
	IDLE, CHASE, INVESTIGATE, ATTACK
}
var motion = Vector2()

var state = IDLE

var destination : Vector2;
var player


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("World").get_node("Player")
	pass # Replace with function body.
	
func slowly_rotate_to(target, delta):
	var targetPosition = (target if target is Vector2 else target.global_position)
	var direction = global_position.direction_to(targetPosition)
	var angleTo = direction.angle()
	var maxRotation = deg2rad(rotationSpeedDegrees)
	angleTo = lerp_angle(global_rotation, angleTo, 1.0)
	angleTo = clamp(angleTo, global_rotation - maxRotation, global_rotation + maxRotation)
	global_rotation = angleTo
	pass

func takeDamage(amt):
	.takeDamage(amt)
	if _dead() and dropsFlesh:
		dropFlesh()

func dropFlesh():
	var fleshInstance = flesh.instance()
	for i in range(fleshCount):
		fleshInstance.global_position = self.global_position+ Vector2(rand_range(-20,20), rand_range(-20,20))
		find_parent("World").spawn_item(fleshInstance)
