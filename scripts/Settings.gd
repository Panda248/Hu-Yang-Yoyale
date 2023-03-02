extends CanvasLayer


onready var globalVariables = get_node("/root/GlobalVariables")
# Called when the node enters the scene tree for the first time.
func _ready():
	$ScreenShake/Slider.value = globalVariables.screenShakeIntensity
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		exit()
	globalVariables.screenShakeIntensity = $ScreenShake/Slider.value
	$ScreenShake/Visualizer.text = var2str(globalVariables.screenShakeIntensity)
	pass

func exit():
	get_tree().change_scene("res://Main Menu.tscn")
