extends Area2D
class_name Interactable

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var canInteract : bool = false
var interactable

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Interactable_area_entered(area):
	if(area.get_class() == "Interactable"):
		canInteract = true
		interactable = area
		print("pepe")
	pass # Replace with function body.


func _on_Interactable_area_exited(area):
	if(area == interactable):
		canInteract = false
		interactable = null
		print("popo")
	pass # Replace with function body.
