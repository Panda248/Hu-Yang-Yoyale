extends CanvasLayer

onready var shop = find_parent("World").find_node("ShopSystem")

func startDialog(name : String):
	if(!get_children()):
		var dialog = Dialogic.start(name)
		if(name == "shop"):
			dialog.connect("dialogic_signal", shop, 'dialogic_signal_event')
		add_child(dialog)
