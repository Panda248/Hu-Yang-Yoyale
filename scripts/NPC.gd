extends Entity
class_name NPC

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var rotationSpeedDegrees := 30
export var angleOfVisionDegrees := 30
export var maxViewDistance := 800.0
export var angleBetweenRaysDegrees := 5.0
var angleOfVision := deg2rad(angleOfVisionDegrees)
var angleBetweenRays := deg2rad(angleBetweenRaysDegrees)

enum	{
	IDLE, CHASE, INVESTIGATE, ATTACK
}
var motion = Vector2()

var state = IDLE

var destination : Vector2;
var player


func _dead() ->bool:
	return health <= 0

# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_tree().get_root().get_node("World").get_node("Player")
	pass # Replace with function body.
	
func slowly_rotate_to(target, delta):
	var targetPosition = (target if target is Vector2 else target.global_position)
	var direction = global_position.direction_to(targetPosition)
	var angleTo = direction.angle()
	var maxRotation = deg2rad(rotationSpeedDegrees) * delta
	angleTo = lerp_angle(global_rotation, angleTo, 1.0)
	angleTo = clamp(angleTo, global_rotation - maxRotation, global_rotation + maxRotation)
	global_rotation = angleTo
	pass

