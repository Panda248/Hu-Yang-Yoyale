extends Label
class_name ChatBox

export var charactersPerSecond : float = 10
var displayCharacterCooldown : float = 1/charactersPerSecond
var curCharacterCooldown = displayCharacterCooldown
var display : bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	visible_characters = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(display):
		if (get_visible_characters() < get_total_character_count() && curCharacterCooldown <= 0):
			visible_characters += 1
			curCharacterCooldown = displayCharacterCooldown
			
	else:
		visible_characters = 0
	curCharacterCooldown -= delta
	pass

func show():
	display = true
func hide():
	display = false
