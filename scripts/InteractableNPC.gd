extends NPC
class_name InteractableNPC

signal send_message(chatbox)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var canInteract : bool = false
var interactable
var message : String = "La Pepe"
export var chatYDisplacement : = 50
export (PackedScene) var ChatBox
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func interact():
	var chatbox = ChatBox.instance();
	chatbox.text = message
	chatbox.set_global_position(global_position + (Vector2.UP * chatYDisplacement))
	emit_signal("send_message", chatbox)
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if(canInteract):
		look_at(player.position)
		$Indicator.set_visible(true);
	else:
		$Indicator.set_visible(false);
	pass



