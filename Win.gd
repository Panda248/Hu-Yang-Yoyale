extends Control

func _ready():
	if(randf() > 0.9):
		$yay.stream = load("res://res/source/pain.ogg")
	else:
		$yay.stream = load("res://res/source/win.ogg")
	$yay.play()

func _process(delta):
	if(Input.is_physical_key_pressed(KEY_ESCAPE)):
		get_tree().change_scene("res://Main Menu.tscn")

func _on_TextureRect_finished():
	get_tree().change_scene("res://Main Menu.tscn")
	pass # Replace with function body.


func _on_yay_finished():
	$yay.stop()
	$yay.stream_paused = true
	pass # Replace with function body.
