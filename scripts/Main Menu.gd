extends CanvasLayer
class_name MainMenu

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var splashScreen = $SplashScreen
var  zoomIn : bool = true
onready var timer = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	timer+=1
	if(timer%60 == 0):
		if($Title.modulate == Color(1,1,1)):
			$Title.modulate = Color(0,0,0)
		elif($Title.modulate == Color(0,0,0)):
			$Title.modulate = Color(1,1,1)
	if(zoomIn):
		if(splashScreen.scale.x <= .535):
			zoomIn = false
		splashScreen.scale*=.999
	else:
		if(splashScreen.scale.x >= 1):
			zoomIn = true
		splashScreen.scale*=1.001
		
		
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
