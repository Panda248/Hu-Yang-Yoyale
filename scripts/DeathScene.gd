extends CanvasLayer
class_name DeathScreen

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var respawn = $Respawn
onready var mainMenu = $"Main Menu"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Main_Menu_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://Main Menu.tscn")
	pass # Replace with function body.


func _on_Respawn_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.
