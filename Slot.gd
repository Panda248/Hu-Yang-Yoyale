extends Button

var item = null

func remove():
	item = null
	$TextureRect.set_texture(null)
	$Label.set_text("")

func set_item(i):
	item = i
	if(is_instance_valid(i)):
		$TextureRect.set_texture(i.find_node("Icon").get_texture())
		$Label.set_text(i.find_node("Quantity").get_text())
	else:
		remove()
