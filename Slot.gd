extends Panel

var ItemClass = preload("res://Item.tscn")
var item = null



func _process(delta):
	pass

func remove():
	print("reoved")
	remove_child(item)
	var inventoryNode = find_parent("Inventory")
	inventoryNode.add_child(item)
	item = null

func add(new_item):
	print("sdf")
	item = new_item
	if(new_item.find_parent("Inventory")):
		var inventoryNode = find_parent("Inventory")
		inventoryNode.remove_child(new_item)
	else:
		var parent = new_item.get_parent()
		parent.remove_child(new_item)
	add_child(item)
	item.global_position = rect_global_position + rect_size*rect_scale/4
