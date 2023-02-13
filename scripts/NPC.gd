extends Entity
class_name NPC

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
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
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
