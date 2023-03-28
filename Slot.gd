extends Button

var item = null



func remove():
	item = null

func add(item):
	item = item
	$TextureRect.texture = item.find_node("Icon").texture
	$Label.text = item.find_node("Quantity").text
