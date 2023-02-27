extends CanvasLayer
class_name MainMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var splashScreen = $SplashScreen

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	splashScreen.scale*=1.0001
	pass


func _on_Play_pressed():
	get_tree().change_scene("res://World.tscn")
	pass # Replace with function body.


func _on_Settings_pressed():
	get_tree().change_scene("res://Settings.tscn")
	pass # Replace with function body.


func _on_Quit_pressed():
	get_tree().quit()
	pass # Replace with function body.
