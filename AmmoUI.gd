extends Control

func _ready():
	pass
	
func _process(delta):
	$AmmoLabel.text = var2str(find_parent("Player").equipped.get_child(0).getCurClip()) + "/" + var2str(find_parent("Player").equipped.get_child(0).getRemainingAmmo())
