extends NPC
class_name InteractableNPC

signal send_message(chatbox)
signal delete_message(chatbox)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var canInteract : bool = false
export var message : String = "La Pepe"
export var chatYDisplacement : = 50
export (PackedScene) var ChatBox
var chatbox
# Called when the node enters the scene tree for the first time.
func _ready():
	chatbox = ChatBox.instance();
	chatbox.text = message
	pass # Replace with function body.

func interact():
	chatbox.set_global_position(global_position + (Vector2.UP * chatYDisplacement))
	emit_signal("send_message", chatbox)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(canInteract):
		slowly_rotate_to(player, delta*4)
		$Indicator.set_visible(true);
	else:
		#emit_signal("delete_message", chatbox)
		$Indicator.set_visible(false);
	pass



