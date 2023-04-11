extends CanvasLayer

onready var globalVariables = get_node("/root/GlobalVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	$ScreenShake/Slider.value = globalVariables.screenShakeIntensity
	$Volume/Slider.value = globalVariables.volume
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		exit()
	globalVariables.screenShakeIntensity = $ScreenShake/Slider.value
	globalVariables.volume = $Volume/Slider.value
	$ScreenShake/Visualizer.text = var2str(globalVariables.screenShakeIntensity)
	$Volume/Visualizer.text = var2str(globalVariables.volume)
	pass

func exit():
	get_tree().change_scene("res://Main Menu.tscn")


func _on_CheckButton_pressed():
	OS.window_fullscreen = $FullScreen/CheckButton.pressed
	pass # Replace with function body.
