extends Label

export var drawSpeed := 1
var show : bool = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.visible_characters = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(show):
		if (get_total_character_count() < get_total_character_count()):
			self.visible_characters += drawSpeed
	else:
		self.visible_characters = 0
	pass

func show():
	show = true
func hide():
	show = false
