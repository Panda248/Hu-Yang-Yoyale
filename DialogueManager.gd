extends CanvasLayer

func startDialog(name : String):
	var dialog = Dialogic.start(name)
	add_child(dialog)
