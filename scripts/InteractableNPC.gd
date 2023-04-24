extends NPC
class_name InteractableNPC

signal start_dialog()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var dialogeTimeline : String
var canInteract : bool = false
export var message : String = "La Pepe"
export var chatYDisplacement : = 50
export (PackedScene) var ChatBox
var chatbox
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	emit_signal("start_dialog", dialogeTimeline)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(canInteract):
		slowly_rotate_to(player, delta*4)
		#$Indicator.set_visible(true);
	else:
		pass
		#emit_signal("delete_message", chatbox)
		#$Indicator.set_visible(false);
	pass



