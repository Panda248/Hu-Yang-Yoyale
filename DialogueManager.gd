extends CanvasLayer

func startDialog(name : String):
	if(!get_children()):
		var dialog = Dialogic.start(name)
		add_child(dialog)
