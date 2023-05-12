extends CanvasLayer

var justEntered = true

func _process(_delta):
	if(visible):
		if(!justEntered):
			if(Input.is_action_just_pressed("pause")):
				justEntered = true
				get_tree().set_pause(false)
				visible = false
		else:
			justEntered = false
	pass

func _on_ExitButton_pressed():
	get_tree().set_pause(false)
	get_tree().change_scene("res://Main Menu.tscn")
	justEntered = true
	pass # Replace with function body.


func _on_ResumeButton_pressed():
	get_tree().set_pause(false)
	visible = false
	justEntered = true
	pass # Replace with function body.
